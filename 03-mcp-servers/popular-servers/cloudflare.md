# Cloudflare MCP Servers

Cloudflare offers multiple MCP servers that enable Claude Code to interact with various Cloudflare services. This guide covers setup and usage for each server.

## Available Cloudflare MCP Servers

1. **Workers & Bindings** - Manage Workers, KV, R2, D1, and more
2. **Observability** - Monitor Workers performance and logs
3. **AI Gateway** - Manage AI Gateway configurations
4. **DNS Analytics** - Analyze DNS traffic and settings

## Installation

First, install the MCP remote tool if you haven't already:
```bash
npm install -g @cloudflare/mcp-remote
```

## Configuration

Add to your `~/.claude/claude.json`:

```json
{
  "mcpServers": {
    "cloudflare-workers": {
      "command": "npx",
      "args": [
        "-y",
        "@cloudflare/mcp-server-cloudflare-workers"
      ],
      "env": {
        "CLOUDFLARE_API_TOKEN": "${CLOUDFLARE_API_TOKEN}",
        "CLOUDFLARE_ACCOUNT_ID": "${CLOUDFLARE_ACCOUNT_ID}"
      }
    },
    "cloudflare-observability": {
      "command": "npx",
      "args": [
        "-y",
        "@cloudflare/mcp-server-cloudflare-observability"
      ],
      "env": {
        "CLOUDFLARE_API_TOKEN": "${CLOUDFLARE_API_TOKEN}",
        "CLOUDFLARE_ACCOUNT_ID": "${CLOUDFLARE_ACCOUNT_ID}"
      }
    },
    "cloudflare-ai-gateway": {
      "command": "npx",
      "args": [
        "-y",
        "@cloudflare/mcp-server-cloudflare-ai-gateway"
      ],
      "env": {
        "CLOUDFLARE_API_TOKEN": "${CLOUDFLARE_API_TOKEN}",
        "CLOUDFLARE_ACCOUNT_ID": "${CLOUDFLARE_ACCOUNT_ID}"
      }
    },
    "cloudflare-dns-analytics": {
      "command": "npx",
      "args": [
        "-y",
        "@cloudflare/mcp-server-cloudflare-dns-analytics"
      ],
      "env": {
        "CLOUDFLARE_API_TOKEN": "${CLOUDFLARE_API_TOKEN}",
        "CLOUDFLARE_ACCOUNT_ID": "${CLOUDFLARE_ACCOUNT_ID}"
      }
    }
  }
}
```

## Setting Up Authentication

### 1. Get Your API Token

1. Go to [Cloudflare Dashboard](https://dash.cloudflare.com/profile/api-tokens)
2. Click "Create Token"
3. Use a template or create custom token with required permissions:
   - **Workers**: Workers Scripts:Edit, Account:Workers R2 Storage:Edit
   - **Observability**: Account:Workers Tail:Read, Account:Workers Scripts:Read
   - **AI Gateway**: Account:AI Gateway:Edit
   - **DNS**: Zone:DNS:Read, Zone:Analytics:Read

### 2. Get Your Account ID

1. Go to any domain in your Cloudflare dashboard
2. Find Account ID in the right sidebar
3. Copy the ID

### 3. Set Environment Variables

```bash
export CLOUDFLARE_API_TOKEN="your-api-token"
export CLOUDFLARE_ACCOUNT_ID="your-account-id"
```

Add to your shell profile to make permanent.

## Using Cloudflare Workers MCP

### List Workers
```
Claude, can you list all my Cloudflare Workers?
```

### View Worker Code
```
Show me the code for my worker named 'api-handler'
```

### Deploy a Worker
```
Deploy this code as a new Worker called 'hello-world':
```javascript
export default {
  async fetch(request) {
    return new Response('Hello World!');
  }
}
```

### Manage KV Namespaces
```
Create a new KV namespace called 'user-sessions'
```

### Work with R2 Buckets
```
List all my R2 buckets and their sizes
```

## Using Cloudflare Observability MCP

### View Worker Logs
```
Show me the last 50 logs from my 'api-handler' worker
```

### Query Performance Metrics
```
What's the p99 latency for my workers in the last hour?
```

### Find Errors
```
Find all 500 errors in my workers from the last 24 hours
```

### Analyze Traffic
```
Show me request patterns for my 'image-resizer' worker
```

## Using Cloudflare AI Gateway MCP

### List AI Gateways
```
Show me all my AI Gateway configurations
```

### View Gateway Logs
```
Show logs for my 'production-ai' gateway
```

### Analyze AI Usage
```
What models are being used most through my AI Gateway?
```

## Using Cloudflare DNS Analytics MCP

### DNS Reports
```
Generate a DNS report for example.com for the last 7 days
```

### Zone Analysis
```
Show me DNS query patterns for my domain
```

### Security Insights
```
Are there any suspicious DNS queries to my domains?
```

## Practical Examples

### Example 1: Deploy a Full Stack Worker

```
Claude, I want to deploy a new Worker that:
1. Handles GET requests with a JSON response
2. Stores data in KV
3. Has proper error handling
Call it 'data-api'
```

### Example 2: Debug Production Issues

```
My worker 'checkout-handler' is returning 500 errors. Can you:
1. Check the recent logs
2. Find the error patterns
3. Show me the current code
4. Suggest fixes
```

### Example 3: Performance Optimization

```
Analyze the performance of all my Workers and:
1. Identify the slowest endpoints
2. Show me p95 and p99 latencies
3. Find any Workers with high error rates
4. Suggest optimizations
```

## Advanced Usage

### Combining Multiple Servers

```
Using both Workers and Observability servers, can you:
1. List all my Workers
2. Show performance metrics for each
3. Identify which ones need optimization
4. Show me the code for the slowest one
```

### Automated Monitoring

```
Check my Workers' health every hour and alert me if:
- Error rate exceeds 1%
- P99 latency exceeds 500ms
- Any Worker is returning 500s
```

## Troubleshooting

### Common Issues

1. **Authentication Failed**
   - Verify API token has correct permissions
   - Check Account ID is correct
   - Ensure environment variables are set

2. **Server Won't Start**
   - Update to latest version: `npm update -g @cloudflare/mcp-server-cloudflare-workers`
   - Check Node.js version (18+ required)

3. **Can't Access Resources**
   - Verify token permissions match required scopes
   - Check you're using correct account ID
   - Ensure resources exist in your account

### Debug Commands

```bash
# Test API token
curl -X GET "https://api.cloudflare.com/client/v4/user/tokens/verify" \
  -H "Authorization: Bearer YOUR_TOKEN"

# Check server directly
npx @cloudflare/mcp-server-cloudflare-workers
```

## Best Practices

1. **Use Specific Permissions**
   - Create tokens with minimal required permissions
   - Use different tokens for different environments

2. **Monitor Usage**
   - Regular check API usage to avoid limits
   - Set up alerts for critical Workers

3. **Organize Workers**
   - Use consistent naming conventions
   - Group related Workers
   - Document Worker purposes

4. **Security**
   - Never commit API tokens
   - Rotate tokens regularly
   - Use wrangler for sensitive operations

## Resources

- [Cloudflare Workers Docs](https://developers.cloudflare.com/workers/)
- [Cloudflare API Docs](https://developers.cloudflare.com/api/)
- [Wrangler CLI](https://developers.cloudflare.com/workers/wrangler/)
- [MCP Server Source](https://github.com/cloudflare/mcp-servers)