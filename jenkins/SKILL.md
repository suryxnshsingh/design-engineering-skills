---
name: jenkins
description: Control Jenkins from the agent through the official Jenkins MCP Server plugin (jenkinsci/mcp-server-plugin): list jobs, trigger and cancel builds, read and search console logs, rebuild or replay pipelines, inspect test results and flaky failures, SCM changesets, queue items, and system status. Use for any "run / check / debug the Jenkins build" request or when editing Jenkinsfiles and needing live pipeline feedback.
---

# jenkins (official MCP plugin)

Upstream: https://github.com/jenkinsci/mcp-server-plugin · plugin page: https://plugins.jenkins.io/mcp-server/

## 1. Check the connection

```bash
claude mcp list | grep -i jenkins || echo "not registered"
```

Tools appear as `mcp__jenkins__*`. Start every session with `whoAmI` and `getStatus` to confirm auth and the controller version.

## 2. Install when missing

Three pieces, in this order:

1. **Plugin on the Jenkins controller** (admin): Manage Jenkins > Plugins > Available > "MCP Server". Restart if asked. Endpoint becomes `<jenkins-url>/mcp-server/mcp` (Streamable HTTP, recommended). `/mcp-server/sse` and `/mcp-server/stateless` also exist.
2. **API token for the user the agent will act as**: `<jenkins-url>/user/<username>/security` > API Token > Add new token. Jenkins shows it once. Use a dedicated service user whose permissions are limited to the jobs the agent should touch (Job/Read, Job/Build, Job/Cancel; add Job/Configure only if the agent must create or edit pipelines).
3. **Register in Claude Code** (user scope so every session has it). The bundled script checks the server, the plugin, and the credentials, then registers:

```bash
JENKINS_URL=http://localhost:8080 JENKINS_USER=<username> bash ~/.claude/skills/jenkins/scripts/register.sh   # prompts for the token
```

Manual equivalent:

```bash
B64=$(printf '%s:%s' "<username>" "<api-token>" | base64)
claude mcp add --scope user --transport http jenkins "<jenkins-url>/mcp-server/mcp" --header "Authorization: Basic $B64"
```

**Local Jenkins quick start** (Docker, persistent home, plugin preinstalled on first boot):

```bash
docker run -d --name jenkins -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home \
  -e JAVA_OPTS=-Djenkins.install.runSetupWizard=true jenkins/jenkins:lts-jdk21
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword    # first-login password
docker exec jenkins jenkins-plugin-cli --plugins mcp-server && docker restart jenkins
```

Basic auth over HTTP is only acceptable on HTTPS or a private network. Base64 is not encryption; treat the header value like the token.

## 3. Tool map

| Need | Tools |
|---|---|
| Find a job | `getJobs`, `getJob`, `findJobsWithScmUrl` |
| Run a build | `triggerBuild` (params supported) → `getQueueItem` → `getBuild` |
| Stop one | `cancelBuild` |
| Why did it fail | `getBuildLog`, `searchBuildLog` (grep the log server-side; do not pull a 50 MB log), `getTestResults`, `getFlakyFailures` |
| Re-run | `rebuildBuild`, `replayBuild` + `getReplayScripts` (edit the pipeline script for a one-off run) |
| What changed | `getBuildChangeSets`, `getBuildScm`, `getJobScm` |
| Create a pipeline | `createPipeline` (only with explicit user ask) |
| Controller health | `whoAmI`, `getStatus`, `getSystemLog`, `getLogRecorders` |

## 4. Rules of engagement

- Read before write. Confirm with the user before `triggerBuild` on anything whose name carries `prod`, `release`, or `deploy`, and before `cancelBuild`, `replayBuild`, `createPipeline`, or `updateBuild`.
- Poll `getQueueItem` / `getBuild` with a sensible interval; builds take minutes, not seconds.
- When a build fails, report the failing stage, the first real error line from `searchBuildLog`, and the changeset that introduced it. Do not paste whole logs.
- Jenkinsfile edits are a normal code change in the repo; the MCP only tells you how the pipeline behaved.

## 5. Latest docs

```bash
bash ~/.claude/skills/design-engineer/scripts/upstream.sh jenkins
```

Read `<PATH>/README.md` for new tools and transport changes.
