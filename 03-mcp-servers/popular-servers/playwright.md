# Playwright MCP Server

The Playwright MCP server enables Claude Code to control web browsers for testing, automation, and web scraping tasks.

## Installation

```bash
npm install -g @playwright/mcp
npx playwright install
```

## Configuration

Add to your `~/.claude/claude.json`:

```json
{
  "mcpServers": {
    "playwright": {
      "command": "npx",
      "args": ["@playwright/mcp"],
      "env": {
        "BROWSER": "chromium",
        "HEADLESS": "false"
      }
    }
  }
}
```

### Advanced Configuration

```json
{
  "mcpServers": {
    "playwright": {
      "command": "npx",
      "args": ["@playwright/mcp"],
      "env": {
        "BROWSER": "chromium",
        "HEADLESS": "true",
        "VIEWPORT_WIDTH": "1280",
        "VIEWPORT_HEIGHT": "720",
        "USER_AGENT": "Mozilla/5.0 (compatible; ClaudeCode/1.0)",
        "TIMEOUT": "30000"
      }
    }
  }
}
```

## Browser Navigation

### Basic Navigation

```
Navigate to https://example.com
```

```
Go to my local development server at http://localhost:3000
```

```
Visit the GitHub repository page for 'user/repo'
```

### Navigation Commands

```
Go back to the previous page
```

```
Refresh the current page
```

```
Navigate forward in browser history
```

```
Close the current tab
```

## Page Interaction

### Clicking Elements

```
Click the "Login" button on the page
```

```
Click the element with text "Sign Up"
```

```
Click the submit button in the contact form
```

### Form Filling

```
Fill out the login form:
- Email: "user@example.com" 
- Password: "password123"
- Click submit
```

```
Complete the registration form with:
- First name: "John"
- Last name: "Doe"
- Email: "john@example.com"
- Phone: "555-0123"
```

### Text Input

```
Type "Claude Code automation" in the search box
```

```
Clear the current text and type "new content" in the textarea
```

```
Select all text in the input field and replace with "updated value"
```

## Screenshots and Visual Testing

### Taking Screenshots

```
Take a screenshot of the current page
```

```
Take a screenshot of just the navigation header
```

```
Capture the full page including content below the fold
```

### Visual Comparisons

```
Take a before/after screenshot comparison:
1. Screenshot current state
2. Click "Dark Mode" toggle
3. Screenshot after change
```

```
Compare the mobile and desktop versions of this page
```

## Element Inspection

### Finding Elements

```
Find all links on the page and list their text and URLs
```

```
Show me all form inputs and their current values
```

```
List all images on the page with their alt text
```

### Element Properties

```
Get the text content of the main heading
```

```
Check if the "Submit" button is enabled or disabled
```

```
Show the CSS classes applied to the navigation menu
```

## Form Testing

### Form Validation

```
Test form validation by:
1. Submit empty form
2. Check error messages
3. Fill valid data
4. Verify successful submission
```

```
Test email validation:
- Enter invalid email formats
- Verify error messages appear
- Enter valid email
- Check validation passes
```

### Multi-step Forms

```
Complete the multi-step checkout process:
1. Add item to cart
2. Proceed to checkout
3. Fill shipping information
4. Select payment method
5. Review and confirm order
```

## Web Scraping

### Data Extraction

```
Extract all product information from this e-commerce page:
- Product names
- Prices
- Availability
- Ratings
```

```
Scrape the job listings from this careers page:
- Job titles
- Locations  
- Departments
- Application links
```

### Table Data

```
Extract data from the pricing table on this page
```

```
Get all the rows from the user list table and format as JSON
```

```
Scrape the financial data from the quarterly results table
```

## Testing Workflows

### User Registration Flow

```
Test the complete user registration process:
1. Navigate to sign-up page
2. Fill registration form
3. Handle email verification
4. Complete profile setup
5. Verify dashboard access
```

### E-commerce Testing

```
Test the shopping cart functionality:
1. Browse products
2. Add items to cart
3. Update quantities
4. Apply discount code
5. Proceed to checkout
6. Complete purchase
```

### Authentication Testing

```
Test login/logout flow:
1. Login with valid credentials
2. Verify dashboard access
3. Navigate to profile
4. Logout
5. Verify redirect to login
```

## Performance Testing

### Page Load Metrics

```
Measure page load performance:
- Time to first byte
- First contentful paint
- Largest contentful paint
- Cumulative layout shift
```

```
Test page performance on mobile device simulation
```

### Network Monitoring

```
Monitor network requests while loading the page:
- API calls
- Resource loading times
- Failed requests
- Response sizes
```

## Accessibility Testing

### A11y Checks

```
Run accessibility audit on this page:
- Check for alt text on images
- Verify heading structure
- Test keyboard navigation
- Check color contrast
```

```
Test screen reader compatibility:
- Navigate using tab key
- Check ARIA labels
- Verify form accessibility
```

## Mobile Testing

### Responsive Design

```
Test responsive design at different screen sizes:
- Mobile (375px)
- Tablet (768px)  
- Desktop (1200px)
```

```
Test mobile-specific features:
- Touch interactions
- Swipe gestures
- Mobile navigation menu
```

### Device Simulation

```
Simulate iPhone 12 and test the mobile experience
```

```
Test on Android tablet and check layout differences
```

## Cross-browser Testing

### Multiple Browsers

```json
{
  "mcpServers": {
    "playwright-chrome": {
      "command": "npx",
      "args": ["@playwright/mcp"],
      "env": { "BROWSER": "chromium" }
    },
    "playwright-firefox": {
      "command": "npx", 
      "args": ["@playwright/mcp"],
      "env": { "BROWSER": "firefox" }
    },
    "playwright-safari": {
      "command": "npx",
      "args": ["@playwright/mcp"], 
      "env": { "BROWSER": "webkit" }
    }
  }
}
```

### Browser Compatibility

```
Test this feature across all browsers:
1. Chrome/Chromium
2. Firefox
3. Safari/WebKit
```

## API Testing Integration

### API + UI Testing

```
Test API and UI integration:
1. Make API call to create user
2. Login to UI with created user
3. Verify data appears correctly
4. Test CRUD operations via UI
```

### Mock API Responses

```
Test UI with mocked API responses:
1. Mock successful API calls
2. Test loading states
3. Mock error responses
4. Test error handling
```

## Advanced Automation

### Dynamic Content

```
Handle dynamically loaded content:
1. Wait for API responses
2. Wait for elements to appear
3. Handle infinite scroll
4. Deal with lazy loading
```

### File Operations

```
Test file upload functionality:
1. Select file from system
2. Upload to server
3. Verify upload success
4. Check file processing
```

### Authentication Flows

```
Test OAuth authentication:
1. Click "Login with Google"
2. Handle popup window
3. Complete OAuth flow
4. Verify successful login
```

## Error Handling

### Timeout Management

```
Handle slow-loading pages:
- Increase timeout for specific operations
- Wait for network idle
- Retry failed operations
```

### Element Waiting

```
Wait for elements intelligently:
- Wait for element to be visible
- Wait for element to be clickable
- Wait for text to change
```

## Debugging and Troubleshooting

### Debug Mode

```json
{
  "mcpServers": {
    "playwright-debug": {
      "command": "npx",
      "args": ["@playwright/mcp"],
      "env": {
        "HEADLESS": "false",
        "SLOW_MO": "1000",
        "DEBUG": "true"
      }
    }
  }
}
```

### Common Issues

**Element not found:**
```
Error: Element not found

Solutions:
1. Wait for element to load
2. Check element selector
3. Verify page has loaded completely
4. Use more specific selectors
```

**Timeout errors:**
```
Error: Timeout exceeded

Solutions:
1. Increase timeout values
2. Wait for network idle
3. Check for JavaScript errors
4. Optimize selectors
```

## Best Practices

### Reliable Selectors

1. **Use data attributes**: `[data-testid="submit-button"]`
2. **Avoid brittle selectors**: CSS classes that change
3. **Use semantic selectors**: Role-based selection
4. **Test selector stability**: Ensure selectors don't break

### Test Organization

```
Organize browser tests:
- Setup and teardown
- Page object models
- Reusable functions
- Clear test descriptions
```

### Performance Optimization

1. **Reuse browser contexts**
2. **Parallel test execution**
3. **Minimize page loads**
4. **Cache static resources**

## Integration Examples

### CI/CD Integration

```
Set up Playwright in CI/CD:
1. Install dependencies
2. Run tests in headless mode
3. Generate test reports
4. Upload screenshots on failure
```

### Visual Regression Testing

```
Implement visual regression testing:
1. Take baseline screenshots
2. Compare with current screenshots
3. Flag visual differences
4. Review and approve changes
```

## Resources

- [Playwright Documentation](https://playwright.dev/)
- [Playwright Testing Best Practices](https://playwright.dev/docs/best-practices)
- [Browser Automation Patterns](https://playwright.dev/docs/browser-contexts)
- [Debugging Playwright Tests](https://playwright.dev/docs/debug)