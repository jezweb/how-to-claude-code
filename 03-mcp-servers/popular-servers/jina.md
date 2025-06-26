# Jina MCP Server

The Jina MCP server provides Claude Code with powerful AI-powered search, content extraction, and document processing capabilities using Jina AI's services.

## Installation

```bash
# Install from GitHub repository
npm install -g PsychArch/jina-mcp-tools

# Or use npx directly (recommended)
npx jina-mcp-tools
```

## Configuration

Add to your `~/.claude/claude.json`:

```json
{
  "mcpServers": {
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

## Authentication Setup

### 1. Get Jina API Key

1. Visit [Jina AI](https://jina.ai)
2. Sign up or log in to your account
3. Navigate to API Keys section
4. Generate a new API key
5. Copy the key for configuration

### 2. Set Environment Variable

```bash
# Add to your shell profile (.bashrc, .zshrc, etc.)
export JINA_API_KEY="jina_your-api-key-here"
```

**⚠️ Security Note**: Never hardcode API keys in configuration files. Always use environment variables to keep your credentials secure.

## Core Features

### Web Content Extraction

#### Basic Web Scraping

```
Extract the main content from https://example.com/article
```

```
Get a clean, readable version of this webpage: https://docs.example.com/guide
```

```
Scrape and summarize the content from https://blog.example.com/post
```

#### Advanced Extraction

```
Extract structured data from https://example.com/products:
- Product names
- Prices
- Descriptions
- Availability
```

```
Get all code examples from this documentation page: https://docs.example.com/api
```

```
Extract and format the table data from https://example.com/pricing
```

### Search Capabilities

#### Web Search

```
Search for "Claude Code MCP servers documentation" and summarize the top results
```

```
Find recent articles about "AI code generation tools" from the last month
```

```
Search for tutorials on "React Server Components" and extract key concepts
```

#### Semantic Search

```
Find content similar to "machine learning model deployment best practices"
```

```
Search for documents related to "microservices architecture patterns" and compare approaches
```

```
Find academic papers about "transformer neural networks" and summarize findings
```

### Document Processing

#### PDF Analysis

```
Extract text from https://example.com/whitepaper.pdf and summarize key points
```

```
Analyze this PDF research paper and extract:
- Abstract
- Methodology
- Results
- Conclusions
```

```
Convert this PDF documentation to markdown: https://example.com/manual.pdf
```

#### Multi-format Support

```
Process this document and extract structured information:
- URL: https://example.com/report.docx
- Extract: tables, headings, key metrics
```

```
Compare these two documents for similarities:
- https://example.com/v1/spec.pdf
- https://example.com/v2/spec.pdf
```

### Content Generation

#### Summarization

```
Create a concise summary of this lengthy article: https://example.com/research
```

```
Generate an executive summary from this technical documentation: https://docs.example.com
```

```
Summarize this webpage in bullet points for a presentation
```

#### Content Transformation

```
Convert this blog post to a technical documentation format: https://blog.example.com/tutorial
```

```
Transform this FAQ page into a conversational Q&A format: https://example.com/faq
```

```
Rewrite this technical content for a non-technical audience: https://docs.example.com/advanced
```

## Advanced Use Cases

### Research Assistant

#### Literature Review

```
Research "quantum computing applications" and:
1. Find recent papers and articles
2. Extract key findings
3. Identify common themes
4. Create a bibliography
```

```
Analyze competing products by extracting features from:
- https://competitor1.com/features
- https://competitor2.com/features
- https://competitor3.com/features
Create a comparison matrix
```

#### Knowledge Synthesis

```
Gather information about "sustainable architecture" from multiple sources and create a comprehensive overview
```

```
Research best practices for "API design" and compile guidelines from top tech companies
```

### Content Monitoring

#### Change Detection

```
Compare the current version of https://example.com/terms with the cached version and highlight changes
```

```
Monitor these documentation pages for updates:
- https://docs.example.com/api/v2
- https://docs.example.com/changelog
- https://docs.example.com/migration
```

#### Content Validation

```
Check if these URLs are still accessible and contain expected content:
- Product page should mention "free trial"
- Documentation should include "API reference"
- Support page should have contact information
```

### Data Extraction

#### Structured Data Mining

```
Extract all email addresses from https://example.com/contact
```

```
Find and extract all API endpoints mentioned in https://docs.example.com/api
```

```
Extract pricing information from multiple competitor websites and create a comparison table
```

#### Pattern Recognition

```
Analyze https://example.com/blog and identify:
- Publishing frequency
- Common topics
- Author information
- Content categories
```

## Integration Examples

### With Claude Code Workflows

#### Documentation Generation

```
# Generate API documentation from multiple sources
1. Extract API information from https://api.example.com/docs
2. Find code examples from https://github.com/example/samples
3. Combine into comprehensive documentation
4. Format as markdown
```

#### Code Research

```
# Research implementation approaches
1. Search for "implementing OAuth 2.0 in Node.js"
2. Extract code examples from top results
3. Compare different approaches
4. Generate implementation guide
```

### With Other MCP Servers

#### Jina + GitHub

```
# Analyze competitor repositories
1. Use Jina to find competitor websites
2. Extract their GitHub repository links
3. Use GitHub MCP to analyze their code structure
4. Generate comparison report
```

#### Jina + Filesystem

```
# Create local documentation from web sources
1. Use Jina to extract documentation from multiple URLs
2. Process and format the content
3. Use Filesystem MCP to save as local markdown files
4. Organize into documentation structure
```

## Configuration Options

### Advanced Configuration

```json
{
  "mcpServers": {
    "jina-mcp-tools": {
      "command": "npx",
      "args": ["jina-mcp-tools"],
      "env": {
        "JINA_API_KEY": "${JINA_API_KEY}",
        "JINA_TIMEOUT": "30000",
        "JINA_MAX_RETRIES": "3",
        "JINA_CACHE_ENABLED": "true",
        "JINA_CACHE_TTL": "3600"
      }
    }
  }
}
```

### Environment Variables

```bash
# Required
export JINA_API_KEY="your-api-key"

# Optional configuration
export JINA_TIMEOUT="30000"           # Request timeout in milliseconds
export JINA_MAX_RETRIES="3"           # Maximum retry attempts
export JINA_CACHE_ENABLED="true"      # Enable response caching
export JINA_CACHE_TTL="3600"          # Cache time-to-live in seconds
export JINA_DEBUG="true"              # Enable debug logging
```

## Best Practices

### API Key Security

1. **Never commit API keys** to version control
2. **Use environment variables** for API keys
3. **Rotate keys regularly** for security
4. **Use separate keys** for development and production
5. **Monitor usage** to detect unauthorized access

### Efficient Usage

1. **Cache responses** to avoid redundant API calls
2. **Batch requests** when processing multiple URLs
3. **Use specific extraction** rather than full page content
4. **Set appropriate timeouts** for large documents
5. **Handle rate limits** gracefully

### Content Processing

1. **Validate URLs** before processing
2. **Check content type** compatibility
3. **Handle errors gracefully** for inaccessible content
4. **Process incrementally** for large datasets
5. **Respect robots.txt** and website policies

## Troubleshooting

### Common Issues

**Authentication Error:**
```
Error: Invalid Jina API key

Solutions:
1. Verify API key is correct
2. Check key hasn't expired
3. Ensure key has necessary permissions
4. Verify environment variable is set
```

**Content Extraction Failed:**
```
Error: Failed to extract content from URL

Solutions:
1. Verify URL is accessible
2. Check if site requires authentication
3. Ensure content type is supported
4. Try with different extraction parameters
```

**Rate Limit Exceeded:**
```
Error: Jina API rate limit exceeded

Solutions:
1. Implement request throttling
2. Use caching for repeated requests
3. Upgrade API plan if needed
4. Batch process during off-peak hours
```

### Debug Mode

Enable debug logging:

```json
{
  "mcpServers": {
    "jina-mcp-tools": {
      "command": "npx",
      "args": ["jina-mcp-tools", "--debug"],
      "env": {
        "JINA_API_KEY": "${JINA_API_KEY}",
        "JINA_DEBUG": "true"
      }
    }
  }
}
```

## Use Case Examples

### Market Research

```
# Competitor Analysis Workflow
1. Search for "project management software reviews 2024"
2. Extract features from top 10 competitor websites
3. Analyze pricing pages for cost comparison
4. Extract customer testimonials
5. Generate comprehensive market analysis report
```

### Documentation Aggregation

```
# Create unified documentation
1. Extract API docs from https://api.service1.com/docs
2. Extract SDK guide from https://sdk.service1.com
3. Get examples from https://github.com/service1/examples
4. Combine into single documentation set
5. Format consistently and save locally
```

### Content Migration

```
# Migrate blog content
1. Extract all articles from https://oldblog.example.com
2. Parse metadata (title, date, author, tags)
3. Convert formatting to markdown
4. Organize by categories
5. Prepare for import to new platform
```

### Academic Research

```
# Literature review automation
1. Search for papers on "machine learning in healthcare"
2. Extract abstracts and key findings
3. Identify common methodologies
4. Create citation list
5. Generate literature review outline
```

## Performance Tips

1. **Parallel Processing** - Process multiple URLs concurrently
2. **Selective Extraction** - Only extract needed content
3. **Response Caching** - Cache frequently accessed content
4. **Batch Operations** - Group similar requests
5. **Progressive Loading** - Process large documents in chunks

## Resources

- [Jina MCP Tools Repository](https://github.com/PsychArch/jina-mcp-tools)
- [Jina AI Documentation](https://docs.jina.ai)
- [Jina API Reference](https://api.jina.ai/docs)
- [Jina AI Examples](https://github.com/jina-ai/examples)