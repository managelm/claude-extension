# ManageLM — Claude Code Extension

Manage your Linux servers directly from Claude using natural language.

ManageLM connects Claude to your infrastructure through a secure cloud portal
and lightweight agents running on your servers. Ask Claude to check system
status, manage packages, configure services, transfer files, and more — across
one server or an entire fleet.

## Installation

### From the Marketplace

```bash
claude plugin install managelm
```

### From GitHub

```bash
claude plugin install managelm@your-marketplace
```

### Local Testing

```bash
claude --plugin-dir ./path/to/this/directory
```

### Manual MCP Configuration

Add to your Claude Code settings (`~/.claude/settings.json`) or project
`.mcp.json`:

```json
{
  "mcpServers": {
    "managelm": {
      "type": "url",
      "url": "https://your-portal.example.com/mcp"
    }
  }
}
```

## Authentication

ManageLM uses **OAuth 2.0 with PKCE**. On first connection Claude will open
your browser to authorize access. You need:

1. A ManageLM account
2. MCP credentials enabled (Portal > Settings > MCP Credentials)

Access tokens expire after 30 minutes and are automatically refreshed.

Legacy header-based auth (`X-MCP-Id` / `X-MCP-Secret`) is also supported for
programmatic use.

## What You Can Do

Once connected, Claude has access to skill-based tools and discovery tools
covering all aspects of Linux server management.

### Skill-Based Tools

Each skill accepts a `target` (hostname, group, or `"all"`) and a free-text
`instruction` describing what you want done.

| Skill | Description |
|-------|-------------|
| **base** | Core read-only utilities — read files, search content, check system info, monitor resources, network diagnostics |
| **system** | System administration — OS info, performance tuning, hostname, timezone, kernel parameters, reboot |
| **packages** | Package management — install, remove, update, search across apt/dnf/yum/pacman/zypper/apk |
| **services** | Service and process management — systemd units, cron jobs, logs, process control |
| **users** | User and access management — accounts, groups, SSH keys, sudo, password policies |
| **network** | Network management — interfaces, routes, DNS, ports, connectivity testing, traffic analysis |
| **security** | Security hardening — audits, fail2ban, SSH hardening, SELinux/AppArmor, SSL/TLS, auth logs |
| **files** | File management — read, write, upload, download files (text and binary) |
| ...and more | Firewall, Docker/Podman, Apache/Nginx, MySQL/PostgreSQL, backup, certificates, git, DNS, VPN, Kubernetes, etc. |

Use `available_skills` to discover additional skills you can import from the
built-in catalog.

### Discovery & Management Tools

| Tool | Description |
|------|-------------|
| `list_agents` | List all servers with status, OS, health metrics, groups |
| `agent_info` | Detailed info for a single server: health, skills, recent tasks |
| `list_agent_skills` | See assigned and available skills for a server |
| `available_skills` | Discover skills not yet imported into your account |
| `account_info` | Check account plan, usage limits, and current consumption |
| `search_agents` | Filter servers by CPU/memory/disk usage, OS, status, or group |
| `search_inventory` | Search installed packages, running services, containers across all servers |
| `search_security` | Search security audit findings across all servers |
| `get_task_status` | Check status of a running or completed task |
| `get_task_history` | Review recent tasks for a server |
| `task_changes` | View file changes made by a task |
| `revert_task` | Revert file changes from a previous task |

### Targeting

Every skill-based tool accepts a `target` parameter:

- **Hostname** — run on a single server (e.g., `web-prod-1`)
- **Group name** — run on all servers in a group (e.g., `production`)
- **`"all"`** — broadcast to every server you have access to

## Skills

This extension includes two user-invocable skills:

- `/managelm:setup` — Walk through connecting Claude to your ManageLM portal
- `/managelm:troubleshoot` — Diagnose connection, agent, or task issues

## Example Usage

```
> Check disk usage on web-prod-1

> Install nginx on all servers in the staging group

> Upload my local config.yml to /etc/myapp/config.yml on db-primary

> Show me the last 50 lines of /var/log/syslog on monitoring-1

> Which servers have CPU usage above 80%?

> Search for any security findings related to SSH across all servers

> What packages are installed on web-prod-1 that match "python"?
```

## Requirements

- **ManageLM Portal** — your hosted control plane ([managelm.com](https://www.managelm.com))
- **ManageLM Agent** — installed on each managed Linux server
- **Claude Code v1.0.33+** or Claude Desktop with MCP support

## Links

- [ManageLM Website](https://www.managelm.com)
- [Documentation](https://www.managelm.com/doc/)
- [GitHub](https://github.com/managelm/claude-extension)

## License

[MIT](LICENSE)
