---
name: troubleshoot
description: Diagnose ManageLM connection problems, missing tools, offline servers and failed tasks. Use when the user reports an error or unexpected behavior with ManageLM in Claude.
---

# ManageLM troubleshooting

Work through these checks in order and stop when you find the cause.

## 1. Connection and sign-in

- **Sign-in fails or tools answer "unauthorized"**: the sign-in did not complete, or the access was revoked (for example after the user reset their MCP credentials in Portal > Settings > MCP & API, or an admin revoked MCP access). Sign in again:
  - claude.ai and Cowork: in the ManageLM plugin's **Connectors** tab (or Customize > Connectors for a custom connector), disconnect `managelm` and connect it again.
  - Claude Code: run `/mcp`, select the ManageLM server (`plugin:managelm:managelm` when it comes from the plugin) and authenticate again.
- **Forbidden from every tool**: the user may have an MCP / API Key IP whitelist in Portal > Settings > MCP & API. In claude.ai and Cowork, ManageLM is called from Anthropic's servers, so Anthropic's outbound IP addresses must be in that list. In Claude Code, the calls come from the user's own machine.
- **Self-hosted portal not reachable**: the MCP address must end with `/mcp` and be served over HTTPS. In claude.ai and Cowork it must also be reachable from the internet; a portal on a private network can publish only its MCP and OAuth endpoints with `PUBLIC_URL` (see the portal documentation) and use `<PUBLIC_URL>/mcp`. In Claude Code it must be reachable from the user's machine.
- **Claude Code shows two ManageLM servers**: with a self-hosted portal, the plugin's SaaS server (`plugin:managelm:managelm`) stays unauthenticated. Disable it in `/mcp`.

## 2. Servers

- Call `search_agents` with no filters to see every server the user can access.
- **No servers listed**: no agent is enrolled and approved yet, or the user's role restricts which servers they see.
- **Server offline**: the agent service is stopped or cannot reach the portal. On Linux, check `systemctl status managelm-agent` on the server; on Windows, check the ManageLM agent service in Services. The agent connects outbound only, so check outbound HTTPS from the server to the portal.

## 3. Tasks

- `get_task_status` with the task ID shows the detailed status and error.
- `get_task_history` shows recent tasks on that server and any pattern of failures.
- **Skill not available**: `get_agent_skills` shows whether the skill is assigned to the server. Skills are assigned in the portal.
- **Task limit reached**: the account's daily task limit is used up; `get_account_info` shows plan limits and usage. Searches do not count against it.
- **Permission denied on the server**: the agent lacks the OS-level rights for that action.
- **Timeout**: tasks and file transfers stop after the portal's task timeout (300 seconds by default). Split large operations into smaller steps.

## 4. Missing tools

- Skill tools exist only for skills imported into the account; `list_available_skills` shows catalog skills not imported yet. An account set to No LLM has no skill tools.
- Some search tools appear only when their feature is enabled on the account, and the hosting tools only once a hosting connector exists.
- The tool list is read when the connection starts. After skills or features change, start a new conversation (claude.ai and Cowork) or run `/reload-plugins` (Claude Code).
