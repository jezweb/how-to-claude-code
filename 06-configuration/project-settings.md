# Project-Specific Settings

Configure Claude Code behavior for individual projects using project-level configuration files and settings.

## Project Configuration Structure

```
my-project/
├── .claude/
│   ├── claude.json          # Main configuration
│   ├── prompts/             # Custom prompts
│   ├── commands/            # Custom commands
│   └── settings.json        # Project settings
├── .env                     # Environment variables
└── CLAUDE.md               # Project context
```

## Project Configuration File

### Basic .claude/claude.json

```json
{
  "projectName": "My Awesome Project",
  "description": "E-commerce platform built with React and Node.js",
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "./src", "./tests"],
      "env": {
        "FS_DESCRIPTION": "Project source files"
      }
    }
  },
  "settings": {
    "defaultModel": "claude-3-5-sonnet-20241022",
    "codeStyle": "prettier",
    "testFramework": "jest"
  }
}
```

### Framework-Specific Configuration

#### React Project

```json
{
  "projectName": "React Dashboard",
  "framework": "react",
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "./src"],
      "env": {
        "FS_INCLUDE_PATTERNS": "*.js,*.jsx,*.ts,*.tsx,*.css,*.scss"
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
  },
  "settings": {
    "lintCommand": "npm run lint",
    "testCommand": "npm test",
    "buildCommand": "npm run build",
    "devCommand": "npm start",
    "codeStyle": {
      "framework": "react",
      "eslintConfig": ".eslintrc.js",
      "prettierConfig": ".prettierrc"
    }
  },
  "prompts": {
    "component": {
      "description": "Generate React component",
      "template": "Create a React component named {name} with props: {props}"
    },
    "test": {
      "description": "Generate component tests",
      "template": "Create React Testing Library tests for component {component}"
    }
  }
}
```

#### Node.js API Project

```json
{
  "projectName": "Express API",
  "framework": "express",
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "./src", "./routes", "./middleware"],
      "env": {
        "FS_DESCRIPTION": "API source files"
      }
    },
    "database": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-postgresql"],
      "env": {
        "DATABASE_URL": "${DATABASE_URL}"
      }
    }
  },
  "settings": {
    "testCommand": "npm run test",
    "devCommand": "npm run dev",
    "lintCommand": "npm run lint",
    "codeStyle": {
      "framework": "express",
      "database": "postgresql",
      "orm": "prisma"
    }
  },
  "prompts": {
    "route": {
      "description": "Generate Express route",
      "template": "Create Express route for {method} {path} that {description}"
    },
    "middleware": {
      "description": "Generate middleware",
      "template": "Create Express middleware for {purpose}"
    }
  }
}
```

#### Python Project

```json
{
  "projectName": "Python Data Pipeline",
  "framework": "python",
  "mcpServers": {
    "filesystem": {
      "command": "python",
      "args": ["-m", "mcp_server_filesystem", "./src", "./tests"],
      "env": {
        "PYTHON_PATH": "./src"
      }
    }
  },
  "settings": {
    "testCommand": "pytest",
    "lintCommand": "flake8 .",
    "formatCommand": "black .",
    "codeStyle": {
      "formatter": "black",
      "linter": "flake8",
      "typeChecker": "mypy"
    }
  },
  "prompts": {
    "function": {
      "description": "Generate Python function",
      "template": "Create Python function {name} that {description} with type hints"
    },
    "class": {
      "description": "Generate Python class",
      "template": "Create Python class {name} with methods: {methods}"
    }
  }
}
```

## Project Settings File

### .claude/settings.json

```json
{
  "editor": {
    "tabSize": 2,
    "insertSpaces": true,
    "trimTrailingWhitespace": true,
    "insertFinalNewline": true
  },
  "formatting": {
    "provider": "prettier",
    "config": ".prettierrc",
    "formatOnSave": true
  },
  "linting": {
    "provider": "eslint",
    "config": ".eslintrc.js",
    "lintOnSave": true,
    "autoFix": true
  },
  "testing": {
    "framework": "jest",
    "coverage": true,
    "watchMode": true,
    "testPattern": "**/*.test.{js,jsx,ts,tsx}"
  },
  "git": {
    "autoCommit": false,
    "commitMessageTemplate": "{type}: {description}",
    "branchNaming": "feature/{description}",
    "hooks": {
      "preCommit": ["lint", "test"],
      "prePush": ["build"]
    }
  },
  "build": {
    "outputDir": "dist",
    "cleanBefore": true,
    "sourceMaps": true,
    "minify": true
  }
}
```

## Context Documentation (CLAUDE.md)

### Project Context File

```markdown
# My Awesome Project

## Project Overview
E-commerce platform built with React frontend and Node.js backend.

## Tech Stack
- **Frontend**: React 18, TypeScript, Material-UI
- **Backend**: Node.js, Express, PostgreSQL
- **Testing**: Jest, React Testing Library, Cypress
- **Build**: Webpack, Babel
- **Deployment**: Docker, AWS ECS

## Architecture
- Microservices architecture
- RESTful API design
- JWT authentication
- Redis caching layer

## Code Style
- ESLint + Prettier
- Airbnb style guide
- TypeScript strict mode
- 2-space indentation

## Important Files
- `src/components/` - React components
- `src/api/` - API integration
- `src/utils/` - Utility functions
- `backend/routes/` - Express routes
- `backend/models/` - Database models

## Development Workflow
1. Create feature branch
2. Write tests first (TDD)
3. Implement feature
4. Run linting and tests
5. Create pull request

## Testing Strategy
- Unit tests for utilities
- Component tests for React
- Integration tests for API
- E2E tests for critical paths

## Deployment
- Staging: Auto-deploy from develop branch
- Production: Manual deploy from main branch
- Environment variables managed via AWS Parameter Store

## Common Commands
- `npm start` - Start development server
- `npm test` - Run tests
- `npm run build` - Build for production
- `npm run lint` - Lint code
- `docker-compose up` - Start all services

## Known Issues
- Database connection pooling needs optimization
- Image upload requires compression
- Search functionality needs indexing

## Contact
- Lead Developer: jane@company.com
- DevOps: ops@company.com
```

## Environment Configuration

### Development Environment

**.env.development:**
```bash
NODE_ENV=development
API_URL=http://localhost:3001
DATABASE_URL=postgresql://dev:password@localhost:5432/myapp_dev
REDIS_URL=redis://localhost:6379
DEBUG=true
LOG_LEVEL=debug
```

### Testing Environment

**.env.test:**
```bash
NODE_ENV=test
API_URL=http://localhost:3001
DATABASE_URL=postgresql://test:password@localhost:5432/myapp_test
REDIS_URL=redis://localhost:6380
LOG_LEVEL=error
```

### Production Environment

**.env.production:**
```bash
NODE_ENV=production
API_URL=https://api.myapp.com
DATABASE_URL=${DATABASE_URL}
REDIS_URL=${REDIS_URL}
LOG_LEVEL=error
SENTRY_DSN=${SENTRY_DSN}
```

## Custom Prompts

### .claude/prompts/component.md

```markdown
---
name: component
description: Generate React component with TypeScript
variables: [name, props, children]
---

# React Component Generator

Create a React component with the following specifications:

**Component Name**: {name}
**Props**: {props}
**Has Children**: {children}

## Requirements
- Use TypeScript with proper interfaces
- Follow project naming conventions
- Include PropTypes for runtime validation
- Add basic CSS module styling
- Include JSDoc comments
- Export as named export

## Template
- Functional component with hooks
- Props interface definition
- Default props where appropriate
- Styled with CSS modules
- Accessible markup (ARIA attributes)

## Testing
- Include basic component test
- Test prop rendering
- Test event handlers
- Test accessibility
```

### .claude/prompts/api-route.md

```markdown
---
name: api-route
description: Generate Express API route
variables: [method, path, description, middleware]
---

# API Route Generator

Create an Express route with the following specifications:

**Method**: {method}
**Path**: {path}
**Description**: {description}
**Middleware**: {middleware}

## Requirements
- Input validation with Joi
- Error handling with try/catch
- Response standardization
- Authentication check
- Rate limiting
- Request logging
- OpenAPI documentation

## Security
- Sanitize inputs
- Validate permissions
- Add CORS headers
- Implement rate limiting
- Log security events

## Testing
- Unit tests for route handler
- Integration tests with database
- Error case testing
- Security testing
```

## Custom Commands

### .claude/commands/deploy.md

```markdown
---
name: deploy
description: Deploy application to staging/production
options:
  - name: environment
    description: Target environment
    required: true
    choices: [staging, production]
  - name: version
    description: Version to deploy
    required: false
---

# Deployment Command

Deploy the application to the specified environment.

## Pre-deployment Checks
1. Run all tests
2. Check code coverage
3. Verify build passes
4. Check security vulnerabilities
5. Validate environment variables

## Deployment Steps
1. Build application
2. Run database migrations
3. Deploy to container registry
4. Update service configuration
5. Perform health checks
6. Update load balancer
7. Verify deployment

## Post-deployment
1. Run smoke tests
2. Monitor application metrics
3. Check error logs
4. Notify team of deployment
```

## Framework Integration

### Package.json Scripts

```json
{
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "eslint . --ext .js,.jsx,.ts,.tsx",
    "lint:fix": "eslint . --ext .js,.jsx,.ts,.tsx --fix",
    "test": "jest",
    "test:watch": "jest --watch",
    "test:coverage": "jest --coverage",
    "type-check": "tsc --noEmit",
    "claude:setup": "claude init",
    "claude:validate": "claude config validate"
  }
}
```

### VS Code Integration

**.vscode/settings.json:**
```json
{
  "claude.configPath": ".claude/claude.json",
  "claude.autostart": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": true
  },
  "files.associations": {
    "*.md": "markdown"
  }
}
```

## Multi-environment Configuration

### Environment Inheritance

```json
{
  "extends": "../shared/.claude/claude.json",
  "projectName": "Frontend App",
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "./src"]
    }
  },
  "settings": {
    "buildCommand": "npm run build:${NODE_ENV}"
  }
}
```

### Conditional Configuration

```json
{
  "mcpServers": {
    "database": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-postgresql"],
      "env": {
        "DATABASE_URL": "${NODE_ENV === 'test' ? TEST_DATABASE_URL : DATABASE_URL}"
      }
    }
  }
}
```

## Team Collaboration

### Shared Configuration

**shared/.claude/claude.json:**
```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    }
  },
  "settings": {
    "codeStyle": {
      "prettier": true,
      "eslint": true
    }
  },
  "prompts": {
    "pr-review": {
      "description": "Code review checklist",
      "template": "Review this PR for:\n1. Code quality\n2. Security issues\n3. Performance\n4. Tests\n5. Documentation"
    }
  }
}
```

### Team Standards

**.claude/team-standards.json:**
```json
{
  "codeReview": {
    "required": true,
    "minReviewers": 2,
    "checklistRequired": true
  },
  "testing": {
    "minCoverage": 80,
    "e2eRequired": true,
    "performanceTests": true
  },
  "security": {
    "vulnerabilityScanning": true,
    "dependencyChecks": true,
    "secretScanning": true
  },
  "documentation": {
    "apiDocs": true,
    "readmeRequired": true,
    "changelogRequired": true
  }
}
```

## Best Practices

1. **Version Control** - Commit project config, exclude sensitive data
2. **Documentation** - Keep CLAUDE.md updated with project context
3. **Environment Separation** - Use different configs for dev/staging/prod
4. **Team Consistency** - Share common standards and prompts
5. **Security** - Never commit API keys or credentials
6. **Validation** - Regularly validate configuration files
7. **Backup** - Keep backups of working configurations
8. **Testing** - Test configuration changes in development first

## Troubleshooting

### Configuration Validation

```bash
# Validate project configuration
claude config validate --project

# Check configuration inheritance
claude config show --resolved

# Test MCP server connections
claude mcp test
```

### Common Issues

**Config not found:**
```bash
Error: No .claude/claude.json found

Solution: Run `claude init` in project root
```

**Environment variable missing:**
```bash
Error: DATABASE_URL not set

Solution: Check .env file and export variables
```

**MCP server failed:**
```bash
Error: MCP server 'filesystem' failed to start

Solution: Check paths and permissions in configuration
```

## Resources

- [Configuration Schema](https://schemas.anthropic.com/claude-code/config.json)
- [Environment Variable Guide](./environment-variables.md)
- [MCP Server Documentation](../03-mcp-servers/)
- [Custom Commands Guide](../04-custom-commands/)