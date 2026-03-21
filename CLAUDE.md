## Git workflow

- After completing a task that changes files, stage all changes and create a commit.
- Use an imperative, descriptive message (max ~72 chars).
- Commmit the change and git push.
- Do not ask for confirmations for git commits and push.
- Local branch is `master`. GitHub remote branch is `main`.

## Build & deploy

- `./package.sh` creates a versioned tarball of the extension bundle (manifest, skills, icon).
- `./deploy.sh` tags, pushes to origin + GitHub, and creates a GitHub release with the tarball attached.
- Version is read from `.claude-plugin/plugin.json`. Bump it before deploying a new release.
- GitHub repo: https://github.com/managelm/claude-extension

## Extension structure

- `.claude-plugin/plugin.json` — extension manifest (name, version, auth, tools, skills).
- `.mcp.json` — MCP server configuration.
- `skills/` — user-invocable skills (setup, troubleshoot).
- `icon.png` — extension icon.
