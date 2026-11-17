---
name: setup
description: Connect ManageLM to Claude and check that it works. Use right after the plugin is installed, or when the user asks how to set up, connect or sign in to ManageLM, or how to use a self-hosted ManageLM portal.
---

# ManageLM setup

Walk the user through these steps in order, and stop as soon as the connection works.

1. **Account and agents**: ManageLM needs an account (free for up to 10 agents at https://app.managelm.com/register) and the ManageLM agent installed and approved on each server, from the portal's Agents page. Without an approved agent there is nothing to manage yet.

2. **Sign in**: the plugin connects to ManageLM SaaS (`https://app.managelm.com/mcp`). The user signs in with their ManageLM account (and MFA if enabled) and authorizes access. Nothing has to be generated in the portal first: Claude registers itself through OAuth. Claude then acts with that user's own permissions.
   - **claude.ai and Cowork**: open the ManageLM plugin under Customize > Plugins, go to its **Connectors** tab and connect `managelm`. The sign-in page opens in the browser.
   - **Claude Code**: the sign-in page opens on first use. If it does not, run `/mcp`, select `plugin:managelm:managelm` and choose Authenticate.

3. **Self-hosted portal**: the plugin always points to SaaS. The MCP address of a self-hosted portal is `https://<portal>/mcp` and must end with `/mcp`.
   - **claude.ai and Cowork**: add it as a custom connector under Customize > Connectors (on Team and Enterprise plans, an Owner adds it for the organization). The plugin's skills keep working with it. The Claude apps reach ManageLM from Anthropic's servers, so the portal must be reachable over HTTPS from the internet. A portal kept on a private network can publish only its MCP and OAuth endpoints with `PUBLIC_URL` and use `<PUBLIC_URL>/mcp`.
   - **Claude Code**: add the portal with `claude mcp add --transport http managelm https://<portal>/mcp`, then run `/mcp`, select `plugin:managelm:managelm` (the plugin's SaaS server) and disable it, so only the portal's tools remain.

4. **Check the connection**: call `search_agents` with no filters and show the servers with their status. Then call `get_account_info` and mention the plan and how many agents are in use.

5. **First steps**: suggest two or three things to try, based on what you found, for example "Which servers have critical security findings?", "Which certificates expire this month?" or "Check the disk usage on <a server you listed>".

If a step fails, use the troubleshoot skill.
