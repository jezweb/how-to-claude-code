# Installing MCP Servers

This guide covers everything you need to know about installing and managing MCP servers on Linux, macOS, and Windows.

## Quick Start

```bash
# Install an MCP server with our interactive script
curl -sSL https://raw.githubusercontent.com/jezweb/how-to-claude-code/main/scripts/install-mcp-server.sh | bash

# Or install manually
npx jina-mcp-tools  # Test the server
# Then add to your Claude configuration
```

## Understanding Claude Configuration

### Configuration File Location

Claude stores its configuration in different locations depending on your system:

**Linux:**
```bash
~/.claude.json                    # Most common location
~/.config/claude/claude.json     # Alternative location
~/.claude/claude.json            # Legacy location
```

**macOS:**
```bash
~/.claude.json                    # Most common location
~/Library/Application Support/Claude/claude.json
```

**Windows:**
```cmd
%USERPROFILE%\.claude.json
%APPDATA%\Claude\claude.json
```

### Finding Your Configuration

```bash
# Find your Claude configuration file
find ~ -name ".claude.json" -o -name "claude.json" 2>/dev/null | grep -v node_modules

# Or use our helper script
./scripts/find-claude-config.sh
```

## Configuration Structure

The Claude configuration file is a JSON file with this structure:

```json
{
  "mcpServers": {
    "server-name": {
      "command": "npx",
      "args": ["server-package-name"],
      "env": {
        "API_KEY": "${API_KEY}",
        "OTHER_CONFIG": "value"
      }
    }
  },
  // ... other configuration
}
```

## Manual Installation Process

### Step 1: Backup Your Configuration

**Always backup before making changes:**

```bash
cp ~/.claude.json ~/.claude.json.backup
```

### Step 2: Understand the Server Requirements

Before installing, check:
- Required environment variables (API keys, etc.)
- Node.js version requirements
- Any system dependencies

### Step 3: Test the Server

Test the server works before adding to configuration:

```bash
# Test with npx
npx @modelcontextprotocol/server-name

# Or install globally and test
npm install -g @modelcontextprotocol/server-name
mcp-server-name --version
```

### Step 4: Add to Configuration

#### Using Python (Recommended for Large Files)

```python
#!/usr/bin/env python3
import json
import sys

# Read configuration
with open(os.path.expanduser('~/.claude.json'), 'r') as f:
    config = json.load(f)

# Add new server
config['mcpServers']['new-server'] = {
    'command': 'npx',
    'args': ['@modelcontextprotocol/server-name'],
    'env': {
        'API_KEY': '${API_KEY}'  # Use environment variable
    }
}

# Write back
with open(os.path.expanduser('~/.claude.json'), 'w') as f:
    json.dump(config, f, indent=2)
```

#### Using jq (Command Line)

```bash
# Add a new MCP server using jq
jq '.mcpServers["new-server"] = {
  "command": "npx",
  "args": ["@modelcontextprotocol/server-name"],
  "env": {"API_KEY": "${API_KEY}"}
}' ~/.claude.json > ~/.claude.json.tmp && mv ~/.claude.json.tmp ~/.claude.json
```

### Step 5: Set Environment Variables

```bash
# Add to your shell profile (~/.bashrc, ~/.zshrc, etc.)
export API_KEY="your-api-key-here"

# Or create a .env file
echo "API_KEY=your-api-key-here" >> ~/.claude-env
```

### Step 6: Restart Claude

After making changes, restart Claude for them to take effect.

## Automated Installation

### Using the Interactive Script

We provide an interactive installation script that handles all the complexity:

```bash
# Download and run the installer
curl -sSL https://raw.githubusercontent.com/jezweb/how-to-claude-code/main/scripts/install-mcp-server.sh -o install-mcp.sh
chmod +x install-mcp.sh
./install-mcp.sh
```

The script will:
1. Find your Claude configuration automatically
2. Create a backup
3. Show available MCP servers
4. Guide you through configuration
5. Validate the installation

### Quick Install Scripts

For popular servers, use our quick install scripts:

```bash
# Install Jina MCP server
./scripts/quick-install/install-jina.sh

# Install GitHub MCP server
./scripts/quick-install/install-github.sh

# Install all Cloudflare servers
./scripts/quick-install/install-cloudflare.sh
```

## Common Installation Scenarios

### Installing Multiple Servers

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/home/user/projects"]
    },
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    },
    "jina-mcp-tools": {
      "command": "npx",
      "args": ["jina-mcp-tools"],
      "env": {
        "JINA_API_KEY": "${JINA_API_KEY}"
      }
    }
  }
}
```

### Installing from GitHub

Some MCP servers are available directly from GitHub:

```bash
# Install from GitHub repository
npm install -g username/repo-name

# Add to configuration
{
  "mcpServers": {
    "custom-server": {
      "command": "custom-mcp-server",
      "args": ["--config", "/path/to/config"]
    }
  }
}
```

### Using Local Development Servers

For development or custom servers:

```json
{
  "mcpServers": {
    "local-dev-server": {
      "command": "/home/user/projects/my-mcp-server/index.js",
      "args": ["--debug"],
      "env": {
        "NODE_ENV": "development"
      }
    }
  }
}
```

## Environment Variable Management

### Security Best Practices

**Never hardcode sensitive values:**

```json
// ❌ BAD - Never do this
{
  "env": {
    "API_KEY": "sk-actual-api-key-here"
  }
}

// ✅ GOOD - Use environment variables
{
  "env": {
    "API_KEY": "${API_KEY}"
  }
}
```

### Setting Environment Variables

**Linux/macOS:**
```bash
# Temporary (current session)
export API_KEY="your-key-here"

# Permanent (add to ~/.bashrc or ~/.zshrc)
echo 'export API_KEY="your-key-here"' >> ~/.bashrc
source ~/.bashrc

# Using a dedicated file
cat >> ~/.claude-env << EOF
export GITHUB_TOKEN="ghp_..."
export JINA_API_KEY="jina_..."
export OPENAI_API_KEY="sk-..."
EOF

# Source in your shell profile
echo 'source ~/.claude-env' >> ~/.bashrc
```

**Windows:**
```powershell
# PowerShell
[Environment]::SetEnvironmentVariable("API_KEY", "your-key-here", "User")

# Command Prompt
setx API_KEY "your-key-here"
```

### Using .env Files

Create a `.env` file for your API keys:

```bash
# .env
GITHUB_TOKEN=ghp_your_token_here
JINA_API_KEY=jina_your_key_here
ANTHROPIC_API_KEY=sk-ant-your_key_here
```

Then source it before starting Claude:
```bash
export $(cat .env | xargs)
claude
```

## Troubleshooting Installation

### Common Issues

#### Configuration File Too Large

**Problem**: "File content exceeds maximum allowed size"

**Solution**: Use our Python script or jq instead of manual editing:
```bash
python3 scripts/mcp-manager.py add-server new-server
```

#### JSON Syntax Errors

**Problem**: "Unexpected token in JSON"

**Solution**: Validate your JSON:
```bash
# Validate JSON syntax
python3 -m json.tool ~/.claude.json > /dev/null
# or
jq . ~/.claude.json > /dev/null
```

#### Server Not Starting

**Problem**: MCP server fails to start

**Debug steps:**
```bash
# 1. Test the server directly
npx server-name --version

# 2. Check logs
tail -f ~/.config/Code*/logs/*/mcp*.log

# 3. Verify environment variables
echo $API_KEY

# 4. Check permissions
ls -la ~/.claude.json
```

#### Permission Denied

**Problem**: Cannot modify configuration file

**Solution**:
```bash
# Fix file permissions
chmod 644 ~/.claude.json

# Fix directory permissions
chmod 755 ~/.claude/
```

### Validation Checklist

After installation, verify:

- [ ] Configuration file is valid JSON
- [ ] Server appears in mcpServers section
- [ ] Environment variables are set
- [ ] Claude can start without errors
- [ ] Server responds to commands

## Advanced Installation

### Conditional Server Loading

Load servers based on environment:

```json
{
  "mcpServers": {
    "dev-server": {
      "command": "npx",
      "args": ["dev-mcp-server"],
      "condition": "${NODE_ENV} === 'development'"
    }
  }
}
```

### Server Dependencies

Some servers require others to be running:

```json
{
  "mcpServers": {
    "database": {
      "command": "mcp-database-server"
    },
    "api-server": {
      "command": "mcp-api-server",
      "dependsOn": ["database"]
    }
  }
}
```

### Custom Server Arguments

Pass dynamic arguments to servers:

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "${HOME}/projects",
        "--read-only=${READ_ONLY:-false}"
      ]
    }
  }
}
```

## Managing Installed Servers

### List Installed Servers

```bash
# Using our MCP manager
python3 scripts/mcp-manager.py list

# Or manually with jq
jq '.mcpServers | keys' ~/.claude.json
```

### Remove a Server

```bash
# Using our MCP manager
python3 scripts/mcp-manager.py remove server-name

# Or manually with jq
jq 'del(.mcpServers["server-name"])' ~/.claude.json > ~/.claude.json.tmp && mv ~/.claude.json.tmp ~/.claude.json
```

### Update Server Configuration

```bash
# Using our MCP manager
python3 scripts/mcp-manager.py update server-name --env API_KEY='${NEW_API_KEY}'

# Or manually
jq '.mcpServers["server-name"].env.API_KEY = "${NEW_API_KEY}"' ~/.claude.json > ~/.claude.json.tmp && mv ~/.claude.json.tmp ~/.claude.json
```

## Platform-Specific Notes

### Linux

- Configuration typically in `~/.claude.json`
- Use package managers for global installs: `sudo npm install -g`
- Set environment variables in `~/.bashrc` or `~/.zshrc`
- Check AppArmor/SELinux permissions if servers fail

### macOS

- May need to grant permissions in System Preferences
- Use Homebrew for Node.js: `brew install node`
- Environment variables in `~/.zshrc` (default shell)
- Check Gatekeeper settings for unsigned servers

### Windows

- Run as Administrator for global npm installs
- Use PowerShell for better Unix-like commands
- Environment variables in System Properties
- Check Windows Defender/antivirus for blocked servers

## Best Practices

1. **Always Backup** - Before any configuration change
2. **Test First** - Verify servers work before adding
3. **Use Environment Variables** - Never hardcode secrets
4. **Document Your Setup** - Keep notes on installed servers
5. **Regular Updates** - Keep servers updated for security
6. **Minimal Permissions** - Only grant necessary access
7. **Version Control** - Track configuration changes

## Quick Reference

### Essential Commands

```bash
# Find config file
find ~ -name ".claude.json" 2>/dev/null

# Backup config
cp ~/.claude.json ~/.claude.json.backup

# Validate JSON
python3 -m json.tool ~/.claude.json

# List servers
jq '.mcpServers | keys' ~/.claude.json

# Test server
npx server-name --version

# Check logs
tail -f ~/.config/Code*/logs/*/mcp*.log
```

### Installation One-Liners

```bash
# Context7 MCP (FREE - no API key needed!)
curl -sSL https://raw.githubusercontent.com/jezweb/how-to-claude-code/main/scripts/quick-install/install-context7.sh | bash

# Jina MCP
curl -sSL https://raw.githubusercontent.com/jezweb/how-to-claude-code/main/scripts/quick-install/install-jina.sh | bash

# GitHub MCP
curl -sSL https://raw.githubusercontent.com/jezweb/how-to-claude-code/main/scripts/quick-install/install-github.sh | bash

# Playwright MCP
curl -sSL https://raw.githubusercontent.com/jezweb/how-to-claude-code/main/scripts/quick-install/install-playwright.sh | bash

# Interactive installer
curl -sSL https://raw.githubusercontent.com/jezweb/how-to-claude-code/main/scripts/install-mcp-server.sh | bash
```

## Getting Help

If you encounter issues:

1. Check the [troubleshooting section](#troubleshooting-installation)
2. Review server-specific documentation
3. Check Claude logs for error messages
4. Ask in the community forums
5. Report issues on the server's GitHub repository

## Next Steps

- Explore [Popular MCP Servers](./popular-servers/)
- Learn about [Configuring Servers](./configuring-servers.md)
- Read [Security Best Practices](./security-considerations.md)
- Try the [Interactive Installer](../scripts/install-mcp-server.sh)