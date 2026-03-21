---
name: setup
description: Help the user configure their ManageLM connection to Claude Code. Use when the user asks to set up, configure, or connect ManageLM.
disable-model-invocation: true
---

# ManageLM Setup

Guide the user through connecting Claude to their ManageLM portal:

1. **Get the portal URL**: Ask the user for their ManageLM portal URL (e.g., `https://app.managelm.com`).

2. **Configure the MCP endpoint**: The MCP endpoint is `{portal_url}/mcp`. Update the user's Claude Code MCP settings (`~/.claude/settings.json` or project `.mcp.json`) to point to it:
   ```json
   {
     "mcpServers": {
       "managelm": {
         "type": "url",
         "url": "https://app.managelm.com/mcp"
       }
     }
   }
   ```

3. **Authentication**: ManageLM uses OAuth 2.0 with PKCE. On first connection, Claude will open a browser window for the user to authorize access. The user must have a ManageLM account with MCP credentials enabled (found in Settings > MCP Credentials).

4. **Verify the connection**: After setup, use the `list_agents` tool to verify the connection works and show available servers.

## Troubleshooting

- **401 Unauthorized**: MCP credentials may not be generated yet. Direct the user to their ManageLM portal Settings > MCP Credentials to generate them.
- **Connection refused**: Verify the portal URL is correct and accessible from this machine.
- **No agents listed**: The user may not have any agents enrolled, or their account role may restrict agent visibility.
- **Token expired**: Access tokens expire after 30 minutes and are automatically refreshed. If issues persist, re-authenticate by removing and re-adding the MCP server configuration.
