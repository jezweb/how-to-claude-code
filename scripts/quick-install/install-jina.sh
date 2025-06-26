#!/bin/bash
# Quick install script for Jina MCP server

set -euo pipefail

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}Installing Jina MCP Server...${NC}"

# Check if JINA_API_KEY is set
if [ -z "${JINA_API_KEY:-}" ]; then
    echo -e "${YELLOW}Warning: JINA_API_KEY not set${NC}"
    echo "Get your API key at: https://jina.ai"
    read -p "Enter your Jina API key (or press Enter to skip): " api_key
    if [ -n "$api_key" ]; then
        export JINA_API_KEY="$api_key"
        echo -e "\n${GREEN}Add this to your shell profile:${NC}"
        echo "export JINA_API_KEY=\"$api_key\""
    fi
fi

# Test the package
echo -e "\n${GREEN}Testing Jina MCP tools...${NC}"
if npx jina-mcp-tools --version 2>/dev/null || npx jina-mcp-tools help 2>/dev/null; then
    echo -e "${GREEN}✓ Package verified${NC}"
else
    echo -e "${YELLOW}⚠ Could not verify package (this might be normal)${NC}"
fi

# Install using Python script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MCP_MANAGER="$SCRIPT_DIR/../mcp-manager.py"

if [ -f "$MCP_MANAGER" ]; then
    echo -e "\n${GREEN}Adding to Claude configuration...${NC}"
    python3 "$MCP_MANAGER" add jina --force
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
config['mcpServers']['jina-mcp-tools'] = {
    'command': 'npx',
    'args': ['jina-mcp-tools'],
    'env': {'JINA_API_KEY': '\${JINA_API_KEY}'}
}
with open('$CONFIG_FILE', 'w') as f:
    json.dump(config, f, indent=2)
print("✓ Added Jina MCP server to configuration")
EOF
    else
        echo -e "${RED}Error: Claude configuration not found${NC}"
        exit 1
    fi
fi

echo -e "\n${GREEN}✓ Jina MCP server installed successfully!${NC}"
echo -e "\n${GREEN}Next steps:${NC}"
echo "1. Set JINA_API_KEY environment variable if not already done"
echo "2. Restart Claude for changes to take effect"
echo "3. Use Jina for AI-powered search and content extraction"