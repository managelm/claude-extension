# Changelog

All notable changes to the ManageLM Claude extension will be documented in this file.

## [1.0.0] - 2025-03-21

### Added

- Initial release of the ManageLM Claude Code extension.
- MCP server configuration with OAuth 2.0 PKCE authentication.
- `/managelm:setup` skill to guide users through connection configuration.
- `/managelm:troubleshoot` skill to diagnose connection and task issues.
- Full server management via ~30 skill-based MCP tools: system, packages, services, files, users, network, security, and more.
- Multi-server targeting by hostname, group, or broadcast to all.
- File transfer support (text and binary) up to configured limits.
- Discovery tools: `list_agents`, `agent_info`, `list_agent_skills`, `available_skills`, `account_info`.
- Task management: `get_task_status`, `get_task_history`, `task_changes`, `revert_task`.
- Cross-agent search: `search_inventory`, `search_security`, `search_agents`.
