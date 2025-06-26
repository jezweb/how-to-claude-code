# Filesystem MCP Server

The Filesystem MCP server provides Claude Code with controlled access to local files and directories, enabling file operations beyond the current project.

## Installation

```bash
npm install -g @modelcontextprotocol/server-filesystem
```

## Basic Configuration

Add to your `~/.claude/claude.json`:

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/path/to/allowed/directory"],
      "env": {
        "NODE_ENV": "development"
      }
    }
  }
}
```

## Security Configuration

### Restricted Access

For security, limit access to specific directories:

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "-y", 
        "@modelcontextprotocol/server-filesystem",
        "/home/user/projects",
        "/home/user/documents/templates"
      ]
    }
  }
}
```

### Multiple Scoped Servers

Configure different servers for different purposes:

```json
{
  "mcpServers": {
    "fs-projects": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/home/user/projects"],
      "env": {
        "FS_DESCRIPTION": "Project files access"
      }
    },
    "fs-config": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/home/user/.config"],
      "env": {
        "FS_DESCRIPTION": "Configuration files access"
      }
    }
  }
}
```

## File Operations

### Reading Files

```
Read the contents of /home/user/projects/my-app/package.json
```

```
Show me all markdown files in /home/user/documents/
```

```
Compare the config files:
- /home/user/.config/app1/config.json
- /home/user/.config/app2/config.json
```

### Writing Files

```
Create a new file at /home/user/projects/templates/react-component.jsx with a basic React component template
```

```
Write a shell script to /home/user/scripts/deploy.sh that:
1. Builds the project
2. Runs tests
3. Deploys to staging
```

### File Management

```
Copy /home/user/projects/app1/webpack.config.js to /home/user/projects/app2/
```

```
Move all .log files from /home/user/temp/ to /home/user/logs/archive/
```

```
Delete old backup files in /home/user/backups/ older than 30 days
```

## Directory Operations

### Directory Exploration

```
List all directories in /home/user/projects/
```

```
Show the structure of /home/user/workspace/ with file counts
```

```
Find all package.json files under /home/user/projects/
```

### Directory Management

```
Create a new project structure at /home/user/projects/new-app/:
- src/
- tests/
- docs/
- public/
```

```
Organize files in /home/user/downloads/ by file type into subdirectories
```

```
Clean up empty directories in /home/user/temp/
```

## Search Operations

### File Search

```
Find all JavaScript files containing "TODO" in /home/user/projects/
```

```
Search for files modified in the last 7 days in /home/user/workspace/
```

```
Locate configuration files (*.config.js, *.json) across all projects
```

### Content Search

```
Search for "database connection" in all files under /home/user/projects/
```

```
Find files containing environment variables (process.env) in my projects
```

```
Locate all references to "deprecated" functions across the codebase
```

## Backup and Sync Operations

### Creating Backups

```
Create a backup of /home/user/projects/important-app/ to /home/user/backups/
```

```
Backup only the source code files (exclude node_modules, .git) from /home/user/projects/app/
```

```
Create incremental backup of changed files since last backup
```

### Synchronization

```
Sync configuration files between:
- /home/user/projects/app1/.config/
- /home/user/projects/app2/.config/
```

```
Keep documentation synchronized between multiple project versions
```

## Template Management

### Creating Templates

```
Create project templates in /home/user/templates/:
- react-app/
- express-api/
- static-site/
```

```
Save the current project structure as a template for future use
```

### Using Templates

```
Create a new React project at /home/user/projects/new-app/ using the template from /home/user/templates/react-app/
```

```
Apply the Express API template to set up /home/user/projects/backend/
```

## Configuration Management

### Config File Operations

```
Update all .env.example files in my projects with new required variables
```

```
Standardize ESLint configuration across all projects in /home/user/projects/
```

```
Copy database configuration from the main app to microservices
```

### Environment Management

```
Create environment-specific config files:
- development.json
- staging.json  
- production.json
```

```
Validate configuration files for required fields and proper format
```

## Log File Management

### Log Analysis

```
Analyze error logs in /home/user/logs/ to find common patterns
```

```
Summarize application logs from the last 24 hours
```

```
Find correlation between error spikes and deployment times
```

### Log Cleanup

```
Rotate log files in /home/user/logs/:
- Compress files older than 7 days
- Delete files older than 30 days
- Maintain most recent logs
```

```
Clean up development logs and temp files across all projects
```

## Multi-Project Operations

### Cross-Project Analysis

```
Compare package.json dependencies across all projects in /home/user/projects/
```

```
Find projects using outdated dependencies
```

```
Identify common utility functions that could be extracted to a shared library
```

### Bulk Updates

```
Update all projects to use the latest version of a specific library
```

```
Add a new npm script to all package.json files in my projects
```

```
Apply security fixes across all Node.js projects
```

## Development Workflows

### Project Setup

```
Set up a new project workspace:
1. Create directory structure
2. Initialize git repository
3. Copy template files
4. Install dependencies
5. Create initial documentation
```

### Code Organization

```
Reorganize project files to follow best practices:
- Move utilities to utils/
- Organize components by feature
- Separate business logic
- Update import paths
```

### Documentation

```
Generate documentation from code comments across all projects
```

```
Create API documentation from OpenAPI specs in each service
```

```
Update README files with current project information
```

## Security Considerations

### File Permissions

The filesystem server respects system file permissions:

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/safe/directory"],
      "env": {
        "FS_READ_ONLY": "true"
      }
    }
  }
}
```

### Access Control

**Allowed directories only:**
- Server only accesses specified paths
- Cannot access system directories
- Respects user permissions

**Best practices:**
- Use specific directory paths
- Avoid giving access to sensitive directories
- Regular audit of access patterns

## Performance Optimization

### Large File Handling

```
Process large log files efficiently:
- Stream reading for large files
- Batch processing for multiple files
- Memory-conscious operations
```

### Caching

```
Cache frequently accessed file metadata
Optimize repeated directory listings
Use file watching for change detection
```

## Integration Examples

### With Build Tools

```
Integrate filesystem operations with build process:
1. Clean build directories
2. Copy static assets
3. Generate distribution files
4. Update version numbers
```

### With Git Operations

```
Coordinate filesystem and git operations:
1. Stage specific file changes
2. Ignore certain file types
3. Manage gitignored files separately
4. Clean up untracked files
```

## Troubleshooting

### Permission Issues

```
Error: EACCES: permission denied

Solutions:
1. Check file/directory permissions
2. Verify user access rights
3. Use sudo if necessary (carefully)
4. Adjust directory ownership
```

### Path Issues

```
Error: ENOENT: no such file or directory

Solutions:
1. Verify path exists
2. Check for typos in path
3. Use absolute paths
4. Ensure proper path separators
```

### Large File Operations

```
Error: File too large

Solutions:
1. Use streaming for large files
2. Process files in chunks
3. Increase memory limits
4. Consider alternative approaches
```

## Advanced Use Cases

### Automated Workflows

```
Create automated file management workflows:
- Daily backup routines
- Log rotation schedules
- Dependency update checks
- Code quality reports
```

### Development Tools

```
Build development utilities:
- Project scaffolding
- Code generation
- File synchronization
- Configuration management
```

## Best Practices

1. **Limit Access Scope** - Only grant access to necessary directories
2. **Regular Cleanup** - Remove temporary and old files regularly
3. **Backup Important Data** - Before bulk operations
4. **Monitor File Operations** - Keep track of large changes
5. **Use Version Control** - For important configuration changes

## Resources

- [Node.js File System API](https://nodejs.org/api/fs.html)
- [File System Security Best Practices](https://owasp.org/www-community/vulnerabilities/Path_Traversal)
- [Unix File Permissions](https://en.wikipedia.org/wiki/File-system_permissions)