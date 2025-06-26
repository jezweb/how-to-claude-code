# Understanding Context in Claude Code

Claude Code's power comes from understanding your project's context. This guide explains how Claude reads and interprets your codebase to provide better assistance.

## How Claude Builds Context

### Initial Discovery

When you start a session, Claude can:

1. **Read the current directory**
   ```
   > Tell me about this project
   ```
   Claude examines files like `package.json`, `README.md`, `.gitignore` to understand the project.

2. **Explore the structure**
   ```
   > What's the architecture of this codebase?
   ```
   Claude maps out directories and identifies patterns.

3. **Identify the tech stack**
   Claude looks for configuration files, dependencies, and code patterns to determine:
   - Framework (React, Vue, Express, etc.)
   - Language (JavaScript, TypeScript, Python, etc.)
   - Tools (Webpack, Vite, Jest, etc.)
   - Database (PostgreSQL, MongoDB, etc.)

### Context Building Strategies

#### File References with `@`

The most powerful way to give Claude context:

```
@src/components/UserProfile.jsx needs better error handling
```

```
Compare @models/User.js with @models/Product.js for consistency
```

```
Refactor @utils/api.js to use the same pattern as @utils/auth.js
```

#### Directory Context

```
@src/components/ has too many files. Help me organize them better.
```

```
All files in @tests/ should follow the same naming convention
```

#### Multiple File Context

```
Looking at @package.json, @webpack.config.js, and @src/index.js, 
help me set up hot module replacement
```

## Types of Context Claude Uses

### 1. Project Metadata

**From `package.json`:**
- Dependencies and versions
- Scripts available
- Project name and description
- Node.js version requirements

**From `README.md`:**
- Project purpose
- Setup instructions
- Usage examples
- Contributing guidelines

**From configuration files:**
- Build tools (webpack, vite, rollup)
- Linting rules (eslint, prettier)
- Testing setup (jest, vitest)
- Framework configuration

### 2. Code Structure

**File organization:**
```
src/
  components/     # React components
  hooks/         # Custom hooks
  utils/         # Utility functions
  services/      # API calls
  types/         # TypeScript types
```

**Naming patterns:**
- `*.test.js` - Test files
- `*.config.js` - Configuration
- `index.js` - Entry points
- `*.types.ts` - Type definitions

**Import patterns:**
```javascript
// Relative imports
import Button from './Button'
import { api } from '../services/api'

// Absolute imports
import { User } from '@/types/User'
import config from '@/config'
```

### 3. Code Conventions

Claude identifies and follows your patterns:

**Naming conventions:**
```javascript
// camelCase functions
const getUserData = () => {}

// PascalCase components
const UserProfile = () => {}

// UPPER_CASE constants
const API_ENDPOINT = 'https://api.example.com'
```

**Code style:**
```javascript
// Your preferred patterns
const config = {
  apiUrl: process.env.API_URL,
  timeout: 5000,
};

// Claude will match this style
const newConfig = {
  dbUrl: process.env.DATABASE_URL,
  retries: 3,
};
```

### 4. Dependencies and APIs

Claude understands libraries you use:

**React patterns:**
```jsx
// If you use hooks
const [user, setUser] = useState(null);
const { data, loading, error } = useQuery();

// Claude knows to use similar patterns
```

**Express patterns:**
```javascript
// If you use middleware
app.use(cors());
app.use(express.json());

// Claude will follow the same style
```

## Providing Better Context

### 1. Describe Your Intent

Instead of:
```
Fix this function
```

Try:
```
This authentication function in @src/auth.js should validate JWT tokens 
and return user data, but it's throwing errors for expired tokens
```

### 2. Explain the Business Logic

```
The shopping cart in @src/cart.js needs to calculate shipping costs.
We charge $5 for orders under $50, free shipping over $50, 
and $10 for express shipping regardless of order value.
```

### 3. Reference Related Code

```
The new payment method should work like @src/payment/stripe.js 
but for PayPal integration. Keep the same error handling pattern.
```

### 4. Mention Constraints

```
Add user authentication to @src/api/users.js but don't break 
the existing API contract - we have mobile apps that depend on it.
```

## Context Persistence

### Within a Session

Claude remembers context throughout your session:

```
> Analyze @src/components/Button.jsx
Claude: [reads and understands the Button component]

> Now create a similar component for inputs
Claude: [creates input component following Button patterns]

> Make the input component use the same styling approach
Claude: [applies consistent styling without re-reading Button]
```

### Session Limitations

**Context doesn't persist between sessions:**
- Each new `claude` session starts fresh
- Previous conversations aren't remembered
- File changes are saved, but context is rebuilt

**Best practices:**
- Reference key files early in new sessions
- Rebuild context with overview questions
- Keep important context in your codebase

## Working with Large Codebases

### Start Broad, Get Specific

1. **Project overview:**
   ```
   Explain the architecture of this application
   ```

2. **Focus on area:**
   ```
   I want to work on the authentication system
   ```

3. **Specific files:**
   ```
   Let's improve @src/auth/login.js
   ```

### Use Documentation

Keep context in your code:

```javascript
/**
 * User authentication service
 * Handles login, logout, token refresh
 * Integrates with Auth0 for SSO
 */
class AuthService {
  // Claude can use this context
}
```

### Leverage Comments

```javascript
// TODO: This needs better error handling for network failures
// FIXME: Memory leak when user logs out multiple times
// NOTE: This function is called by both web and mobile clients
```

## Advanced Context Techniques

### 1. Context Priming

Start sessions with context:

```
This is a Next.js e-commerce application using:
- TypeScript
- Tailwind CSS
- Prisma with PostgreSQL
- NextAuth for authentication
- Stripe for payments

I want to add a wishlist feature.
```

### 2. Reference Architecture

```
Look at how we implemented the shopping cart in @src/cart/ 
and use the same patterns for the wishlist feature
```

### 3. Progressive Context

Build context incrementally:

```
> First, understand our user model: @models/User.js
> Now look at how we handle authentication: @middleware/auth.js
> Finally, see how we structure API routes: @pages/api/users/[id].js
> Now help me add a friend system to connect users
```

## Context Best Practices

### Do ✅

- Reference specific files with `@`
- Explain business requirements
- Mention related code patterns
- Describe constraints and requirements
- Use your project's terminology

### Don't ❌

- Assume Claude remembers previous sessions
- Reference files that don't exist
- Be vague about requirements
- Skip explaining business logic
- Use unclear or ambiguous terms

## Troubleshooting Context Issues

### Claude seems confused about your project

1. **Start with overview:**
   ```
   Read @package.json and @README.md and tell me what this project does
   ```

2. **Clarify tech stack:**
   ```
   This is a React application using TypeScript and Express backend
   ```

3. **Show key files:**
   ```
   The main entry point is @src/App.tsx and the API starts at @server/index.js
   ```

### Claude suggests wrong patterns

1. **Show existing patterns:**
   ```
   Look at @src/components/Button.jsx to see our component structure
   ```

2. **Explain preferences:**
   ```
   We prefer functional components with hooks over class components
   ```

3. **Reference style guide:**
   ```
   Follow the patterns in @src/utils/api.js for all API calls
   ```

## Next Steps

Now that you understand context:
- [Core Features](../02-core-features/) - Explore Claude's capabilities
- [Best Practices](../09-best-practices/context-management.md) - Advanced context techniques
- [Examples](../10-examples/) - See context in action