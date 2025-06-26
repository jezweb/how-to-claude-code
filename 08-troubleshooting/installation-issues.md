# Installation Issues and Solutions

This guide covers common installation problems and their solutions for Claude Code and related tools.

## Claude Code Installation Issues

### Node.js Version Problems

**Issue**: Claude Code requires Node.js 18 or higher
```bash
Error: Claude Code requires Node.js version 18 or higher. You have version 16.x.x
```

**Solutions**:

1. **Update Node.js using nvm (Recommended)**:
   ```bash
   # Install/update nvm
   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
   
   # Restart terminal or source profile
   source ~/.bashrc
   
   # Install latest LTS Node.js
   nvm install --lts
   nvm use --lts
   nvm alias default node
   ```

2. **Update Node.js using package manager**:
   ```bash
   # macOS with Homebrew
   brew update
   brew upgrade node
   
   # Ubuntu/Debian
   curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
   sudo apt-get install -y nodejs
   
   # Windows - download from nodejs.org
   ```

3. **Check Node version**:
   ```bash
   node --version
   npm --version
   ```

### Permission Denied Errors

**Issue**: Cannot install globally due to permissions
```bash
Error: EACCES: permission denied, mkdir '/usr/local/lib/node_modules/@anthropic-ai'
```

**Solutions**:

1. **Fix npm permissions (Recommended)**:
   ```bash
   # Create directory for global packages
   mkdir ~/.npm-global
   
   # Configure npm to use new directory
   npm config set prefix '~/.npm-global'
   
   # Add to PATH in ~/.bashrc or ~/.zshrc
   echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.bashrc
   source ~/.bashrc
   
   # Now install globally
   npm install -g @anthropic-ai/claude-code
   ```

2. **Use sudo (not recommended for security)**:
   ```bash
   sudo npm install -g @anthropic-ai/claude-code
   ```

3. **Use npx instead**:
   ```bash
   npx @anthropic-ai/claude-code
   ```

### Network and Proxy Issues

**Issue**: Installation fails due to network/proxy
```bash
Error: connect ECONNREFUSED 127.0.0.1:8080
```

**Solutions**:

1. **Configure npm proxy**:
   ```bash
   npm config set proxy http://proxy.company.com:8080
   npm config set https-proxy http://proxy.company.com:8080
   
   # With authentication
   npm config set proxy http://username:password@proxy.company.com:8080
   ```

2. **Use different registry**:
   ```bash
   npm config set registry https://registry.npmjs.org/
   
   # Or use yarn
   yarn global add @anthropic-ai/claude-code
   ```

3. **Check firewall/VPN**:
   - Disable VPN temporarily
   - Check corporate firewall settings
   - Try from different network

### Package Not Found

**Issue**: Package not found or version mismatch
```bash
Error: 404 Not Found - GET https://registry.npmjs.org/@anthropic-ai/claude-code
```

**Solutions**:

1. **Clear npm cache**:
   ```bash
   npm cache clean --force
   npm install -g @anthropic-ai/claude-code
   ```

2. **Check package name**:
   ```bash
   # Correct package name
   npm install -g @anthropic-ai/claude-code
   
   # Not claude-code or @claude/code
   ```

3. **Update npm**:
   ```bash
   npm install -g npm@latest
   ```

## API Key Configuration Issues

### API Key Not Found

**Issue**: Claude Code can't find API key
```bash
Error: Anthropic API key not found. Please set ANTHROPIC_API_KEY environment variable.
```

**Solutions**:

1. **Set environment variable**:
   ```bash
   # Temporary (current session)
   export ANTHROPIC_API_KEY="sk-ant-your-key-here"
   
   # Permanent (add to shell profile)
   echo 'export ANTHROPIC_API_KEY="sk-ant-your-key-here"' >> ~/.bashrc
   source ~/.bashrc
   ```

2. **Create config file**:
   ```bash
   mkdir -p ~/.claude
   echo '{"apiKey": "sk-ant-your-key-here"}' > ~/.claude/claude.json
   ```

3. **Pass at runtime**:
   ```bash
   claude --api-key "sk-ant-your-key-here"
   ```

### Invalid API Key

**Issue**: API key format or validity issues
```bash
Error: Invalid API key format
```

**Solutions**:

1. **Check key format**:
   - Should start with `sk-ant-`
   - Should be base64-encoded
   - No extra spaces or characters

2. **Generate new key**:
   - Go to [console.anthropic.com](https://console.anthropic.com)
   - Create new API key
   - Copy exactly as shown

3. **Check key permissions**:
   - Ensure key has necessary permissions
   - Check usage limits
   - Verify account status

## MCP Server Installation Issues

### MCP Server Not Found

**Issue**: MCP server package not found
```bash
Error: Cannot find module '@modelcontextprotocol/server-filesystem'
```

**Solutions**:

1. **Install MCP server globally**:
   ```bash
   npm install -g @modelcontextprotocol/server-filesystem
   ```

2. **Use npx in configuration**:
   ```json
   {
     "mcpServers": {
       "filesystem": {
         "command": "npx",
         "args": ["-y", "@modelcontextprotocol/server-filesystem"]
       }
     }
   }
   ```

3. **Check package name**:
   ```bash
   # Search for available MCP servers
   npm search @modelcontextprotocol
   ```

### MCP Server Won't Start

**Issue**: Server fails to start or connect
```bash
Error: MCP server 'filesystem' failed to start
```

**Solutions**:

1. **Check server logs**:
   ```bash
   # Run server directly to see errors
   npx @modelcontextprotocol/server-filesystem
   ```

2. **Verify configuration**:
   ```json
   {
     "mcpServers": {
       "filesystem": {
         "command": "npx",
         "args": ["-y", "@modelcontextprotocol/server-filesystem", "/allowed/path"],
         "env": {
           "NODE_ENV": "production"
         }
       }
     }
   }
   ```

3. **Check permissions**:
   - Ensure directories exist
   - Check read/write permissions
   - Verify user access rights

### MCP Authentication Issues

**Issue**: MCP server authentication fails
```bash
Error: Authentication failed for MCP server 'github'
```

**Solutions**:

1. **Check environment variables**:
   ```bash
   # Verify token is set
   echo $GITHUB_TOKEN
   
   # Set if missing
   export GITHUB_TOKEN="ghp_your-token-here"
   ```

2. **Test token manually**:
   ```bash
   curl -H "Authorization: token $GITHUB_TOKEN" https://api.github.com/user
   ```

3. **Regenerate tokens**:
   - Create new API tokens
   - Update environment variables
   - Restart Claude Code

## Platform-Specific Issues

### Windows Issues

**Issue**: Command not found on Windows
```cmd
'claude' is not recognized as an internal or external command
```

**Solutions**:

1. **Check PATH**:
   ```cmd
   echo %PATH%
   
   # Add npm global directory to PATH
   # Usually: C:\Users\username\AppData\Roaming\npm
   ```

2. **Use full path**:
   ```cmd
   C:\Users\username\AppData\Roaming\npm\claude.cmd
   ```

3. **Reinstall with proper permissions**:
   ```cmd
   # Run as Administrator
   npm install -g @anthropic-ai/claude-code
   ```

### macOS Issues

**Issue**: Permission denied on macOS
```bash
Error: EACCES: permission denied, mkdir '/usr/local/lib/node_modules'
```

**Solutions**:

1. **Fix npm permissions**:
   ```bash
   sudo chown -R $(whoami) /usr/local/lib/node_modules
   ```

2. **Use Homebrew Node**:
   ```bash
   brew uninstall node
   brew install node
   npm install -g @anthropic-ai/claude-code
   ```

3. **Use nvm**:
   ```bash
   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
   nvm install node
   nvm use node
   ```

### Linux Issues

**Issue**: Missing dependencies on Linux
```bash
Error: Cannot find Python executable
```

**Solutions**:

1. **Install build tools**:
   ```bash
   # Ubuntu/Debian
   sudo apt-get install build-essential python3
   
   # CentOS/RHEL
   sudo yum groupinstall "Development Tools"
   sudo yum install python3
   
   # Arch Linux
   sudo pacman -S base-devel python
   ```

2. **Install Node.js properly**:
   ```bash
   # Using NodeSource repository
   curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
   sudo apt-get install -y nodejs
   ```

## Docker Installation Issues

### Docker Build Failures

**Issue**: Docker build fails during installation
```dockerfile
Error: Cannot find module '@anthropic-ai/claude-code'
```

**Solutions**:

1. **Multi-stage Dockerfile**:
   ```dockerfile
   FROM node:18-alpine as builder
   RUN npm install -g @anthropic-ai/claude-code
   
   FROM node:18-alpine
   COPY --from=builder /usr/local/lib/node_modules/@anthropic-ai/claude-code /usr/local/lib/node_modules/@anthropic-ai/claude-code
   COPY --from=builder /usr/local/bin/claude /usr/local/bin/claude
   ENV ANTHROPIC_API_KEY=""
   CMD ["claude"]
   ```

2. **Handle npm cache**:
   ```dockerfile
   FROM node:18
   RUN npm cache clean --force
   RUN npm install -g @anthropic-ai/claude-code
   ```

### Container Permission Issues

**Issue**: Permission denied in container
```bash
Error: EACCES: permission denied, open '/workspace/.claude/claude.json'
```

**Solutions**:

1. **Fix volume permissions**:
   ```bash
   docker run -it -v $(pwd):/workspace -u $(id -u):$(id -g) claude-code
   ```

2. **Use USER directive**:
   ```dockerfile
   FROM node:18
   RUN npm install -g @anthropic-ai/claude-code
   USER node
   WORKDIR /workspace
   CMD ["claude"]
   ```

## Configuration File Issues

### Invalid JSON

**Issue**: Configuration file has syntax errors
```bash
Error: Unexpected token in JSON at position 123
```

**Solutions**:

1. **Validate JSON**:
   ```bash
   cat ~/.claude/claude.json | jq .
   
   # Or use online JSON validator
   ```

2. **Reset configuration**:
   ```bash
   # Backup existing config
   cp ~/.claude/claude.json ~/.claude/claude.json.backup
   
   # Create minimal config
   echo '{"mcpServers": {}}' > ~/.claude/claude.json
   ```

### Configuration Not Found

**Issue**: Claude Code can't find configuration
```bash
Error: Configuration file not found
```

**Solutions**:

1. **Create config directory**:
   ```bash
   mkdir -p ~/.claude
   ```

2. **Check file permissions**:
   ```bash
   ls -la ~/.claude/
   chmod 644 ~/.claude/claude.json
   ```

3. **Use project config**:
   ```bash
   mkdir -p .claude
   echo '{"mcpServers": {}}' > .claude/claude.json
   ```

## Getting Help

### Diagnostic Information

When reporting issues, include:

```bash
# System information
node --version
npm --version
claude --version

# Operating system
uname -a  # Linux/macOS
systeminfo  # Windows

# Configuration
cat ~/.claude/claude.json

# Environment variables
env | grep ANTHROPIC
env | grep NODE
```

### Debug Mode

Enable debug logging:

```bash
# Set debug environment variable
export DEBUG=claude:*
claude

# Or for specific components
export DEBUG=claude:mcp,claude:api
claude
```

### Common Solutions Summary

1. **Update Node.js** to version 18+
2. **Fix npm permissions** or use nvm
3. **Check API key** format and validity
4. **Verify network access** and proxy settings
5. **Install MCP servers** with correct configuration
6. **Check file permissions** for config files
7. **Clear caches** when packages seem corrupted
8. **Use npx** as alternative to global installation

For persistent issues, check the [official documentation](https://docs.anthropic.com/en/docs/claude-code) or [GitHub issues](https://github.com/anthropics/claude-code/issues).