# Prompt Engineering for Claude Code

Effective prompts are key to getting the best results from Claude Code. This guide teaches you how to craft prompts that lead to accurate, efficient, and helpful responses.

## Fundamentals of Good Prompts

### Be Specific and Clear

❌ **Vague**: "Fix this code"
✅ **Specific**: "Fix the null pointer exception in the `getUserData` function at line 42 of @src/auth.js"

❌ **Unclear**: "Make it better"  
✅ **Clear**: "Optimize this function for better performance by reducing time complexity from O(n²) to O(n)"

### Provide Context

❌ **No Context**: "Add a button"
✅ **With Context**: "Add a 'Save Draft' button to the blog post editor that saves to localStorage and shows a confirmation message"

### Use File References

❌ **Manual**: "Look at the file in the components folder called Button"
✅ **Reference**: "Review @src/components/Button.jsx for the styling pattern"

## Prompt Structure Patterns

### The GOAL Pattern

**G**oal - What you want to achieve
**O**bject - What you're working with  
**A**ction - What should be done
**L**imits - Any constraints or requirements

Example:
```
Goal: Create a user authentication system
Object: @src/auth/ directory and @src/api/users.js
Action: Implement JWT-based login with password reset
Limits: Must work with existing database schema, follow security best practices
```

### The CONTEXT-TASK-FORMAT Pattern

**Context**: Background information
**Task**: Specific request
**Format**: How you want the output

Example:
```
Context: This is a React e-commerce app using TypeScript and Redux Toolkit
Task: Create a shopping cart component that manages item quantities
Format: Component with TypeScript interfaces, unit tests, and usage documentation
```

## Task-Specific Prompt Patterns

### Code Review Prompts

```
Review @src/components/PaymentForm.jsx for:
1. Security vulnerabilities (especially payment data handling)
2. Input validation completeness
3. Error handling robustness
4. Code organization and readability
5. TypeScript usage effectiveness

Provide specific recommendations with code examples.
```

### Debugging Prompts

```
Debug this error in @src/api/orders.js:
Error: "Cannot read property 'total' of undefined"
Context: Happens when users have empty carts
Environment: Production, affects 3% of users
Last working: Before yesterday's deployment

Analyze the root cause and provide a fix with error prevention.
```

### Feature Implementation Prompts

```
Implement a dark mode toggle feature:
- Add theme context to @src/contexts/ThemeContext.jsx
- Update @src/components/ThemeToggle.jsx
- Modify CSS variables in @src/styles/variables.css
- Persist preference in localStorage
- Follow the existing pattern in @src/contexts/AuthContext.jsx
```

## Advanced Prompting Techniques

### Progressive Refinement

Start broad, then get specific:

```
1. "Analyze the architecture of this React app"
2. "Focus on the state management approach"
3. "Suggest improvements to the Redux store structure"
4. "Implement the user slice refactoring you suggested"
```

### Constraint-Based Prompting

```
Refactor @src/utils/api.js with these constraints:
- Must maintain backward compatibility
- Cannot change the public API
- Should improve error handling
- Must work with existing tests
- Performance improvement is priority
```

### Template-Based Prompting

```
Create a new React component following this template:
- Use @src/components/Button.jsx as the style reference
- Follow the prop pattern from @src/components/Input.jsx
- Include TypeScript interfaces like @src/types/Component.ts
- Add tests similar to @src/components/__tests__/Button.test.jsx
```

## Context Management

### Building Context Incrementally

```
Session Start:
"This is a Node.js Express API with MongoDB using TypeScript"

Add Context:
"The authentication uses JWT stored in httpOnly cookies"

Add More Context:
"We follow the repository pattern with services in @src/services/"

Now Make Request:
"Add password reset functionality following our existing patterns"
```

### Context Priming

```
Context Primer:
"Working on an e-commerce platform:
- Frontend: React + TypeScript + Material-UI
- Backend: Express + MongoDB + Redis
- Auth: JWT with refresh tokens
- Payment: Stripe integration
- Testing: Jest + React Testing Library

Now help me implement wishlist functionality."
```

## Error Handling in Prompts

### Provide Error Context

```
Fix this production error:
Error: "Database connection timeout"
Frequency: 5-10 times per hour
Affects: User registration and profile updates
Started: After scaling to 3 server instances
Current load: ~1000 concurrent users

Include both immediate fix and long-term solution.
```

### Ask for Explanation

```
This code works in development but fails in production:
[paste code]

Environment differences:
- Dev: SQLite, single instance
- Prod: PostgreSQL, 3 instances, load balancer

Explain why this happens and fix it.
```

## Collaborative Prompting

### Asking for Options

```
I need to implement real-time notifications. Present 3 approaches:
1. WebSockets with Socket.io
2. Server-Sent Events
3. Polling with React Query

For each approach, include:
- Implementation complexity
- Performance characteristics  
- Maintenance requirements
- Best fit scenarios
```

### Iterative Development

```
Let's build a comment system step by step:
1. First, design the data model
2. Then create the API endpoints
3. Next, build the React components
4. Finally, add real-time updates

Start with step 1.
```

## Quality Assurance Prompts

### Test Generation

```
Generate comprehensive tests for @src/utils/validation.js:
- Unit tests for each validation function
- Edge cases and boundary conditions
- Invalid input handling
- Performance tests for large datasets
- Integration tests with form components

Use Jest and include setup/teardown as needed.
```

### Code Quality

```
Perform a code quality audit on @src/services/:
- Identify code smells and anti-patterns
- Check adherence to SOLID principles
- Evaluate error handling consistency
- Assess documentation completeness
- Suggest refactoring opportunities

Prioritize issues by impact and effort.
```

## Documentation Prompts

### API Documentation

```
Generate OpenAPI/Swagger documentation for @src/routes/users.js:
- Include all endpoints with parameters
- Document request/response schemas
- Add example requests and responses
- Include error codes and messages
- Follow our existing docs pattern in @docs/api/
```

### Code Documentation

```
Add comprehensive JSDoc comments to @src/utils/encryption.js:
- Function descriptions with use cases
- Parameter types and constraints
- Return value specifications
- Usage examples
- Security considerations
- Performance notes
```

## Performance Optimization Prompts

### Analysis Prompts

```
Analyze performance bottlenecks in @src/components/DataGrid.jsx:
- Identify expensive operations
- Check for unnecessary re-renders
- Evaluate memory usage patterns
- Find optimization opportunities
- Suggest React performance best practices

Include before/after performance comparisons.
```

### Optimization Prompts

```
Optimize @src/api/search.js for better performance:
- Implement caching strategy
- Add request debouncing
- Optimize database queries
- Consider pagination improvements
- Add performance monitoring

Target: Reduce response time from 2s to <500ms.
```

## Common Prompt Mistakes

### Avoid These Patterns

❌ **Too Vague**: "Make this code better"
❌ **No Context**: "Add authentication"
❌ **Multiple Unrelated Tasks**: "Fix the bug, add tests, update docs, and deploy"
❌ **Unclear Success Criteria**: "Improve performance"
❌ **No File References**: "Look at the main component"

### Instead Use These Patterns

✅ **Specific Goals**: "Reduce memory usage of the user list component"
✅ **Rich Context**: "Following our existing auth pattern in @src/auth/"
✅ **Single Focus**: "Fix the null pointer exception, then we'll add tests"
✅ **Clear Metrics**: "Improve load time from 3s to under 1s"
✅ **Explicit References**: "Update @src/components/UserList.jsx"

## Prompt Templates

### Bug Fix Template

```
Bug Report:
- File: @path/to/file.js
- Function: functionName()
- Error: [specific error message]
- Reproduction: [steps to reproduce]
- Expected: [expected behavior]
- Environment: [dev/staging/prod]

Please analyze and fix with explanation.
```

### Feature Request Template

```
Feature: [feature name]
Location: @path/to/implementation
Requirements:
- [requirement 1]
- [requirement 2]
Dependencies: @existing/file.js patterns
Constraints: [any limitations]

Implement with tests and documentation.
```

### Code Review Template

```
Review @path/to/file.js focusing on:
1. [specific area 1]
2. [specific area 2]
3. [specific area 3]

Provide:
- Issue severity (high/medium/low)
- Specific line references
- Improvement suggestions
- Code examples
```

## Measuring Prompt Effectiveness

### Good Prompts Result In

- ✅ Accurate solutions on first try
- ✅ Code that follows project conventions
- ✅ Appropriate level of detail
- ✅ Consideration of edge cases
- ✅ Clear explanations when needed

### Poor Prompts Result In

- ❌ Multiple back-and-forth clarifications
- ❌ Generic solutions that don't fit
- ❌ Missing important context
- ❌ Incomplete implementations
- ❌ Confusion about requirements

## Continuous Improvement

### Track What Works

Keep notes on:
- Prompts that produce great results
- Patterns that save time
- Context that improves accuracy
- Specific phrasings that work well

### Refine Over Time

- Build a personal prompt library
- Adapt patterns to your codebase
- Share effective prompts with team
- Learn from unsuccessful attempts

## Next Steps

- [Context Management](./context-management.md) - Advanced context techniques
- [Team Collaboration](./team-collaboration.md) - Sharing prompts and patterns
- [Custom Commands](../04-custom-commands/) - Turn good prompts into reusable commands