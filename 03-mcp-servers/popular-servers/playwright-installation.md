# Playwright MCP Server Installation Guide

Complete guide for installing and configuring the Playwright MCP server for browser automation with Claude Code.

## Quick Install

```bash
# One-line installation
curl -sSL https://raw.githubusercontent.com/jezweb/how-to-claude-code/main/scripts/quick-install/install-playwright.sh | bash

# Or download and run
./scripts/quick-install/install-playwright.sh
```

## What is Playwright MCP?

The Playwright MCP server enables Claude to:
- Control web browsers (Chrome, Firefox, Safari)
- Automate web interactions
- Capture screenshots and PDFs
- Perform web scraping
- Run automated tests
- Fill forms and submit data

## Prerequisites

### Required Software

1. **Node.js** (v14 or higher)
   ```bash
   node --version  # Check if installed
   ```

2. **System Dependencies** (automatically installed)
   - Chrome/Chromium dependencies
   - Firefox dependencies  
   - WebKit dependencies (Safari engine)

### Disk Space

Playwright browsers require approximately:
- Chromium: ~280MB
- Firefox: ~190MB
- WebKit: ~220MB
- Total: ~700MB for all browsers

## Manual Installation

### Step 1: Install Playwright CLI

```bash
# Install globally
npm install -g playwright

# Or use npx (no global install)
npx playwright --version
```

### Step 2: Install Browsers

```bash
# Install all browsers
playwright install

# Or install specific browsers
playwright install chromium
playwright install firefox
playwright install webkit

# Install system dependencies
playwright install-deps
```

### Step 3: Configure Claude

Add to `~/.claude.json`:

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
        "TIMEOUT": "30000",
        "USER_AGENT": "Mozilla/5.0 (compatible; ClaudeCode/1.0)",
        "LOCALE": "en-US",
        "TIMEZONE": "America/New_York"
      }
    }
  }
}
```

## Configuration Options

### Browser Selection

```json
{
  "env": {
    "BROWSER": "chromium"  // Options: chromium, firefox, webkit
  }
}
```

### Display Mode

```json
{
  "env": {
    "HEADLESS": "true"  // true = no visible browser, false = show browser
  }
}
```

### Viewport Settings

```json
{
  "env": {
    "VIEWPORT_WIDTH": "1920",   // Desktop size
    "VIEWPORT_HEIGHT": "1080",
    // Mobile presets
    "DEVICE": "iPhone 12"  // Optional: use device emulation
  }
}
```

### Advanced Options

```json
{
  "env": {
    // Performance
    "TIMEOUT": "60000",           // Page load timeout (ms)
    "NAVIGATION_TIMEOUT": "30000", // Navigation timeout
    "SLOW_MO": "100",             // Slow down actions by ms
    
    // Privacy
    "USER_AGENT": "custom-agent",
    "LOCALE": "en-GB",
    "TIMEZONE": "Europe/London",
    "GEOLOCATION": "51.5074,-0.1278",  // latitude,longitude
    
    // Network
    "PROXY": "http://proxy.company.com:8080",
    "IGNORE_HTTPS_ERRORS": "true",
    
    // Media
    "COLOR_SCHEME": "dark",       // light, dark, no-preference
    "REDUCED_MOTION": "reduce",   // reduce, no-preference
    
    // Storage
    "DOWNLOADS_PATH": "/tmp/downloads",
    "SCREENSHOTS_PATH": "/tmp/screenshots"
  }
}
```

## Platform-Specific Installation

### Linux

```bash
# Ubuntu/Debian dependencies
sudo npx playwright install-deps

# For headless environments
sudo apt-get install xvfb
```

### macOS

```bash
# No additional dependencies needed
# Browsers install automatically
playwright install
```

### Windows

```powershell
# Run as Administrator if needed
npx playwright install

# For WSL2
sudo npx playwright install-deps
```

### Docker

```dockerfile
FROM mcr.microsoft.com/playwright:v1.40.0-focal

# Your Claude setup here
COPY .claude.json /root/.claude.json
```

## Testing the Installation

### Quick Test

```bash
# Test browser launch
npx playwright test -c /dev/null -g "example"

# Or use our test script
node -e "
const { chromium } = require('playwright');
(async () => {
  const browser = await chromium.launch();
  console.log('✓ Chromium launched successfully');
  await browser.close();
})();
"
```

### Full Test Script

Create `test-playwright.js`:

```javascript
const { chromium, firefox, webkit } = require('playwright');

async function testBrowser(browserType, browserLauncher) {
  console.log(`Testing ${browserType}...`);
  try {
    const browser = await browserLauncher.launch({ 
      headless: true,
      timeout: 30000 
    });
    const page = await browser.newPage();
    await page.goto('https://example.com');
    const title = await page.title();
    console.log(`✓ ${browserType}: Loaded page with title "${title}"`);
    await browser.close();
  } catch (error) {
    console.error(`✗ ${browserType}: ${error.message}`);
  }
}

(async () => {
  await testBrowser('Chromium', chromium);
  await testBrowser('Firefox', firefox);
  await testBrowser('WebKit', webkit);
})();
```

## Common Issues and Solutions

### Browser Download Failed

**Problem**: "Failed to download browser"

**Solutions**:
```bash
# Clear cache and retry
rm -rf ~/Library/Caches/ms-playwright
rm -rf ~/.cache/ms-playwright

# Use different registry
PLAYWRIGHT_DOWNLOAD_HOST=https://playwright.azureedge.net npm install playwright

# Manual download
PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=1 npm install playwright
```

### Missing System Dependencies

**Problem**: "Host system is missing dependencies"

**Linux Solution**:
```bash
# Install all dependencies
sudo npx playwright install-deps

# Or manually for Ubuntu
sudo apt-get update
sudo apt-get install -y \
    libnss3 libnspr4 libatk1.0-0 libatk-bridge2.0-0 \
    libcups2 libdrm2 libxkbcommon0 libxcomposite1 \
    libxdamage1 libxfixes3 libxrandr2 libgbm1 \
    libgtk-3-0 libxss1 libasound2
```

### Headless Mode Issues

**Problem**: "Browser not visible" or "Can't see what's happening"

**Solution**: Set headless to false:
```json
{
  "env": {
    "HEADLESS": "false",
    "SLOW_MO": "1000"  // Slow down for debugging
  }
}
```

### Permission Errors

**Problem**: "Permission denied" or "Cannot execute"

**Solutions**:
```bash
# Fix permissions
chmod +x ~/.cache/ms-playwright/*/chrome-linux/chrome

# Run with proper user
sudo usermod -a -G audio,video $USER
```

### Timeout Errors

**Problem**: "Timeout exceeded while waiting"

**Solution**: Increase timeouts:
```json
{
  "env": {
    "TIMEOUT": "120000",
    "NAVIGATION_TIMEOUT": "60000"
  }
}
```

## Usage Examples

### Basic Navigation

```
Navigate to https://github.com and take a screenshot
```

```
Go to https://example.com and extract all links
```

### Form Interaction

```
Fill the login form:
- Username: testuser
- Password: testpass
Then click the submit button
```

### Web Scraping

```
Extract all product prices from https://shop.example.com
```

```
Get all email addresses from the contact page
```

### Testing

```
Test if the login flow works:
1. Go to /login
2. Enter credentials
3. Verify redirect to dashboard
```

## Best Practices

### 1. Resource Management

Always close browsers:
```
After taking the screenshot, make sure to close the browser
```

### 2. Error Handling

Handle navigation failures:
```
Try to navigate to the page, but if it fails after 30 seconds, take a screenshot of the error
```

### 3. Efficient Selectors

Use specific selectors:
```
Click the button with text "Submit" inside the form with id "login-form"
```

### 4. Wait Strategies

Wait for content:
```
Wait for the element with class "results" to appear before extracting data
```

## Security Considerations

### 1. Credential Management

Never hardcode credentials:
```json
{
  "env": {
    "LOGIN_USER": "${PLAYWRIGHT_USER}",
    "LOGIN_PASS": "${PLAYWRIGHT_PASS}"
  }
}
```

### 2. Cookie and Storage

Clear data between sessions:
```
Use a fresh browser context for each task
```

### 3. Proxy Usage

For sensitive sites:
```json
{
  "env": {
    "PROXY": "${CORPORATE_PROXY}",
    "PROXY_BYPASS": "localhost,127.0.0.1"
  }
}
```

## Performance Optimization

### 1. Disable Images

For faster loading:
```json
{
  "env": {
    "BLOCK_IMAGES": "true",
    "BLOCK_FONTS": "true"
  }
}
```

### 2. Reuse Contexts

For multiple operations:
```
Keep the same browser context for all operations on example.com
```

### 3. Parallel Operations

For bulk tasks:
```
Open 3 browser tabs and scrape these URLs in parallel
```

## Troubleshooting Commands

### Check Installation

```bash
# Verify Playwright installation
npx playwright --version

# List installed browsers
npx playwright show-browsers

# Check browser executables
ls ~/.cache/ms-playwright/
```

### Debug Mode

```bash
# Enable debug logging
DEBUG=pw:api HEADLESS=false claude

# Verbose browser logs
DEBUG=pw:browser claude
```

### Reset Installation

```bash
# Clean everything
rm -rf ~/.cache/ms-playwright
rm -rf node_modules
npm cache clean --force

# Reinstall
npm install playwright
playwright install
```

## Advanced Topics

### Custom Browser Args

```json
{
  "env": {
    "EXTRA_ARGS": "--disable-web-security --disable-features=IsolateOrigins"
  }
}
```

### Browser Contexts

```json
{
  "env": {
    "CONTEXT_OPTIONS": "{\"acceptDownloads\": true, \"recordVideo\": {\"dir\": \"./videos\"}}"
  }
}
```

### Network Interception

```
Intercept all image requests and replace them with placeholders
```

## Resources

- [Playwright Documentation](https://playwright.dev)
- [Playwright API Reference](https://playwright.dev/docs/api/class-playwright)
- [Selector Engine](https://playwright.dev/docs/selectors)
- [Best Practices](https://playwright.dev/docs/best-practices)
- [Debugging Guide](https://playwright.dev/docs/debug)

## Next Steps

1. Install Playwright MCP server
2. Test with simple navigation
3. Try form interactions
4. Experiment with screenshots
5. Build automated workflows

Remember to restart Claude after installation for changes to take effect!