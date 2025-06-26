# Configuring MCP Servers

This guide covers everything you need to know about configuring MCP servers in Claude Code, from basic setup to advanced configurations.

## Configuration File Location

MCP servers are configured in the `.claude/claude.json` file:

- **Personal/Global**: `~/.claude/claude.json`
- **Project-specific**: `./.claude/claude.json`

## Basic Configuration Structure

```json
{
  "mcpServers": {
    "server-name": {
      "command": "command-to-run",
      "args": ["arg1", "arg2"],
      "env": {
        "ENV_VAR": "value"
      }
    }
  }
}
```

## Configuration Examples

### Local Server (stdio)

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem"],
      "env": {
        "ALLOWED_PATHS": "/home/user/projects"
      }
    }
  }
}
```

### Python Server

```json
{
  "mcpServers": {
    "python-analyzer": {
      "command": "python",
      "args": ["/path/to/server.py"],
      "env": {
        "PYTHONPATH": "/usr/local/lib/python3.11"
      }
    }
  }
}
```

### Node.js Server with Authentication

```json
{
  "mcpServers": {
    "github": {
      "command": "node",
      "args": ["/path/to/github-server.js"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}",
        "GITHUB_ORG": "your-org"
      }
    }
  }
}
```

### Remote Server (SSE)

```json
{
  "mcpServers": {
    "remote-api": {
      "transport": "sse",
      "url": "https://api.example.com/mcp/sse",
      "headers": {
        "Authorization": "Bearer ${API_TOKEN}"
      }
    }
  }
}
```

## Advanced Configurations

### Multiple Servers

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem"]
    },
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    },
    "database": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-postgres"],
      "env": {
        "DATABASE_URL": "${DATABASE_URL}"
      }
    }
  }
}
```

### Platform-Specific Configuration

```json
{
  "mcpServers": {
    "playwright": {
      "command": "node",
      "args": [
        "C:\\Users\\username\\AppData\\Roaming\\npm\\node_modules\\@executeautomation\\playwright-mcp-server\\index.js"
      ],
      "env": {
        "BROWSER": "chromium",
        "HEADLESS": "false"
      }
    }
  }
}
```

### Docker-based Server

```json
{
  "mcpServers": {
    "containerized-tool": {
      "command": "docker",
      "args": [
        "run",
        "-i",
        "--rm",
        "-v", "${PWD}:/workspace",
        "mcp-server-image:latest"
      ]
    }
  }
}
```

## Environment Variables

### Using System Environment Variables

```json
{
  "mcpServers": {
    "secure-server": {
      "command": "npx",
      "args": ["secure-mcp-server"],
      "env": {
        "API_KEY": "${SECURE_API_KEY}",
        "API_SECRET": "${SECURE_API_SECRET}"
      }
    }
  }
}
```

Set environment variables:
```bash
export SECURE_API_KEY="your-key"
export SECURE_API_SECRET="your-secret"
```

### Inline Environment Variables

```json
{
  "mcpServers": {
    "dev-server": {
      "command": "node",
      "args": ["server.js"],
      "env": {
        "NODE_ENV": "development",
        "DEBUG": "true",
        "LOG_LEVEL": "verbose"
      }
    }
  }
}
```

## Authentication Methods

### 1. Token-based

```json
{
  "mcpServers": {
    "api-server": {
      "command": "npx",
      "args": ["api-mcp-server"],
      "env": {
        "AUTH_TOKEN": "${API_TOKEN}"
      }
    }
  }
}
```

### 2. OAuth Configuration

```json
{
  "mcpServers": {
    "oauth-server": {
      "command": "npx",
      "args": ["oauth-mcp-server"],
      "env": {
        "CLIENT_ID": "${OAUTH_CLIENT_ID}",
        "CLIENT_SECRET": "${OAUTH_CLIENT_SECRET}",
        "REDIRECT_URI": "http://localhost:3000/callback"
      }
    }
  }
}
```

### 3. Certificate-based

```json
{
  "mcpServers": {
    "secure-server": {
      "command": "npx",
      "args": ["secure-server"],
      "env": {
        "CERT_PATH": "/path/to/cert.pem",
        "KEY_PATH": "/path/to/key.pem",
        "CA_PATH": "/path/to/ca.pem"
      }
    }
  }
}
```

## Server Scopes

### Project-specific Servers

Place in `./.claude/claude.json`:
```json
{
  "mcpServers": {
    "project-db": {
      "command": "npx",
      "args": ["sqlite-server"],
      "env": {
        "DATABASE_PATH": "./project.db"
      }
    }
  }
}
```

### User-wide Servers

Place in `~/.claude/claude.json`:
```json
{
  "mcpServers": {
    "personal-tools": {
      "command": "npx",
      "args": ["my-tools-server"],
      "env": {
        "TOOLS_CONFIG": "~/.config/my-tools/config.json"
      }
    }
  }
}
```

## Debugging Configuration

### Enable Debug Logging

```json
{
  "mcpServers": {
    "debug-server": {
      "command": "node",
      "args": ["--inspect", "server.js"],
      "env": {
        "DEBUG": "*",
        "LOG_LEVEL": "debug",
        "MCP_DEBUG": "true"
      }
    }
  }
}
```

### Test Configuration

```bash
# Validate JSON syntax
cat ~/.claude/claude.json | jq .

# Test server startup
npx @modelcontextprotocol/server-filesystem

# Check environment variables
echo $GITHUB_TOKEN
```

## Common Configuration Patterns

### Development vs Production

```json
{
  "mcpServers": {
    "api": {
      "command": "node",
      "args": ["api-server.js"],
      "env": {
        "API_ENDPOINT": "${NODE_ENV:=development}",
        "API_KEY": "${API_KEY}",
        "DEBUG": "${DEBUG:=false}"
      }
    }
  }
}
```

### Multi-workspace Setup

```json
{
  "mcpServers": {
    "workspace-1": {
      "command": "npx",
      "args": ["workspace-server", "--workspace", "project1"],
      "env": {
        "WORKSPACE_ROOT": "/home/user/project1"
      }
    },
    "workspace-2": {
      "command": "npx",
      "args": ["workspace-server", "--workspace", "project2"],
      "env": {
        "WORKSPACE_ROOT": "/home/user/project2"
      }
    }
  }
}
```

## Troubleshooting Configuration

### Common Issues

1. **Server won't start**
   - Check command path is correct
   - Verify all required environment variables are set
   - Look for typos in JSON

2. **Authentication failures**
   - Ensure tokens/credentials are valid
   - Check environment variable names match
   - Verify permissions on credential files

3. **Path issues**
   - Use absolute paths when possible
   - Account for platform differences (Windows vs Unix)
   - Check file permissions

### Validation Checklist

- [ ] Valid JSON syntax
- [ ] All required fields present
- [ ] Environment variables defined
- [ ] Paths exist and are accessible
- [ ] Authentication configured
- [ ] No naming conflicts

## Best Practices

1. **Organize by Purpose**
   ```json
   {
     "mcpServers": {
       "dev-database": { ... },
       "prod-database": { ... },
       "testing-tools": { ... }
     }
   }
   ```

2. **Use Descriptive Names**
   - ✅ `github-org-repos`
   - ❌ `server1`

3. **Document Configuration**
   ```json
   {
     "_comment": "GitHub server for org management",
     "mcpServers": {
       "github-org": { ... }
     }
   }
   ```

4. **Secure Sensitive Data**
   - Never commit tokens/passwords
   - Use environment variables
   - Consider secret management tools

## Next Steps

- [Installing MCP Servers](./installing-servers.md)
- [Popular Servers Catalog](./popular-servers/)
- [Security Considerations](./security-considerations.md)
- [Troubleshooting MCP Issues](../08-troubleshooting/mcp-server-issues.md)