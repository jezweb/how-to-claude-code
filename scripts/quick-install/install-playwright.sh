#!/bin/bash
# Quick install script for Playwright MCP server

set -euo pipefail

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${GREEN}Installing Playwright MCP Server...${NC}"
echo -e "${CYAN}This enables browser automation and web testing${NC}\n"

# Check Node.js
if ! command -v node >/dev/null 2>&1; then
    echo -e "${RED}Error: Node.js is required but not installed${NC}"
    echo "Please install Node.js first: https://nodejs.org"
    exit 1
fi

# Configuration options
echo -e "${BLUE}Configuration Options:${NC}"
echo "1. Browser choice (chromium, firefox, webkit)"
echo "2. Headless mode (true/false)"
echo "3. Default viewport size"
echo

# Get user preferences
read -p "Select browser (chromium/firefox/webkit) [default: chromium]: " browser
browser="${browser:-chromium}"

read -p "Run in headless mode? (true/false) [default: true]: " headless
headless="${headless:-true}"

read -p "Viewport width [default: 1280]: " width
width="${width:-1280}"

read -p "Viewport height [default: 720]: " height
height="${height:-720}"

read -p "Default timeout in ms [default: 30000]: " timeout
timeout="${timeout:-30000}"

# Test Playwright package
echo -e "\n${GREEN}Testing Playwright MCP server...${NC}"
if npx @playwright/mcp --version 2>/dev/null || npx @playwright/mcp help 2>/dev/null; then
    echo -e "${GREEN}✓ Package verified${NC}"
else
    echo -e "${YELLOW}Installing Playwright browsers...${NC}"
    echo "This may take a few minutes on first install."
fi

# Install browsers if needed
echo -e "\n${BLUE}Installing Playwright browsers...${NC}"
echo "This ensures all browser engines are available."

# Check if playwright is installed globally or locally
if command -v playwright >/dev/null 2>&1; then
    playwright install
elif npx playwright --version >/dev/null 2>&1; then
    npx playwright install
else
    echo -e "${YELLOW}Installing Playwright CLI...${NC}"
    npm install -g playwright
    playwright install
fi

# Install using Python script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MCP_MANAGER="$SCRIPT_DIR/../mcp-manager.py"

if [ -f "$MCP_MANAGER" ]; then
    echo -e "\n${GREEN}Adding to Claude configuration...${NC}"
    python3 "$MCP_MANAGER" add playwright --force \
        --env BROWSER="$browser" \
        --env HEADLESS="$headless" \
        --env VIEWPORT_WIDTH="$width" \
        --env VIEWPORT_HEIGHT="$height" \
        --env TIMEOUT="$timeout"
else
    echo -e "${YELLOW}MCP manager not found, using manual installation...${NC}"
    
    # Manual installation
    CONFIG_FILE="$HOME/.claude.json"
    if [ -f "$CONFIG_FILE" ]; then
        # Backup
        cp "$CONFIG_FILE" "$CONFIG_FILE.backup.$(date +%Y%m%d_%H%M%S)"
        
        # Add server using Python
        python3 << EOF
import json
with open('$CONFIG_FILE', 'r') as f:
    config = json.load(f)
if 'mcpServers' not in config:
    config['mcpServers'] = {}
config['mcpServers']['playwright'] = {
    'command': 'npx',
    'args': ['@playwright/mcp'],
    'env': {
        'BROWSER': '$browser',
        'HEADLESS': '$headless',
        'VIEWPORT_WIDTH': '$width',
        'VIEWPORT_HEIGHT': '$height',
        'TIMEOUT': '$timeout'
    }
}
with open('$CONFIG_FILE', 'w') as f:
    json.dump(config, f, indent=2)
print("✓ Added Playwright MCP server to configuration")
EOF
    else
        echo -e "${RED}Error: Claude configuration not found${NC}"
        exit 1
    fi
fi

echo -e "\n${GREEN}✓ Playwright MCP server installed successfully!${NC}"
echo -e "\n${GREEN}Configuration Summary:${NC}"
echo "  Browser: $browser"
echo "  Headless: $headless"
echo "  Viewport: ${width}x${height}"
echo "  Timeout: ${timeout}ms"

echo -e "\n${GREEN}Available Capabilities:${NC}"
echo "  • Web page navigation and interaction"
echo "  • Form filling and submission"
echo "  • Screenshot capture"
echo "  • PDF generation"
echo "  • Web scraping"
echo "  • Automated testing"
echo "  • Multi-browser support"

echo -e "\n${GREEN}Example Commands:${NC}"
echo '  "Navigate to https://example.com"'
echo '  "Click the login button"'
echo '  "Fill the email field with test@example.com"'
echo '  "Take a screenshot of the page"'
echo '  "Extract all links from the page"'

echo -e "\n${YELLOW}Important Notes:${NC}"
echo "1. First run may be slow as browsers download"
echo "2. Headless mode is faster but won't show browser window"
echo "3. Some sites may block automated browsers"
echo "4. Restart Claude for changes to take effect"

# Optional: Test browser launch
echo -e "\n${BLUE}Would you like to test browser launch? (y/n)${NC}"
read -p "Test browser: " test_browser

if [[ "$test_browser" =~ ^[Yy]$ ]]; then
    echo -e "${GREEN}Testing browser launch...${NC}"
    
    # Create a simple test script
    cat > /tmp/playwright-test.js << 'EOF'
const { chromium, firefox, webkit } = require('playwright');

(async () => {
    const browserType = process.env.BROWSER || 'chromium';
    const headless = process.env.HEADLESS === 'true';
    
    console.log(`Launching ${browserType} (headless: ${headless})...`);
    
    let browser;
    switch (browserType) {
        case 'firefox':
            browser = await firefox.launch({ headless });
            break;
        case 'webkit':
            browser = await webkit.launch({ headless });
            break;
        default:
            browser = await chromium.launch({ headless });
    }
    
    const page = await browser.newPage();
    await page.goto('https://example.com');
    console.log('✓ Successfully loaded example.com');
    console.log('Page title:', await page.title());
    
    await browser.close();
    console.log('✓ Browser closed successfully');
})().catch(err => {
    console.error('Error:', err.message);
    process.exit(1);
});
EOF
    
    BROWSER="$browser" HEADLESS="$headless" node /tmp/playwright-test.js
    rm -f /tmp/playwright-test.js
fi

echo -e "\n${GREEN}Setup complete! Restart Claude to use Playwright.${NC}"