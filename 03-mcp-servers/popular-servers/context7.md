# Context7 MCP Server

Context7 is a revolutionary MCP server that provides real-time, up-to-date documentation retrieval for any programming library or framework, solving the common problem of outdated or hallucinated code examples in AI responses.

## What is Context7?

Context7 acts as a dynamic bridge between your coding prompt and the real-time world of software documentation. When invoked, it:
- Fetches current, version-specific documentation directly from official sources
- Injects accurate code examples into Claude's context before generating responses
- Eliminates outdated or incorrect code suggestions
- Works with any library that has online documentation

## Key Benefits

- **🆓 Completely Free** - No API key or subscription required
- **📚 Universal Support** - Works with any programming library or framework
- **🔄 Real-time Updates** - Always gets the latest documentation
- **✨ Zero Configuration** - Just add "use context7" to your prompts
- **🚀 Instant Access** - No setup or authentication needed

## Installation

### Quick Install

```bash
# One-line installation
curl -sSL https://raw.githubusercontent.com/jezweb/how-to-claude-code/main/scripts/quick-install/install-context7.sh | bash

# Or download and run
./scripts/quick-install/install-context7.sh
```

### Manual Installation

Add to your `~/.claude.json`:

```json
{
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp"],
      "env": {}
    }
  }
}
```

### Alternative Commands

#### Using Python MCP Manager

```bash
python3 scripts/mcp-manager.py add context7 --package "@upstash/context7-mcp"
```

#### Using Bun

```json
{
  "mcpServers": {
    "context7": {
      "command": "bunx",
      "args": ["-y", "@upstash/context7-mcp@latest"]
    }
  }
}
```

#### Using Deno

```json
{
  "mcpServers": {
    "context7": {
      "command": "deno",
      "args": ["run", "--allow-net", "npm:@upstash/context7-mcp"]
    }
  }
}
```

## Usage

Using Context7 is incredibly simple. Just include "**use context7**" in any prompt where you want current documentation:

### Basic Usage

```
Create a React component with the latest hooks. use context7
```

```
Show me how to use Prisma with PostgreSQL. use context7
```

### Example Prompts

#### Frontend Development

```
Build a Next.js 14 app with the new app router and server components. use context7
```

```
Create a Vue 3 component using the Composition API and TypeScript. use context7
```

```
Implement a responsive navbar with Tailwind CSS v3. use context7
```

#### Backend Development

```
Create a FastAPI endpoint with Pydantic v2 validation. use context7
```

```
Set up JWT authentication in Express.js with refresh tokens. use context7
```

```
Write a GraphQL resolver with Apollo Server v4. use context7
```

#### Database & ORMs

```
Show me Prisma schema for a blog with comments. use context7
```

```
Create a MongoDB aggregation pipeline with Mongoose. use context7
```

```
Write PostgreSQL queries using Drizzle ORM. use context7
```

#### DevOps & Cloud

```
Deploy a containerized app to Kubernetes. use context7
```

```
Set up GitHub Actions for Node.js CI/CD. use context7
```

```
Configure AWS Lambda with API Gateway. use context7
```

## Supported Documentation Sources

Context7 works with virtually any library or framework that has online documentation:

### Frontend Frameworks
- React, Next.js, Gatsby
- Vue.js, Nuxt.js
- Angular, Svelte, SvelteKit
- Solid.js, Qwik, Astro

### CSS Frameworks
- Tailwind CSS
- Bootstrap
- Material-UI
- Chakra UI
- Ant Design

### Backend Frameworks
- Express.js, Fastify, Koa
- FastAPI, Django, Flask
- Ruby on Rails
- Spring Boot
- ASP.NET Core

### Databases & ORMs
- PostgreSQL, MySQL, MongoDB
- Redis, Elasticsearch
- Prisma, TypeORM, Sequelize
- Mongoose, Drizzle

### DevOps Tools
- Docker, Kubernetes
- Terraform, Ansible
- GitHub Actions, GitLab CI
- AWS, GCP, Azure

### And Many More!
- Any npm package
- Any Python library
- Any programming language docs
- API documentation
- Framework guides

## Advanced Usage

### Version-Specific Documentation

```
Show me React 17 class components (not hooks). use context7
```

```
Use Vue 2 Options API syntax. use context7
```

### Multiple Libraries

```
Create a full-stack app with Next.js 14, Prisma, and tRPC. use context7
```

```
Build a REST API with Express, TypeORM, and PostgreSQL. use context7
```

### Migration Guides

```
Help me migrate from Vue 2 to Vue 3. use context7
```

```
Convert this Express.js app to Fastify. use context7
```

## How It Works

1. **Prompt Detection** - Context7 activates when it sees "use context7" in your prompt
2. **Library Identification** - It identifies the libraries/frameworks mentioned
3. **Documentation Fetch** - Retrieves current docs from official sources
4. **Context Injection** - Adds the documentation to Claude's context
4. **Response Generation** - Claude generates code using up-to-date information

## Best Practices

### 1. Be Specific

```
❌ "Create a web app. use context7"
✅ "Create a Next.js 14 app with TypeScript and Tailwind CSS. use context7"
```

### 2. Mention Versions When Needed

```
✅ "Use React 18 features. use context7"
✅ "Show me Vue 3 Composition API. use context7"
```

### 3. Combine Multiple Technologies

```
✅ "Build a MERN stack app with JWT auth. use context7"
✅ "Create a T3 stack application. use context7"
```

### 4. Use for Learning

```
✅ "Explain React Server Components with examples. use context7"
✅ "Show me best practices for Prisma schema design. use context7"
```

## Troubleshooting

### Context7 Not Working

**Issue**: Claude doesn't seem to fetch documentation

**Solutions**:
1. Ensure you included "use context7" in your prompt
2. Restart Claude after installation
3. Check if the MCP server is properly configured
4. Try a simple test: "Show me React useState hook. use context7"

### Package Not Found

**Issue**: "Cannot find package '@upstash/context7-mcp'"

**Solutions**:
```bash
# Clear npm cache
npm cache clean --force

# Try direct installation
npm install -g @upstash/context7-mcp

# Use alternative package manager
bunx @upstash/context7-mcp
```

### Timeout Issues

**Issue**: Context7 times out on slow connections

**Solution**: Add timeout configuration:
```json
{
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp"],
      "env": {},
      "timeout": 60000
    }
  }
}
```

## Integration with Other MCP Servers

Context7 works great alongside other MCP servers:

### With GitHub MCP
```
Check the React repository for implementation details and create a similar component. use context7
```

### With Filesystem MCP
```
Update my React components to use the latest syntax. use context7
```

### With Jina MCP
```
Search for React performance optimization techniques and implement them. use context7
```

## Performance Considerations

- **Caching** - Context7 caches documentation for efficiency
- **Selective Fetching** - Only fetches relevant documentation
- **Async Operation** - Doesn't block Claude's response
- **Lightweight** - Minimal overhead on system resources

## Privacy & Security

- **No Data Storage** - Context7 doesn't store your prompts
- **Direct Fetching** - Documentation comes directly from official sources
- **No Authentication** - No personal data or API keys required
- **Open Source** - Fully transparent implementation

## Examples in Action

### Creating a Modern Web App

```
Create a full-stack web application with:
- Next.js 14 with app router
- TypeScript for type safety
- Tailwind CSS for styling
- Prisma with PostgreSQL
- NextAuth.js for authentication
use context7
```

### Building an API

```
Build a RESTful API with:
- Express.js with TypeScript
- MongoDB with Mongoose
- JWT authentication
- Input validation with Joi
- API documentation with Swagger
use context7
```

### Learning New Technologies

```
Teach me how to:
- Use React Server Components
- Implement streaming SSR
- Add error boundaries
- Optimize for Core Web Vitals
use context7
```

## Comparison with Static Documentation

| Feature | Context7 | Static Docs in Training |
|---------|----------|------------------------|
| Currency | Always up-to-date | May be outdated |
| Coverage | Any library | Limited to training data |
| Versions | All versions | Single version |
| Examples | Real, working code | Potentially outdated |
| Access | Instant via prompt | Built into model |

## Community & Support

- **GitHub Repository**: [upstash/context7](https://github.com/upstash/context7)
- **Issues**: Report problems on GitHub
- **Updates**: Automatic via npm
- **Community**: Growing ecosystem of users

## Future Features

The Context7 team is working on:
- IDE integration improvements
- Offline documentation caching
- Custom documentation sources
- Enhanced version detection
- Multi-language documentation

## Why Use Context7?

1. **Accuracy** - No more outdated code examples
2. **Efficiency** - No manual documentation searching
3. **Learning** - Always learn the current best practices
4. **Productivity** - Faster, more accurate code generation
5. **Free** - No cost, no API keys, no limits

## Quick Reference

```bash
# Install
curl -sSL https://raw.githubusercontent.com/jezweb/how-to-claude-code/main/scripts/quick-install/install-context7.sh | bash

# Usage
Just add "use context7" to any prompt

# Example
"Create a React component. use context7"

# No configuration needed!
```

## Summary

Context7 is an essential MCP server for any developer using Claude Code. It ensures you're always working with the latest documentation and best practices, completely free of charge. Just add "use context7" to your prompts and enjoy accurate, up-to-date code generation!

Remember: **No API key needed, just add "use context7" to your prompts!**