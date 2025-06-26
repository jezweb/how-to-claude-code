# Your First Claude Code Session

Welcome! This guide will walk you through your first interaction with Claude Code, from startup to completing your first task.

## Starting Claude Code

Open your terminal and simply type:

```bash
claude
```

You'll see a welcome message:
```
Welcome to Claude Code!
Type your message or /help for commands.
>
```

## Basic Interaction

### Your First Request

Try a simple task:
```
> What files are in this directory?
```

Claude will use tools to explore and respond:
```
I'll check what files are in the current directory.

[Uses LS tool to list files]

Here are the files in the current directory:
- README.md
- package.json
- src/
  - index.js
  - utils.js
- tests/
  - index.test.js
```

### Understanding Tool Usage

When Claude needs to:
- **Read files**: You'll see `[Reading file: filename]`
- **Write files**: You'll see `[Writing to: filename]`
- **Run commands**: You'll see `[Running: command]`
- **Search code**: You'll see `[Searching for: pattern]`

## Common First Tasks

### 1. Explore a Codebase
```
> Help me understand this codebase. What does it do and how is it structured?
```

Claude will:
- Read key files (README, package.json)
- Explore directory structure
- Identify main components
- Explain the architecture

### 2. Fix a Bug
```
> There's a bug in src/utils.js where the formatDate function returns undefined. Can you fix it?
```

Claude will:
- Read the file
- Identify the issue
- Show you the fix
- Apply the changes

### 3. Write Tests
```
> Can you write tests for the functions in src/utils.js?
```

Claude will:
- Analyze the code
- Determine test framework
- Write comprehensive tests
- Create/update test files

### 4. Refactor Code
```
> The index.js file is getting too large. Can you help me refactor it into smaller modules?
```

Claude will:
- Analyze dependencies
- Suggest a structure
- Create new files
- Update imports

## Using Context

### File References

Reference specific files with `@`:
```
> Explain what @src/api/auth.js does
```

### Web Search

Ask Claude to search for information:
```
> Search for the latest React best practices for performance optimization
```

### Git Integration

Work with version control:
```
> What changes have I made since the last commit?
```

## Command Mode

### Essential Commands

- `/help` - Show available commands
- `/clear` - Clear the conversation
- `/exit` - Exit Claude Code
- `/undo` - Undo last file operation
- `/diff` - Show recent changes

### Model Selection

```
> /model claude-3-opus
> /model claude-3.5-sonnet
```

## Best Practices for New Users

### 1. Be Specific
❌ "Fix the bug"
✅ "Fix the TypeError in line 42 of src/utils.js"

### 2. Provide Context
❌ "Write a function"
✅ "Write a function that validates email addresses using regex"

### 3. Iterate
Don't expect perfection on the first try:
```
> Create a React component for a user profile
> Can you add prop validation to that component?
> Now add error handling for missing data
```

### 4. Review Changes
Always review what Claude does:
```
> Show me what changes you made to the file
```

## Understanding Claude's Capabilities

### What Claude CAN Do
- ✅ Read and write files
- ✅ Execute terminal commands
- ✅ Search codebases
- ✅ Refactor code
- ✅ Write tests
- ✅ Debug issues
- ✅ Explain code
- ✅ Integrate with Git

### What Claude CANNOT Do
- ❌ Access external services without MCP
- ❌ Modify system files without permission
- ❌ Remember previous sessions
- ❌ Access the internet without tools

## Your First Project

Let's create a simple Node.js project:

```
> Create a new Node.js project with Express that has a simple REST API for managing todos
```

Claude will:
1. Create project structure
2. Initialize package.json
3. Install dependencies
4. Create Express server
5. Add TODO routes
6. Create example tests
7. Add a README

## Troubleshooting First Session

### Claude Seems Slow
- Large codebases take time to analyze
- File operations are shown in real-time
- Be patient with complex requests

### Commands Not Working
- Ensure you're in the right directory
- Check Node.js/npm are installed
- Verify Claude has file permissions

### Unexpected Results
- Be more specific in your requests
- Break complex tasks into steps
- Use `/undo` if needed

## Next Steps

Now that you've completed your first session:

1. **Explore More**
   - Try different types of requests
   - Work with your actual projects
   - Test Claude's capabilities

2. **Learn Advanced Features**
   - [Custom Commands](../04-custom-commands/creating-commands.md)
   - [MCP Servers](../03-mcp-servers/what-is-mcp.md)
   - [Best Practices](../09-best-practices/prompt-engineering.md)

3. **Integrate Into Workflow**
   - Use for code reviews
   - Automate repetitive tasks
   - Improve code quality

## Session Management

### Saving Work
Claude automatically saves file changes, but remember to:
- Commit changes to Git
- Review modifications
- Test the code

### Ending a Session
```
> /exit
```
or press `Ctrl+C`

## Tips for Success

1. **Start Small**: Begin with simple tasks
2. **Build Context**: Help Claude understand your project
3. **Iterate Often**: Refine requests based on results
4. **Stay Engaged**: Review and guide Claude's work
5. **Learn Patterns**: Notice what works well

Congratulations on completing your first Claude Code session! 🎉