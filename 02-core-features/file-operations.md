# File Operations with Claude Code

Claude Code excels at reading, writing, and manipulating files. This guide covers all file operations and best practices.

## Reading Files

### Single File Reading

```
Read @src/components/Button.jsx and explain what it does
```

```
What's in @package.json?
```

```
Show me the content of @.env.example
```

### Multiple File Reading

```
Compare @src/old-api.js and @src/new-api.js
```

```
Read all files in @src/utils/ and summarize their purposes
```

```
Look at @jest.config.js, @babel.config.js, and @webpack.config.js to understand the build setup
```

### Partial File Reading

For large files, Claude can focus on specific parts:

```
Show me just the exports from @src/api/index.js
```

```
What are the main functions in @src/services/auth.js?
```

```
List all the routes defined in @server/routes/users.js
```

## Writing Files

### Creating New Files

```
Create a new React component called UserCard in @src/components/UserCard.jsx
```

```
Write a utility function for date formatting in @src/utils/dateUtils.js
```

```
Create a test file for the Button component at @src/components/__tests__/Button.test.jsx
```

### File Creation with Context

```
Create @src/hooks/useAuth.js that works with our existing auth system in @src/services/auth.js
```

```
Write @src/types/User.ts based on the user object structure in @src/api/users.js
```

## Editing Files

### Targeted Edits

```
Add error handling to the login function in @src/auth.js
```

```
Add TypeScript types to @src/utils/api.js
```

```
Remove the deprecated functions from @src/legacy/oldUtils.js
```

### Bulk Edits

```
Add proper JSDoc comments to all functions in @src/utils/
```

```
Convert all class components in @src/components/ to functional components
```

```
Update all import statements to use absolute paths instead of relative
```

### Refactoring

```
Extract the validation logic from @src/forms/LoginForm.jsx into a separate utility
```

```
Split @src/services/api.js into separate files for each resource (users, products, orders)
```

```
Refactor @src/components/Dashboard.jsx to be more modular
```

## File Organization

### Restructuring

```
The @src/components/ directory is getting messy. Help me organize it better.
```

```
Move all utility functions from @src/helpers/ to @src/utils/ and update imports
```

```
Create a proper folder structure for the API routes in @server/routes/
```

### File Naming

```
Rename @src/comp.js to follow our naming convention
```

```
All test files should end with .test.js - update @src/tests/
```

```
Ensure all TypeScript files use .ts or .tsx extensions in @src/
```

## File Analysis

### Code Quality

```
Analyze @src/components/UserProfile.jsx for code quality issues
```

```
Check @src/api/users.js for potential security vulnerabilities
```

```
Review @src/utils/validation.js for performance improvements
```

### Dependencies

```
What external packages does @src/services/payment.js depend on?
```

```
Find all files that import from @src/utils/api.js
```

```
Which components use the useAuth hook?
```

### Metrics

```
How many lines of code are in @src/components/?
```

```
What's the complexity of @src/algorithms/pathfinding.js?
```

```
Count the number of functions in @src/utils/
```

## File Operations Best Practices

### 1. Always Reference Files

❌ **Vague**: "Edit the main component"
✅ **Specific**: "Edit @src/App.jsx"

❌ **Unclear**: "Look at the config file"
✅ **Clear**: "Check @webpack.config.js"

### 2. Provide Context for Edits

❌ **No context**: "Add a function to this file"
✅ **With context**: "Add a logout function to @src/auth.js that clears localStorage and redirects to login"

### 3. Specify Location for New Files

❌ **Unclear**: "Create a new component"
✅ **Clear**: "Create a new component at @src/components/Sidebar.jsx"

### 4. Be Explicit About Requirements

```
Create @src/api/products.js with:
- CRUD operations for products
- Error handling
- TypeScript types
- JSDoc documentation
- Similar structure to @src/api/users.js
```

## Advanced File Operations

### File Templates

```
Create a new React component at @src/components/Modal.jsx using the same pattern as @src/components/Button.jsx
```

```
Generate a new API route at @server/routes/products.js following the structure of @server/routes/users.js
```

### Batch Operations

```
Add PropTypes to all React components in @src/components/ that don't have them
```

```
Update all console.log statements in @src/ to use our logger from @src/utils/logger.js
```

```
Add 'use strict' to all JavaScript files in @server/
```

### File Migration

```
Convert @src/components/OldButton.jsx from class component to functional component with the same functionality
```

```
Migrate @src/api/legacy.js to use async/await instead of callbacks
```

```
Update @src/styles/oldStyles.css to use CSS modules like @src/styles/Button.module.css
```

## File Safety

### Backup Before Major Changes

```
Before refactoring @src/services/database.js, show me what changes you'll make
```

```
Preview the changes to @src/components/App.jsx before applying them
```

### Incremental Changes

```
Refactor @src/utils/api.js in small steps:
1. First add TypeScript types
2. Then add error handling
3. Finally optimize performance
```

### Rollback Options

```
Undo the last changes to @src/components/Button.jsx
```

```
Show me what changed in @src/api/users.js since my last commit
```

## Common File Operations

### Configuration Files

```
Update @package.json to add a new script for building documentation
```

```
Add TypeScript configuration to @tsconfig.json for strict mode
```

```
Configure @eslint.config.js to use our team's coding standards
```

### Documentation

```
Generate a README.md for the @src/components/ directory
```

```
Add inline documentation to @src/api/auth.js
```

```
Create @docs/API.md documenting all endpoints from @server/routes/
```

### Testing Files

```
Create comprehensive tests for @src/utils/validation.js at @src/utils/__tests__/validation.test.js
```

```
Add integration tests for @src/api/users.js
```

```
Update @src/components/__tests__/Button.test.jsx to test all props
```

## File Operation Patterns

### Read-Analyze-Write

1. **Read**: "Show me @src/components/Form.jsx"
2. **Analyze**: "What could be improved?"
3. **Write**: "Apply those improvements"

### Compare-Sync

1. **Compare**: "How does @src/api/users.js differ from @src/api/products.js?"
2. **Sync**: "Make them consistent"

### Template-Generate

1. **Template**: "Use @src/components/Button.jsx as a template"
2. **Generate**: "Create @src/components/Input.jsx with similar structure"

## Troubleshooting File Operations

### File Not Found

```
Error: Cannot read file '@src/components/Missing.jsx'

Solutions:
1. Check the file path
2. Verify the file exists
3. Use tab completion for paths
```

### Permission Denied

```
Error: Permission denied writing to '@protected/file.js'

Solutions:
1. Check file permissions
2. Ensure directory is writable
3. Run with appropriate permissions
```

### Large Files

```
For files over 1000 lines:
1. Ask for specific sections
2. Use incremental edits
3. Break into smaller files
```

## File Operations Checklist

Before major file operations:

- [ ] Understand current file structure
- [ ] Identify dependencies
- [ ] Plan the changes
- [ ] Consider impact on other files
- [ ] Have rollback plan
- [ ] Test changes incrementally

## Next Steps

- [Code Navigation](./code-navigation.md) - Finding and understanding code
- [Git Operations](./git-operations.md) - Version control integration
- [Testing & Debugging](./testing-debugging.md) - Quality assurance