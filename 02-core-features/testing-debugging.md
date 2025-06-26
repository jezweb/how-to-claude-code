# Testing & Debugging with Claude Code

Claude Code excels at helping you write tests, debug issues, and maintain code quality. This comprehensive guide covers all testing and debugging scenarios.

## Test Generation

### Unit Tests

```
Write unit tests for @src/utils/validation.js
```

```
Create tests for the login function in @src/auth/login.js with these scenarios:
- Valid credentials
- Invalid email
- Invalid password
- Network error
- Server error
```

```
Generate comprehensive tests for @src/components/UserCard.jsx including:
- Props validation
- Rendering tests
- User interaction tests
- Edge cases
```

### Integration Tests

```
Write integration tests for the user registration flow:
1. User fills form
2. Data is validated
3. API call is made
4. Success/error is handled
5. User is redirected
```

```
Create API integration tests for @src/api/products.js that test:
- CRUD operations
- Authentication
- Error handling
- Data validation
```

### End-to-End Tests

```
Write E2E tests for the shopping cart using Playwright:
1. Add products to cart
2. Update quantities
3. Apply discount codes
4. Complete checkout
5. Verify order confirmation
```

```
Create E2E tests for user authentication flow:
- Login with valid credentials
- Login with invalid credentials
- Password reset
- Account creation
```

## Test Framework Integration

### Jest Setup

```
Set up Jest testing for this React project with:
- Component testing utilities
- Mock configurations
- Coverage reporting
- Custom matchers
```

### React Testing Library

```
Write tests for @src/components/LoginForm.jsx using React Testing Library:
- Test user interactions
- Verify form validation
- Mock API calls
- Test loading states
```

### Cypress/Playwright

```
Create Playwright tests for the admin dashboard:
- Login as admin
- Navigate through sections
- Perform CRUD operations
- Verify data persistence
```

## Debugging Assistance

### Error Analysis

```
Help me debug this error:
TypeError: Cannot read property 'name' of undefined
  at UserProfile.jsx:23:15
  at updateUser (UserProfile.jsx:45:8)

The error happens when users click the update button.
```

```
This function is returning undefined instead of the expected user object:
[paste function code]
```

```
Debug this React component that's not re-rendering when props change:
[paste component code]
```

### Performance Debugging

```
This function is running slowly. Help me identify the bottleneck:
[paste function code]
```

```
My React app is re-rendering too often. Analyze @src/components/Dashboard.jsx
```

```
Debug memory leaks in @src/services/websocket.js
```

### Async Debugging

```
This promise chain isn't working as expected:
[paste promise code]
```

```
Help me debug race conditions in @src/utils/dataLoader.js
```

```
Fix this async/await function that's not handling errors properly:
[paste async function]
```

## Test Data Management

### Test Fixtures

```
Create test fixtures for user data that include:
- Valid users
- Edge case users
- Invalid data
- Realistic fake data
```

```
Generate test data for e-commerce scenarios:
- Products with various attributes
- Orders in different states
- Shopping cart scenarios
- Payment data (mock)
```

### Data Factories

```
Create a user factory for tests that can generate:
- Random valid users
- Users with specific roles
- Users with edge case data
- Related data (posts, comments)
```

```
Build test factories for @src/models/ that work with our database:
- User factory
- Product factory
- Order factory
- Relationship handling
```

## Mocking and Stubbing

### API Mocking

```
Create mock responses for @src/api/users.js that cover:
- Successful responses
- Error responses
- Network failures
- Slow responses
```

```
Mock the authentication service for testing:
- Successful login
- Failed login
- Token expiration
- Session management
```

### Component Mocking

```
Mock child components in @src/components/Dashboard.jsx tests:
- UserList component
- Analytics component
- Navigation component
```

```
Create mocks for external dependencies:
- Date libraries
- Chart libraries
- File upload services
```

## Test-Driven Development

### Red-Green-Refactor

```
Help me practice TDD for a new feature:
1. Write failing tests for user profile editing
2. Implement minimal code to pass
3. Refactor for better design
```

```
TDD approach for adding search functionality:
1. Define test cases
2. Write failing tests
3. Implement search
4. Refactor and optimize
```

### Behavior-Driven Development

```
Write BDD scenarios for user authentication:
Given a user with valid credentials
When they attempt to login
Then they should be redirected to dashboard
```

```
Create BDD tests for shopping cart:
Given a user has items in cart
When they apply a discount code
Then the total should update correctly
```

## Test Coverage Analysis

### Coverage Reports

```
Analyze test coverage for @src/components/ and identify:
- Untested functions
- Low coverage areas
- Critical paths without tests
- Suggestions for improvement
```

```
Review coverage report and prioritize areas that need tests:
- High-risk code
- Business-critical functions
- Recently changed code
```

### Coverage Improvement

```
Improve test coverage for @src/utils/validation.js from 60% to 90%:
- Identify uncovered lines
- Write targeted tests
- Test edge cases
```

```
Add tests for error handling paths in @src/api/auth.js
```

## Debugging Strategies

### Systematic Debugging

```
Help me debug this issue systematically:
1. User reports login fails randomly
2. No consistent error message
3. Happens on different browsers
4. Started after recent deployment
```

Steps Claude suggests:
1. Check recent changes
2. Review error logs
3. Test different scenarios
4. Isolate the issue
5. Fix and verify

### Logging and Monitoring

```
Add comprehensive logging to @src/services/payment.js for debugging:
- Input validation
- API calls
- Error conditions
- Performance metrics
```

```
Create debugging utilities for @src/utils/debug.js:
- Smart console logging
- Performance timers
- Error tracking
- Development mode guards
```

## Browser Debugging

### DevTools Integration

```
Add breakpoints and debugging aids to @src/components/SearchForm.jsx
```

```
Create debugging helpers for React DevTools:
- Component display names
- Debug props
- Performance profiling
```

### Network Debugging

```
Debug API communication issues:
- Request/response logging
- Error handling
- Timeout configuration
- Retry logic
```

```
Add network debugging to @src/api/client.js:
- Request interceptors
- Response validation
- Error reporting
```

## Testing Best Practices

### Test Organization

```
Organize tests for @src/components/ following best practices:
- Clear file structure
- Descriptive test names
- Logical grouping
- Setup/teardown patterns
```

### Test Quality

```
Review @src/__tests__/auth.test.js and improve:
- Test clarity
- Edge case coverage
- Mock usage
- Assertion quality
```

```
Refactor these tests to be more maintainable:
[paste test code]
```

## Automated Testing

### CI/CD Integration

```
Set up automated testing for this project:
- Unit tests on every commit
- Integration tests on PR
- E2E tests before deployment
- Coverage reporting
```

```
Create GitHub Actions workflow for testing:
- Run tests in parallel
- Cache dependencies
- Report results
- Block merges on failures
```

### Test Automation

```
Automate visual regression testing for @src/components/
```

```
Set up automated accessibility testing
```

```
Create automated performance testing for critical user flows
```

## Debugging Tools

### Custom Debug Utilities

```
Create a debug utility for @src/utils/debug.js that provides:
- Conditional logging
- Performance timing
- Memory usage tracking
- Error boundary integration
```

### Development Tools

```
Set up development debugging tools:
- Hot reloading
- Error overlays
- State inspection
- Time-travel debugging
```

## Test Maintenance

### Test Refactoring

```
Refactor brittle tests in @src/__tests__/ that break often:
- Remove implementation details
- Focus on behavior
- Improve reliability
- Reduce maintenance burden
```

### Test Documentation

```
Document testing strategy for new team members:
- What to test
- How to write tests
- Testing tools
- Best practices
```

## Troubleshooting Tests

### Flaky Tests

```
Fix these flaky tests that pass/fail randomly:
[paste test code]
```

Solutions Claude provides:
- Remove timing dependencies
- Mock external services
- Stabilize test data
- Fix race conditions

### Slow Tests

```
Optimize slow test suite that takes 5 minutes to run:
- Identify bottlenecks
- Parallel execution
- Mock heavy operations
- Test data optimization
```

## Debugging Production Issues

### Error Tracking

```
Set up error tracking for production debugging:
- Error monitoring service
- Source map support
- User context capture
- Error grouping
```

### Performance Monitoring

```
Add performance monitoring to identify issues:
- Page load times
- API response times
- User interaction metrics
- Resource usage
```

## Testing Patterns

### Page Object Model

```
Create page objects for E2E tests:
- Login page
- Dashboard page
- User profile page
- Shopping cart page
```

### Test Builders

```
Create test builders for complex scenarios:
- User with specific permissions
- Product with variants
- Order with multiple items
```

## Next Steps

- [Code Navigation](./code-navigation.md) - Finding and understanding code
- [Web Searching](./web-searching.md) - Research and documentation
- [Best Practices](../09-best-practices/) - Testing and debugging best practices