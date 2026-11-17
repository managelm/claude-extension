---
name: manage-servers
description: Work on the user's Linux and Windows servers through ManageLM. Use when the user asks about their servers or fleet (status, health, what runs where, security findings, logins, SSH or sudo access, certificates, backups, monitors, cloud VMs) or wants something checked, changed, scanned, transferred or reverted on a server.
---

# Managing servers with ManageLM

ManageLM runs operations on the servers ("agents") in the user's account, with the user's own permissions. The user is usually a sysadmin or DevOps engineer. The user's explicit instructions take priority over this skill.

## Find the server first

- Call `search_agents` when you do not have the server yet (filters: query, status, group, site, cpu_above, memory_above, disk_above). Never guess a hostname or ID.
- Refer to servers by hostname or display name, never by ID.
- `get_agent_info` gives details on one server; `get_agent_skills` shows which skills it can run.

## Answer fleet questions with searches

Searches read data ManageLM already holds: they run nothing on the servers and do not count against the daily task limit. Prefer them over tasks for questions.

| Question | Tool |
|----------|------|
| What runs where, installed packages, containers | `search_inventory` |
| Security findings, vulnerabilities, threat alerts, exposures | `search_security` |
| Logins, failed logins, sudo commands, file changes | `search_activity` |
| SSH keys, sudo rules and admin rights | `search_ssh_keys`, `search_sudo_rules` |
| Certificates on the servers / certificates ManageLM issues | `search_certificates` / `search_pki` |
| Monitors, backups, scheduled tasks | `search_monitors`, `search_backups`, `search_schedules` |
| Credentials and keystore keys | `search_credentials`, `search_keystore` |

Always narrow a search (query, group, site, severity, category, status, since): an unfiltered search on a large fleet can be too big to return. For a security summary, search by severity (critical, then high) rather than everything at once. Some of these tools appear only when the feature is enabled on the account.

## Run tasks

Each skill is a tool (`base`, `packages`, `services`, `users`, `firewall`, `webserver`, and so on). Pass a `target` and a specific `instruction` that includes paths, service names and values.

- `target` is a hostname or display name, a group, a site, or `all`. When the user names a capability instead of a server ("create an AD user"), pass `auto` and ManageLM routes the task to the server that has that skill. If it answers that several servers qualify, ask the user which one; never choose for them.
- `base` is read-only: use it for files, disk usage, processes and system information.
- Before a change that is hard to undo (removing packages or users, stopping services, firewall rules that could cut access) or that targets a group, a site or `all`, say in one line what will change and where, and wait for a yes. Approving the tool call is not enough: the user needs to know the impact first.
- A task that returns `needs_input` asks a question (a domain name, a choice). Ask the user, then call `answer_task`. If the next answer asks again, use the task ID from the latest response, not the original one.
- If a task is still running when the tool returns, tell the user and check it later with `get_task_status`.

## Transfer files

Use the `files` tool with `path` (absolute, on the server) and `content` for text or `content_base64` for binary files: this writes the file directly, without the agent's LLM. Never put file content in `instruction`. An upload does not replace an existing file unless `overwrite` is true: ask before overwriting. To fetch a file, set `instruction` to `download <path>`. In Claude Code, read the local file first and pass its content; write a downloaded file locally only where the user asked.

## Scans

`run_security_audit`, `run_inventory_scan`, `run_access_scan`, `run_certificate_scan` and `run_activity_scan` take a hostname, a group, a site or `all` (not `auto`) and need the Reports Admin permission. To read results that already exist, use the matching search instead of running a new scan.

## Review and revert

Use `get_task_history` for recent tasks on a server and `get_task_changes` (with `full_diff` for the diff) for what a task changed. Before `revert_task`, show the changes and get a yes. If a revert fails, check `get_task_changes` again before retrying.

## Cloud VMs

Find the VM with `search_cloud`, check the available actions and their risk with `get_cloud_info`, and get an explicit yes naming the VM and the action before `cloud_action`. If several VMs match, ask which one. If an action fails, check the VM with `search_cloud` before retrying; never repeat it blindly.

## Limits

- Credentials and keystore keys are metadata only: secret values and key material can never be retrieved. Say so if asked.
- Approving servers and managing users, skills, groups, API keys and webhooks happen in the ManageLM portal, not here.
- On an account set to No LLM there are no skill tools: searches and scans still work.
- Errors: an offline server cannot run tasks; a reached daily task limit blocks new tasks until the next day; a permission error means the user's role lacks that permission or access to that server. Tell the user plainly.

## Response style

- Be concise and technical. Lead with the answer, not the process.
- For servers: hostname, status, OS, IP, and CPU, memory and disk when available.
- For task results: the summary and the relevant output in code blocks.
- For security findings: group by severity, critical first.
- Use tables for lists.
