# Basic Commands and Interactions

This guide covers the essential commands and interaction patterns you'll use every day with Claude Code.

## Interactive Commands

### Help System

```bash
/help                 # Show all available commands
/help mcp             # Help for MCP-specific commands
/help model           # Help for model selection
```

### Session Management

```bash
/clear                # Clear conversation history
/exit                 # Exit Claude Code
/restart              # Restart Claude Code session
```

### File Operations

```bash
/undo                 # Undo last file operation
/diff                 # Show recent changes
/diff filename.js     # Show changes in specific file
```

### Model Selection

```bash
/model                # Show current model
/model claude-3-opus  # Switch to Opus (most capable)
/model claude-3.5-sonnet # Switch to Sonnet (balanced)
/model claude-3-haiku # Switch to Haiku (fastest)
```

## Text Interaction Patterns

### File References

Reference files with `@` to give Claude context:

```
@src/components/Button.jsx what does this component do?
```

```
Can you optimize @utils/api.js for better performance?
```

```
Add error handling to @services/auth.js
```

### Multiple File References

```
Compare @src/old-auth.js and @src/new-auth.js and tell me what changed
```

```
Refactor @components/Header.jsx and @components/Footer.jsx to use shared styles
```

### Directory References

```
@src/components/ what components are available and how do they relate?
```

```
Analyze all files in @tests/ and suggest improvements
```

## Common Task Patterns

### Code Analysis

```
Explain what this function does:
[paste code]
```

```
What's wrong with this code?
[paste problematic code]
```

```
How can I optimize this algorithm?
[paste algorithm]
```

### Code Generation

```
Create a React component for a user profile card that takes name, email, and avatar props
```

```
Write a Python function that validates email addresses using regex
```

```
Generate a SQL query to find users who haven't logged in for 30 days
```

### Code Modification

```
Add TypeScript types to this JavaScript function:
[paste function]
```

```
Convert this class component to a functional component with hooks:
[paste React class]
```

```
Refactor this nested callback to use async/await:
[paste callback code]
```

### Testing

```
Write unit tests for @src/utils/validation.js
```

```
Create integration tests for the user registration flow
```

```
Add test cases for edge conditions in @src/math/calculator.js
```

### Debugging

```
Help me debug this error:
[paste stack trace]
```

```
Why is this function returning undefined?
[paste function code]
```

```
Find the performance bottleneck in @src/api/users.js
```

## Project-Level Commands

### Project Understanding

```
Analyze this codebase and explain its architecture
```

```
What's the tech stack and how are the components organized?
```

```
Show me the data flow from API to UI
```

### Setup and Configuration

```
Set up a new React project with TypeScript and testing
```

```
Configure ESLint and Prettier for this JavaScript project
```

```
Add Docker configuration for this Node.js app
```

### Documentation

```
Generate README documentation for this project
```

```
Create API documentation for @routes/api.js
```

```
Write inline comments for complex functions in @utils/algorithms.js
```

## Git Integration

### Git Status and History

```
What changes have I made since the last commit?
```

```
Show me the git log for the last 5 commits
```

```
What files are currently staged?
```

### Git Operations

```
Create a commit with the current changes
```

```
Help me write a good commit message for these changes
```

```
Review this pull request and suggest improvements
```

## Web Search Integration

### Finding Information

```
Search for the latest React performance best practices
```

```
Find documentation for the Express.js middleware pattern
```

```
Look up common security vulnerabilities in Node.js applications
```

### Technology Research

```
Compare React vs Vue vs Angular for a new project
```

```
Find examples of implementing authentication with JWT
```

```
Research database migration strategies for PostgreSQL
```

## Advanced Patterns

### Multi-step Tasks

```
I want to build a REST API. Can you:
1. Set up the Express server
2. Add database configuration
3. Create user routes
4. Add authentication middleware
5. Write tests
```

### Context Building

```
This is a Next.js e-commerce app. I need to add a shopping cart feature. 
The existing user model is in @models/User.js and products are in @models/Product.js.
Can you create the cart functionality?
```

### Iterative Development

```
Create a basic user login form
> Good! Now add form validation
> Perfect! Now add password strength checking
> Great! Now add forgot password functionality
```

## Best Practices for Commands

### Be Specific

❌ **Vague**: "Fix this code"
✅ **Specific**: "Fix the TypeError on line 42 where `user.name` is undefined"

❌ **Vague**: "Make it better"
✅ **Specific**: "Optimize this function for better performance and add error handling"

### Provide Context

❌ **No Context**: "Add a button"
✅ **With Context**: "Add a submit button to this form that validates data before sending to @api/users.js"

### Use File References

❌ **Manual**: "Look at the file src/components/Button.jsx"
✅ **Reference**: "Review @src/components/Button.jsx"

### Break Down Complex Tasks

❌ **Too Complex**: "Build a complete authentication system with social login, 2FA, and admin panel"
✅ **Broken Down**: 
```
Let's build authentication step by step:
1. First create basic login/register
2. Then add JWT tokens
3. Then add social login
4. Finally add 2FA
```

## Keyboard Shortcuts

### In Interactive Mode

- `Ctrl+C` - Interrupt current operation
- `Ctrl+D` - Exit Claude Code
- `↑` / `↓` - Navigate command history
- `Tab` - Autocomplete (where available)

### Text Editing

Most standard text editing shortcuts work:
- `Ctrl+A` - Select all
- `Ctrl+C` / `Ctrl+V` - Copy/paste
- `Ctrl+Z` - Undo typing

## Error Handling

### When Commands Fail

If a command doesn't work:
1. Check the error message
2. Verify file paths exist
3. Ensure proper permissions
4. Try rephrasing the request

### Common Issues

**File not found**: Use tab completion or check paths
**Permission denied**: Check file/directory permissions
**Command not recognized**: Use `/help` to see available commands
**Model limits**: Switch to a different model

## Tips for Effective Interaction

1. **Start with context**: Tell Claude about your project
2. **Use file references**: Help Claude understand your codebase
3. **Be iterative**: Build up complex solutions step by step
4. **Review changes**: Always check what Claude modified
5. **Ask questions**: Claude can explain its reasoning

## Next Steps

Now that you know the basic commands:
- [Understanding Context](./understanding-context.md) - How Claude reads your project
- [Core Features](../02-core-features/) - Deep dive into capabilities
- [Custom Commands](../04-custom-commands/) - Create your own shortcuts