#!/bin/bash
# Quick install script for Context7 MCP server

set -euo pipefail

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${GREEN}Installing Context7 MCP Server...${NC}"
echo -e "${CYAN}Real-time documentation retrieval for any programming library${NC}\n"

# Check Node.js
if ! command -v node >/dev/null 2>&1; then
    echo -e "${RED}Error: Node.js is required but not installed${NC}"
    echo "Please install Node.js first: https://nodejs.org"
    exit 1
fi

echo -e "${GREEN}✓ Node.js detected ($(node --version))${NC}\n"

# Test Context7 package
echo -e "${BLUE}Testing Context7 MCP server...${NC}"
if npx -y @upstash/context7-mcp --version 2>/dev/null || npx -y @upstash/context7-mcp help 2>/dev/null; then
    echo -e "${GREEN}✓ Package verified${NC}"
else
    echo -e "${YELLOW}Package test returned non-zero (this is normal for some MCP servers)${NC}"
fi

# Install using Python script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MCP_MANAGER="$SCRIPT_DIR/../mcp-manager.py"

if [ -f "$MCP_MANAGER" ]; then
    echo -e "\n${GREEN}Adding to Claude configuration...${NC}"
    # Use Python MCP manager with proper arguments array syntax
    python3 "$MCP_MANAGER" add context7 --package "@upstash/context7-mcp" --force --command npx --args "-y" "@upstash/context7-mcp"
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
config['mcpServers']['context7'] = {
    'command': 'npx',
    'args': ['-y', '@upstash/context7-mcp'],
    'env': {}
}
with open('$CONFIG_FILE', 'w') as f:
    json.dump(config, f, indent=2)
print("✓ Added Context7 MCP server to configuration")
EOF
    else
        echo -e "${RED}Error: Claude configuration not found${NC}"
        echo "Creating new configuration..."
        mkdir -p "$(dirname "$CONFIG_FILE")"
        echo '{"mcpServers": {}}' > "$CONFIG_FILE"
        
        # Try again
        python3 << EOF
import json
with open('$CONFIG_FILE', 'r') as f:
    config = json.load(f)
config['mcpServers']['context7'] = {
    'command': 'npx',
    'args': ['-y', '@upstash/context7-mcp'],
    'env': {}
}
with open('$CONFIG_FILE', 'w') as f:
    json.dump(config, f, indent=2)
print("✓ Added Context7 MCP server to new configuration")
EOF
    fi
fi

echo -e "\n${GREEN}✓ Context7 MCP server installed successfully!${NC}"

echo -e "\n${CYAN}What is Context7?${NC}"
echo "Context7 fetches up-to-date documentation and code examples directly"
echo "from official sources, eliminating outdated or hallucinated code."

echo -e "\n${GREEN}Key Features:${NC}"
echo "  • Real-time documentation retrieval"
echo "  • Version-specific code examples"
echo "  • Support for all major programming libraries"
echo "  • No API key required - completely free!"
echo "  • Prevents outdated code suggestions"

echo -e "\n${GREEN}How to Use:${NC}"
echo "Simply add \"use context7\" to any prompt where you want current documentation:"

echo -e "\n${BLUE}Example Prompts:${NC}"
echo '  "Create a Next.js 14 app with app router. use context7"'
echo '  "Show me how to use React Query v5. use context7"'
echo '  "Write a FastAPI endpoint with Pydantic v2. use context7"'
echo '  "Implement JWT auth in Express.js. use context7"'
echo '  "Create a Tailwind CSS responsive grid. use context7"'

echo -e "\n${GREEN}Supported Libraries:${NC}"
echo "Context7 works with any library that has online documentation, including:"
echo "  • React, Vue, Angular, Svelte"
echo "  • Node.js, Express, FastAPI, Django"
echo "  • TailwindCSS, Material-UI, Bootstrap"
echo "  • PostgreSQL, MongoDB, Redis"
echo "  • And thousands more!"

echo -e "\n${YELLOW}Important Notes:${NC}"
echo "1. No configuration needed - it just works!"
echo "2. Always use \"use context7\" in your prompt to activate"
echo "3. Works best with specific library/framework names"
echo "4. Restart Claude for changes to take effect"

echo -e "\n${GREEN}Quick Test:${NC}"
echo "After restarting Claude, try this prompt:"
echo '  "Show me the latest React hooks syntax. use context7"'

echo -e "\n${GREEN}Setup complete! Restart Claude to start using Context7.${NC}"