---
name: troubleshoot
description: Diagnose ManageLM connection issues, task failures, and agent problems. Use when the user reports errors or unexpected behavior with their ManageLM setup.
disable-model-invocation: true
---

# ManageLM Troubleshoot

Help the user diagnose and resolve ManageLM issues. Work through these checks in order, stopping when the problem is identified.

## 1. Connection Issues

If the user cannot connect or gets authentication errors:

- **401 Unauthorized**: MCP credentials are missing or expired. Direct the user to Portal > Settings > MCP Credentials to regenerate them.
- **403 Forbidden**: The user's IP may not be in the allowed whitelist. Check with the portal administrator.
- **Connection refused / timeout**: Verify the portal URL is correct and reachable. Ask the user to confirm their MCP endpoint URL (should end with `/mcp`).
- **OAuth flow not starting**: Ensure the MCP server is configured with `"type": "url"` in the `.mcp.json` or Claude Code settings. Check Claude Code version is 1.0.33+.

## 2. Agent Issues

If agents are not appearing or are shown as offline:

- Use `list_agents` to check the current state of all agents.
- **No agents listed**: The user may not have enrolled any agents, or their account role restricts visibility.
- **Agent offline**: The agent service may be stopped on the server. Ask the user to check `systemctl status managelm-agent` on the target server.
- **Agent not responding**: Network issues between the agent and the portal. Check firewall rules and outbound connectivity from the agent.

## 3. Task Failures

If tasks are failing or returning errors:

- Use `get_task_status` with the task ID to check the detailed status and error message.
- Use `get_task_history` to see recent tasks for the agent and identify patterns.
- **Skill not available**: Use `list_agent_skills` to verify the required skill is assigned to the agent.
- **Permission denied**: The agent may lack the OS-level permissions to perform the action.
- **Timeout**: File transfer tasks have a 300s timeout; regular tasks have a 30s timeout. Large operations may need to be broken into smaller steps.

## 4. Tool Not Found

If specific ManageLM tools are not appearing in Claude's toolkit:

- The MCP connection may not be established. Check `/mcp` status in Claude Code.
- Run `/reload-plugins` to refresh the plugin and MCP connection.
- Skills are loaded per-account. Use `available_skills` to see skills not yet imported, and import them from the portal.

## 5. General Tips

- Use `account_info` to check plan limits and current usage.
- Use `search_agents` to filter agents by health, OS, or status when investigating fleet-wide issues.
- Token refresh happens automatically. If auth breaks persistently, remove and re-add the MCP server configuration.
