# Installing Claude Code

This guide will walk you through installing Claude Code on various platforms and setting up your environment for optimal use.

## Prerequisites

- **Node.js**: Version 18 or higher
- **npm**: Comes with Node.js
- **Terminal**: Any modern terminal (Terminal, iTerm2, Windows Terminal, etc.)
- **Anthropic API Key**: Get yours at [console.anthropic.com](https://console.anthropic.com)

## Installation Methods

### 1. Global Installation (Recommended)

```bash
npm install -g @anthropic-ai/claude-code
```

This installs Claude Code globally, making the `claude` command available from anywhere.

### 2. Using npx (No Installation)

```bash
npx @anthropic-ai/claude-code
```

This runs Claude Code without installing it permanently.

### 3. Local Project Installation

```bash
npm install --save-dev @anthropic-ai/claude-code
```

Then add to your `package.json`:
```json
{
  "scripts": {
    "claude": "claude"
  }
}
```

Run with: `npm run claude`

## Platform-Specific Instructions

### macOS

1. Install Node.js using Homebrew:
```bash
brew install node
```

2. Install Claude Code:
```bash
npm install -g @anthropic-ai/claude-code
```

3. Set up your API key:
```bash
export ANTHROPIC_API_KEY="your-api-key-here"
```

Add to `~/.zshrc` or `~/.bash_profile` to make it permanent.

### Windows

1. Install Node.js from [nodejs.org](https://nodejs.org)

2. Open PowerShell or Command Prompt as Administrator

3. Install Claude Code:
```powershell
npm install -g @anthropic-ai/claude-code
```

4. Set up your API key:
```powershell
# PowerShell
$env:ANTHROPIC_API_KEY="your-api-key-here"

# Or permanently:
[Environment]::SetEnvironmentVariable("ANTHROPIC_API_KEY", "your-api-key-here", "User")
```

### Linux

1. Install Node.js:
```bash
# Ubuntu/Debian
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs

# Fedora
sudo dnf install nodejs

# Arch
sudo pacman -S nodejs npm
```

2. Install Claude Code:
```bash
npm install -g @anthropic-ai/claude-code
```

3. Set up your API key:
```bash
export ANTHROPIC_API_KEY="your-api-key-here"
```

Add to `~/.bashrc` or `~/.profile` to make it permanent.

## Setting Up Your API Key

### Method 1: Environment Variable (Recommended)

```bash
export ANTHROPIC_API_KEY="sk-ant-your-key-here"
```

### Method 2: Configuration File

Create `~/.claude/claude.json`:
```json
{
  "apiKey": "sk-ant-your-key-here"
}
```

### Method 3: Pass at Runtime

```bash
claude --api-key "sk-ant-your-key-here"
```

## Verifying Installation

1. Check Claude Code version:
```bash
claude --version
```

2. Test basic functionality:
```bash
claude --help
```

3. Start your first session:
```bash
claude
```

You should see:
```
Welcome to Claude Code!
Type your message or /help for commands.
>
```

## Common Installation Issues

### Permission Denied

If you get permission errors during global install:

**macOS/Linux:**
```bash
sudo npm install -g @anthropic-ai/claude-code
```

**Windows:**
Run PowerShell as Administrator

### Node Version Too Old

Check your Node version:
```bash
node --version
```

If below v18, update Node.js:
- **macOS**: `brew upgrade node`
- **Windows**: Download latest from nodejs.org
- **Linux**: Use your package manager or nvm

### npm Not Found

If npm is not found after installing Node.js:
- Restart your terminal
- Check PATH includes npm:
  ```bash
  echo $PATH | grep npm
  ```

### Behind Corporate Proxy

Configure npm to use your proxy:
```bash
npm config set proxy http://proxy.company.com:8080
npm config set https-proxy http://proxy.company.com:8080
```

See [Corporate Proxy Guide](../07-integrations/corporate-proxy.md) for detailed setup.

## Docker Installation

For containerized environments:

```dockerfile
FROM node:18-alpine
RUN npm install -g @anthropic-ai/claude-code
ENV ANTHROPIC_API_KEY="your-key-here"
CMD ["claude"]
```

Build and run:
```bash
docker build -t claude-code .
docker run -it -v $(pwd):/workspace claude-code
```

## VS Code Integration

If using VS Code, you can also:

1. Install Claude Code globally as above
2. Open integrated terminal in VS Code
3. Run `claude` directly in your project

## Next Steps

Once installed, proceed to:
- [First Session Guide](./first-session.md) - Start coding with Claude
- [Basic Commands](./basic-commands.md) - Learn essential commands
- [MCP Servers Setup](../03-mcp-servers/installing-servers.md) - Extend functionality

## Updating Claude Code

To update to the latest version:

```bash
npm update -g @anthropic-ai/claude-code
```

Check for updates:
```bash
npm outdated -g @anthropic-ai/claude-code
```

## Uninstalling

If you need to uninstall:

```bash
npm uninstall -g @anthropic-ai/claude-code
```

This removes Claude Code but preserves your configuration files in `~/.claude/`.