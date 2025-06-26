# Environment Variables

Environment variables provide a secure and flexible way to configure Claude Code without hardcoding sensitive information in configuration files.

## Core Environment Variables

### Anthropic API Configuration

```bash
# Required: Your Anthropic API key
export ANTHROPIC_API_KEY="sk-ant-your-key-here"

# Optional: API endpoint (defaults to https://api.anthropic.com)
export ANTHROPIC_API_URL="https://api.anthropic.com"

# Optional: Default model to use
export ANTHROPIC_MODEL="claude-3-5-sonnet-20241022"

# Optional: Default max tokens
export ANTHROPIC_MAX_TOKENS="4096"
```

### Claude Code Behavior

```bash
# Debug mode
export CLAUDE_DEBUG="true"

# Log level (error, warn, info, debug)
export CLAUDE_LOG_LEVEL="info"

# Configuration file path
export CLAUDE_CONFIG_PATH="~/.claude/claude.json"

# Disable git integration
export CLAUDE_NO_GIT="true"
```

## MCP Server Environment Variables

### Common MCP Variables

```bash
# Node.js environment
export NODE_ENV="production"

# Debugging
export DEBUG="mcp:*"

# Memory limits
export NODE_OPTIONS="--max-old-space-size=4096"
```

### Filesystem Server

```bash
# Allowed paths for filesystem access
export FS_ALLOWED_PATHS="/home/user/projects:/home/user/documents"

# Read-only mode
export FS_READ_ONLY="true"

# Maximum file size
export FS_MAX_FILE_SIZE="10MB"

# Include hidden files
export FS_INCLUDE_HIDDEN="false"
```

### GitHub Server

```bash
# GitHub personal access token
export GITHUB_TOKEN="ghp_your-token-here"

# GitHub Enterprise URL
export GITHUB_API_URL="https://api.github.company.com"

# Default organization
export GITHUB_ORG="my-organization"

# Rate limiting
export GITHUB_RATE_LIMIT="5000"
```

### Playwright Server

```bash
# Browser type (chromium, firefox, webkit)
export PLAYWRIGHT_BROWSER="chromium"

# Headless mode
export PLAYWRIGHT_HEADLESS="true"

# Viewport size
export PLAYWRIGHT_VIEWPORT_WIDTH="1280"
export PLAYWRIGHT_VIEWPORT_HEIGHT="720"

# User agent
export PLAYWRIGHT_USER_AGENT="Mozilla/5.0 (compatible; ClaudeCode/1.0)"

# Timeout settings
export PLAYWRIGHT_TIMEOUT="30000"
export PLAYWRIGHT_NAVIGATION_TIMEOUT="60000"

# Downloads directory
export PLAYWRIGHT_DOWNLOADS_PATH="/tmp/claude-downloads"
```

### Database Servers

```bash
# PostgreSQL
export POSTGRES_HOST="localhost"
export POSTGRES_PORT="5432"
export POSTGRES_DB="myapp"
export POSTGRES_USER="user"
export POSTGRES_PASSWORD="password"

# MySQL
export MYSQL_HOST="localhost"
export MYSQL_PORT="3306"
export MYSQL_DATABASE="myapp"
export MYSQL_USER="user"
export MYSQL_PASSWORD="password"

# MongoDB
export MONGODB_URI="mongodb://localhost:27017/myapp"

# Redis
export REDIS_URL="redis://localhost:6379"
```

## Cloud Provider Variables

### AWS

```bash
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
export AWS_REGION="us-west-2"
export AWS_PROFILE="default"
```

### Google Cloud

```bash
export GOOGLE_APPLICATION_CREDENTIALS="/path/to/service-account.json"
export GOOGLE_CLOUD_PROJECT="my-project-id"
export GOOGLE_CLOUD_REGION="us-central1"
```

### Azure

```bash
export AZURE_TENANT_ID="your-tenant-id"
export AZURE_CLIENT_ID="your-client-id"
export AZURE_CLIENT_SECRET="your-client-secret"
export AZURE_SUBSCRIPTION_ID="your-subscription-id"
```

### Cloudflare

```bash
export CLOUDFLARE_API_TOKEN="your-api-token"
export CLOUDFLARE_ACCOUNT_ID="your-account-id"
export CLOUDFLARE_ZONE_ID="your-zone-id"
```

## Setting Environment Variables

### Linux/macOS

#### Temporary (current session)

```bash
export ANTHROPIC_API_KEY="sk-ant-your-key-here"
```

#### Permanent (shell profile)

**Bash (`~/.bashrc` or `~/.bash_profile`):**
```bash
echo 'export ANTHROPIC_API_KEY="sk-ant-your-key-here"' >> ~/.bashrc
source ~/.bashrc
```

**Zsh (`~/.zshrc`):**
```bash
echo 'export ANTHROPIC_API_KEY="sk-ant-your-key-here"' >> ~/.zshrc
source ~/.zshrc
```

**Fish (`~/.config/fish/config.fish`):**
```fish
echo 'set -gx ANTHROPIC_API_KEY "sk-ant-your-key-here"' >> ~/.config/fish/config.fish
```

#### System-wide (`/etc/environment`)

```bash
sudo echo 'ANTHROPIC_API_KEY="sk-ant-your-key-here"' >> /etc/environment
```

### Windows

#### Command Prompt (temporary)

```cmd
set ANTHROPIC_API_KEY=sk-ant-your-key-here
```

#### Command Prompt (permanent)

```cmd
setx ANTHROPIC_API_KEY "sk-ant-your-key-here"
```

#### PowerShell (temporary)

```powershell
$env:ANTHROPIC_API_KEY = "sk-ant-your-key-here"
```

#### PowerShell (permanent)

```powershell
[Environment]::SetEnvironmentVariable("ANTHROPIC_API_KEY", "sk-ant-your-key-here", "User")
```

#### System Properties GUI

1. Right-click "This PC" → Properties
2. Advanced system settings
3. Environment Variables
4. Add new variable

## Environment Files (.env)

### Basic .env File

Create `.env` in your project root:

```bash
# Anthropic API
ANTHROPIC_API_KEY=sk-ant-your-key-here
ANTHROPIC_MODEL=claude-3-5-sonnet-20241022

# GitHub
GITHUB_TOKEN=ghp_your-token-here

# Database
DATABASE_URL=postgresql://user:pass@localhost:5432/myapp

# Other services
REDIS_URL=redis://localhost:6379
SENDGRID_API_KEY=SG.your-key-here
```

### Environment-specific Files

```bash
# Development
.env.development
.env.local

# Testing
.env.test
.env.test.local

# Production
.env.production
.env.production.local
```

### Loading .env Files

**Node.js (using dotenv):**
```javascript
require('dotenv').config();
// or
require('dotenv').config({ path: '.env.local' });
```

**Python (using python-dotenv):**
```python
from dotenv import load_dotenv
load_dotenv()
# or
load_dotenv('.env.local')
```

## Configuration Integration

### Using Variables in claude.json

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}",
        "DEBUG": "${DEBUG:-false}"
      }
    }
  },
  "settings": {
    "apiKey": "${ANTHROPIC_API_KEY}",
    "model": "${ANTHROPIC_MODEL:-claude-3-5-sonnet-20241022}"
  }
}
```

### Default Values

Use `${VAR:-default}` syntax for default values:

```json
{
  "env": {
    "LOG_LEVEL": "${LOG_LEVEL:-info}",
    "TIMEOUT": "${TIMEOUT:-30000}",
    "HEADLESS": "${HEADLESS:-true}"
  }
}
```

### Required Variables

Use `${VAR}` without defaults for required variables:

```json
{
  "env": {
    "API_KEY": "${API_KEY}",
    "DATABASE_URL": "${DATABASE_URL}"
  }
}
```

## Security Best Practices

### Protect Sensitive Variables

```bash
# Use restrictive permissions
chmod 600 .env

# Never commit .env files
echo ".env*" >> .gitignore
echo "!.env.example" >> .gitignore
```

### Create Example Files

**.env.example:**
```bash
# Copy this file to .env and fill in your values

# Anthropic API
ANTHROPIC_API_KEY=sk-ant-your-key-here

# GitHub (optional)
GITHUB_TOKEN=ghp_your-token-here

# Database
DATABASE_URL=postgresql://user:password@localhost:5432/dbname

# External Services
REDIS_URL=redis://localhost:6379
```

### Validate Required Variables

**Shell script validation:**
```bash
#!/bin/bash
required_vars=("ANTHROPIC_API_KEY" "DATABASE_URL")

for var in "${required_vars[@]}"; do
    if [ -z "${!var}" ]; then
        echo "Error: $var is not set"
        exit 1
    fi
done

echo "All required environment variables are set"
```

**Node.js validation:**
```javascript
const requiredVars = ['ANTHROPIC_API_KEY', 'DATABASE_URL'];

requiredVars.forEach(varName => {
    if (!process.env[varName]) {
        console.error(`Error: ${varName} is not set`);
        process.exit(1);
    }
});
```

## Development vs Production

### Development Environment

```bash
# Development-specific variables
export NODE_ENV="development"
export CLAUDE_DEBUG="true"
export CLAUDE_LOG_LEVEL="debug"
export FS_INCLUDE_HIDDEN="true"
export PLAYWRIGHT_HEADLESS="false"
```

### Production Environment

```bash
# Production-specific variables
export NODE_ENV="production"
export CLAUDE_DEBUG="false"
export CLAUDE_LOG_LEVEL="error"
export FS_READ_ONLY="true"
export PLAYWRIGHT_HEADLESS="true"
```

### Environment Detection

```bash
# Conditional configuration based on NODE_ENV
if [ "$NODE_ENV" = "production" ]; then
    export CLAUDE_LOG_LEVEL="error"
    export DATABASE_POOL_SIZE="20"
else
    export CLAUDE_LOG_LEVEL="debug"
    export DATABASE_POOL_SIZE="5"
fi
```

## Docker Integration

### Docker Compose

```yaml
# docker-compose.yml
version: '3.8'
services:
  claude-code:
    image: claude-code:latest
    environment:
      - ANTHROPIC_API_KEY=${ANTHROPIC_API_KEY}
      - GITHUB_TOKEN=${GITHUB_TOKEN}
      - NODE_ENV=production
    env_file:
      - .env
    volumes:
      - ./projects:/workspace
```

### Dockerfile

```dockerfile
FROM node:18-alpine

# Copy environment file
COPY .env.production .env

# Install Claude Code
RUN npm install -g @anthropic-ai/claude-code

# Set default environment
ENV NODE_ENV=production
ENV CLAUDE_CONFIG_PATH=/app/.claude/claude.json

WORKDIR /workspace
CMD ["claude"]
```

### Docker Secrets

```yaml
# docker-compose.yml
version: '3.8'
services:
  claude-code:
    image: claude-code:latest
    secrets:
      - anthropic_api_key
      - github_token
    environment:
      - ANTHROPIC_API_KEY_FILE=/run/secrets/anthropic_api_key

secrets:
  anthropic_api_key:
    file: ./secrets/anthropic_api_key.txt
  github_token:
    file: ./secrets/github_token.txt
```

## CI/CD Integration

### GitHub Actions

```yaml
# .github/workflows/claude-code.yml
name: Claude Code CI
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    env:
      ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
      GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '18'
      - run: npm install -g @anthropic-ai/claude-code
      - run: claude --version
```

### GitLab CI

```yaml
# .gitlab-ci.yml
variables:
  NODE_ENV: "production"

test:
  script:
    - export ANTHROPIC_API_KEY="$ANTHROPIC_API_KEY"
    - npm install -g @anthropic-ai/claude-code
    - claude --version
  only:
    - main
```

## Troubleshooting

### Common Issues

**Variable not found:**
```bash
Error: Environment variable ANTHROPIC_API_KEY not found

Solutions:
1. Check variable name spelling
2. Verify variable is exported
3. Restart terminal/application
4. Check .env file syntax
```

**Permission denied:**
```bash
Error: Permission denied reading .env

Solutions:
1. Check file permissions: chmod 644 .env
2. Verify file ownership: chown user:group .env
3. Check directory permissions
```

**Variable not updating:**
```bash
# Force reload environment
source ~/.bashrc
# or restart terminal
```

### Debug Commands

```bash
# List all environment variables
env

# Check specific variable
echo $ANTHROPIC_API_KEY

# Show variable with default
echo ${ANTHROPIC_API_KEY:-"not set"}

# Test variable substitution
envsubst < template.txt
```

## Best Practices Summary

1. **Security** - Never commit sensitive variables to version control
2. **Organization** - Group related variables together
3. **Documentation** - Provide .env.example files
4. **Validation** - Check required variables at startup
5. **Defaults** - Provide sensible defaults where possible
6. **Environment-specific** - Use different values for dev/staging/prod
7. **Rotation** - Regularly rotate API keys and tokens
8. **Monitoring** - Log when variables are missing or invalid

## Resources

- [Twelve-Factor App Configuration](https://12factor.net/config)
- [Environment Variable Security](https://owasp.org/www-community/vulnerabilities/Insecure_Storage_of_Sensitive_Information)
- [Docker Environment Variables](https://docs.docker.com/compose/environment-variables/)
- [GitHub Actions Secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets)