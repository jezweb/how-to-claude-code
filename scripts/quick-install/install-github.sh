#!/bin/bash
# Quick install script for GitHub MCP server

set -euo pipefail

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${GREEN}Installing GitHub MCP Server...${NC}"

# Check if GITHUB_TOKEN is set
if [ -z "${GITHUB_TOKEN:-}" ]; then
    echo -e "${YELLOW}Warning: GITHUB_TOKEN not set${NC}"
    echo -e "\n${BLUE}To create a GitHub token:${NC}"
    echo "1. Go to https://github.com/settings/tokens"
    echo "2. Click 'Generate new token (classic)'"
    echo "3. Select scopes: repo, read:org, workflow"
    echo "4. Copy the token"
    echo
    read -p "Enter your GitHub token (or press Enter to skip): " token
    if [ -n "$token" ]; then
        export GITHUB_TOKEN="$token"
        echo -e "\n${GREEN}Add this to your shell profile:${NC}"
        echo "export GITHUB_TOKEN=\"$token\""
    fi
fi

# Test the package
echo -e "\n${GREEN}Testing GitHub MCP server...${NC}"
if npx -y @modelcontextprotocol/server-github --version 2>/dev/null; then
    echo -e "${GREEN}✓ Package verified${NC}"
else
    echo -e "${YELLOW}⚠ Testing package...${NC}"
fi

# Install using Python script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MCP_MANAGER="$SCRIPT_DIR/../mcp-manager.py"

if [ -f "$MCP_MANAGER" ]; then
    echo -e "\n${GREEN}Adding to Claude configuration...${NC}"
    python3 "$MCP_MANAGER" add github --force
else
    echo -e "${RED}Error: MCP manager not found${NC}"
    echo "Falling back to manual installation..."
    
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
config['mcpServers']['github'] = {
    'command': 'npx',
    'args': ['-y', '@modelcontextprotocol/server-github'],
    'env': {'GITHUB_TOKEN': '\${GITHUB_TOKEN}'}
}
with open('$CONFIG_FILE', 'w') as f:
    json.dump(config, f, indent=2)
print("✓ Added GitHub MCP server to configuration")
EOF
    else
        echo -e "${RED}Error: Claude configuration not found${NC}"
        exit 1
    fi
fi

echo -e "\n${GREEN}✓ GitHub MCP server installed successfully!${NC}"
echo -e "\n${GREEN}Next steps:${NC}"
echo "1. Set GITHUB_TOKEN environment variable if not already done"
echo "2. Restart Claude for changes to take effect"
echo "3. Claude can now:"
echo "   - Create and manage issues"
echo "   - Review pull requests"
echo "   - Access repository data"
echo "   - Manage workflows"