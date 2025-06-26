# Claude Configuration (.claude.json)

The `.claude.json` file is the primary configuration file for Claude Code, controlling MCP servers, settings, and behavior.

## File Locations

Claude Code looks for configuration in these locations (in order):

1. **Project-specific**: `./.claude/claude.json` (current directory)
2. **User-specific**: `~/.claude/claude.json` (home directory)
3. **Global**: `/etc/claude/claude.json` (system-wide)

## Basic Structure

```json
{
  "mcpServers": {},
  "settings": {},
  "prompts": {},
  "aliases": {}
}
```

## MCP Server Configuration

### Simple Server

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/home/user/projects"]
    }
  }
}
```

### Server with Environment Variables

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}",
        "NODE_ENV": "production"
      }
    }
  }
}
```

### Multiple Servers

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/home/user/projects"],
      "env": {
        "FS_DESCRIPTION": "Project files"
      }
    },
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    },
    "playwright": {
      "command": "npx",
      "args": ["@playwright/mcp"],
      "env": {
        "BROWSER": "chromium",
        "HEADLESS": "true"
      }
    }
  }
}
```

## Server Configuration Options

### Command and Arguments

```json
{
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-name", "additional", "arguments"]
}
```

**Alternative command formats:**

```json
{
  "command": "/usr/local/bin/mcp-server"
}
```

```json
{
  "command": "python",
  "args": ["-m", "mcp_server_package"]
}
```

### Environment Variables

```json
{
  "env": {
    "API_KEY": "${API_KEY}",
    "DEBUG": "true",
    "NODE_ENV": "production",
    "CUSTOM_CONFIG": "/path/to/config"
  }
}
```

**Environment variable substitution:**
- `${VAR_NAME}` - Substitutes from system environment
- `$VAR_NAME` - Alternative syntax
- `"${VAR_NAME:-default}"` - With default value

### Working Directory

```json
{
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-filesystem"],
  "cwd": "/specific/working/directory"
}
```

### Timeout Settings

```json
{
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-name"],
  "timeout": 30000,
  "startupTimeout": 10000
}
```

## Claude Settings

### API Configuration

```json
{
  "settings": {
    "apiKey": "${ANTHROPIC_API_KEY}",
    "apiUrl": "https://api.anthropic.com",
    "model": "claude-3-5-sonnet-20241022",
    "maxTokens": 4096
  }
}
```

### Behavior Settings

```json
{
  "settings": {
    "autoSave": true,
    "verboseLogging": false,
    "confirmDangerousOperations": true,
    "defaultFileEncoding": "utf-8",
    "gitIntegration": true
  }
}
```

### UI Preferences

```json
{
  "settings": {
    "theme": "auto",
    "fontSize": 14,
    "showLineNumbers": true,
    "wordWrap": true,
    "tabSize": 2
  }
}
```

## Custom Prompts

### Prompt Definitions

```json
{
  "prompts": {
    "review": {
      "description": "Code review with feedback",
      "template": "Review this code for:\n1. Security issues\n2. Performance problems\n3. Best practices\n4. Documentation needs\n\nCode: {code}",
      "variables": ["code"]
    },
    "refactor": {
      "description": "Suggest refactoring improvements",
      "template": "Suggest refactoring for {file} focusing on:\n- Code organization\n- Performance\n- Maintainability\n- Best practices",
      "variables": ["file"]
    }
  }
}
```

### Prompt with Multiple Templates

```json
{
  "prompts": {
    "test": {
      "description": "Generate tests",
      "templates": {
        "unit": "Generate unit tests for {function} in {file}",
        "integration": "Create integration tests for {feature}",
        "e2e": "Write end-to-end tests for {workflow}"
      },
      "variables": ["function", "file", "feature", "workflow"]
    }
  }
}
```

## Command Aliases

### Simple Aliases

```json
{
  "aliases": {
    "r": "review",
    "t": "test",
    "d": "debug",
    "deploy": "git push origin main"
  }
}
```

### Complex Aliases

```json
{
  "aliases": {
    "full-review": [
      "lint",
      "test",
      "review --security --performance",
      "check-docs"
    ],
    "release": [
      "test",
      "build",
      "version patch",
      "git push --tags",
      "deploy"
    ]
  }
}
```

## Advanced Configuration

### Conditional Configuration

```json
{
  "mcpServers": {
    "development": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/home/user/dev"],
      "env": {
        "NODE_ENV": "development"
      },
      "condition": "${NODE_ENV} == 'development'"
    },
    "production": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/var/app"],
      "env": {
        "NODE_ENV": "production"
      },
      "condition": "${NODE_ENV} == 'production'"
    }
  }
}
```

### Server Dependencies

```json
{
  "mcpServers": {
    "database": {
      "command": "mcp-database-server",
      "args": ["--config", "/etc/db.conf"]
    },
    "api": {
      "command": "mcp-api-server",
      "args": ["--db-server", "database"],
      "dependsOn": ["database"]
    }
  }
}
```

### Resource Limits

```json
{
  "mcpServers": {
    "heavy-server": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-heavy"],
      "limits": {
        "memory": "512MB",
        "cpu": "0.5",
        "timeout": 60000
      }
    }
  }
}
```

## Security Configuration

### Secure Environment Variables

```json
{
  "mcpServers": {
    "secure-server": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-secure"],
      "env": {
        "API_KEY": "${SECURE_API_KEY}",
        "SECRET": "${SECRET_VALUE}"
      },
      "envFile": ".env.secure"
    }
  }
}
```

### Access Control

```json
{
  "settings": {
    "security": {
      "allowDangerousOperations": false,
      "restrictFileAccess": true,
      "allowedPaths": [
        "/home/user/projects",
        "/home/user/workspace"
      ],
      "blockedPaths": [
        "/etc",
        "/var/log",
        "/home/user/.ssh"
      ]
    }
  }
}
```

## Development vs Production

### Development Configuration

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/home/user/dev"],
      "env": {
        "DEBUG": "true",
        "LOG_LEVEL": "verbose"
      }
    }
  },
  "settings": {
    "verboseLogging": true,
    "autoReload": true,
    "confirmOperations": false
  }
}
```

### Production Configuration

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "/usr/local/bin/mcp-filesystem",
      "args": ["/var/app/data"],
      "env": {
        "LOG_LEVEL": "error",
        "NODE_ENV": "production"
      },
      "limits": {
        "memory": "256MB",
        "timeout": 30000
      }
    }
  },
  "settings": {
    "verboseLogging": false,
    "confirmDangerousOperations": true,
    "backupBeforeChanges": true
  }
}
```

## Configuration Validation

### Schema Validation

Claude Code validates configuration against a JSON schema:

```json
{
  "$schema": "https://schemas.anthropic.com/claude-code/v1/config.json",
  "mcpServers": {
    "my-server": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-name"]
    }
  }
}
```

### Validation Commands

```bash
# Validate configuration
claude config validate

# Check for syntax errors
claude config check

# Show resolved configuration
claude config show
```

## Configuration Inheritance

### Override Hierarchy

1. Command-line arguments (highest priority)
2. Project configuration (`./.claude/claude.json`)
3. User configuration (`~/.claude/claude.json`)
4. Global configuration (`/etc/claude/claude.json`)
5. Default values (lowest priority)

### Merging Behavior

```json
// Global config
{
  "mcpServers": {
    "filesystem": { "command": "npx", "args": ["..."] }
  },
  "settings": {
    "verboseLogging": false
  }
}

// Project config
{
  "mcpServers": {
    "github": { "command": "npx", "args": ["..."] }
  },
  "settings": {
    "verboseLogging": true
  }
}

// Merged result
{
  "mcpServers": {
    "filesystem": { "command": "npx", "args": ["..."] },
    "github": { "command": "npx", "args": ["..."] }
  },
  "settings": {
    "verboseLogging": true
  }
}
```

## Troubleshooting Configuration

### Common Issues

**Invalid JSON syntax:**
```bash
Error: Unexpected token } in JSON at position 123

Solution: Use JSON validator or claude config check
```

**Missing environment variables:**
```bash
Error: Environment variable GITHUB_TOKEN not found

Solution: Set the variable or provide a default value
```

**Server startup failures:**
```bash
Error: MCP server 'filesystem' failed to start

Solution: Check command path and arguments
```

### Debug Configuration

```json
{
  "settings": {
    "debug": true,
    "logLevel": "debug"
  },
  "mcpServers": {
    "debug-server": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-name"],
      "env": {
        "DEBUG": "*",
        "LOG_LEVEL": "debug"
      }
    }
  }
}
```

## Best Practices

1. **Version Control** - Include project configs in git, exclude sensitive values
2. **Environment Variables** - Use for secrets and environment-specific values
3. **Documentation** - Comment your configuration choices
4. **Validation** - Always validate after changes
5. **Backup** - Keep backups of working configurations
6. **Security** - Never commit API keys or passwords
7. **Organization** - Group related servers and settings
8. **Testing** - Test configuration changes in development first

## Example Complete Configuration

```json
{
  "$schema": "https://schemas.anthropic.com/claude-code/v1/config.json",
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/home/user/projects"],
      "env": {
        "FS_DESCRIPTION": "Project files access"
      }
    },
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    },
    "playwright": {
      "command": "npx",
      "args": ["@playwright/mcp"],
      "env": {
        "BROWSER": "chromium",
        "HEADLESS": "${HEADLESS:-true}"
      }
    }
  },
  "settings": {
    "verboseLogging": false,
    "confirmDangerousOperations": true,
    "gitIntegration": true,
    "autoSave": true
  },
  "prompts": {
    "review": {
      "description": "Comprehensive code review",
      "template": "Review {file} for security, performance, and best practices"
    }
  },
  "aliases": {
    "r": "review",
    "t": "test",
    "deploy": ["test", "build", "git push origin main"]
  }
}
```

## Resources

- [JSON Schema Validator](https://jsonschemavalidator.net/)
- [Environment Variable Best Practices](https://12factor.net/config)
- [MCP Server Registry](https://github.com/modelcontextprotocol/servers)