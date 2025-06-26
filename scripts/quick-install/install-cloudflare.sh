#!/bin/bash
# Quick install script for Cloudflare MCP servers

set -euo pipefail

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${GREEN}Installing Cloudflare MCP Servers...${NC}"

# Check environment variables
echo -e "\n${BLUE}Checking Cloudflare credentials...${NC}"

missing_vars=()
if [ -z "${CLOUDFLARE_API_TOKEN:-}" ]; then
    missing_vars+=("CLOUDFLARE_API_TOKEN")
fi
if [ -z "${CLOUDFLARE_ACCOUNT_ID:-}" ]; then
    missing_vars+=("CLOUDFLARE_ACCOUNT_ID")
fi

if [ ${#missing_vars[@]} -gt 0 ]; then
    echo -e "${YELLOW}Warning: Missing environment variables: ${missing_vars[*]}${NC}"
    echo -e "\n${BLUE}To get your Cloudflare credentials:${NC}"
    echo "1. Log in to https://dash.cloudflare.com"
    echo "2. Go to My Profile > API Tokens"
    echo "3. Create a token with appropriate permissions"
    echo "4. Copy your Account ID from the right sidebar"
    echo
    
    read -p "Enter your Cloudflare API Token (or press Enter to skip): " api_token
    if [ -n "$api_token" ]; then
        export CLOUDFLARE_API_TOKEN="$api_token"
    fi
    
    read -p "Enter your Cloudflare Account ID (or press Enter to skip): " account_id
    if [ -n "$account_id" ]; then
        export CLOUDFLARE_ACCOUNT_ID="$account_id"
    fi
    
    if [ -n "$api_token" ] || [ -n "$account_id" ]; then
        echo -e "\n${GREEN}Add these to your shell profile:${NC}"
        [ -n "$api_token" ] && echo "export CLOUDFLARE_API_TOKEN=\"$api_token\""
        [ -n "$account_id" ] && echo "export CLOUDFLARE_ACCOUNT_ID=\"$account_id\""
    fi
fi

# Cloudflare servers to install
declare -A CF_SERVERS=(
    ["cloudflare-workers"]="@cloudflare/mcp-server-workers|Workers management"
    ["cloudflare-observability"]="@cloudflare/mcp-server-observability|Workers observability"
    ["cloudflare-ai-gateway"]="@cloudflare/mcp-server-ai-gateway|AI Gateway management"
    ["cloudflare-dns-analytics"]="@cloudflare/mcp-server-dns-analytics|DNS analytics"
)

# Install using Python script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MCP_MANAGER="$SCRIPT_DIR/../mcp-manager.py"
CONFIG_FILE="$HOME/.claude.json"

# Create backup
if [ -f "$CONFIG_FILE" ]; then
    cp "$CONFIG_FILE" "$CONFIG_FILE.backup.$(date +%Y%m%d_%H%M%S)"
    echo -e "${GREEN}✓ Created backup${NC}"
fi

# Install each server
for server_name in "${!CF_SERVERS[@]}"; do
    IFS='|' read -r package description <<< "${CF_SERVERS[$server_name]}"
    
    echo -e "\n${BLUE}Installing $server_name - $description${NC}"
    
    if [ -f "$MCP_MANAGER" ]; then
        # Use MCP manager
        python3 "$MCP_MANAGER" add "$server_name" --package "$package" --force \
            --env CLOUDFLARE_API_TOKEN='${CLOUDFLARE_API_TOKEN}' \
            --env CLOUDFLARE_ACCOUNT_ID='${CLOUDFLARE_ACCOUNT_ID}'
    else
        # Manual installation
        python3 << EOF
import json
import os

config_file = '$CONFIG_FILE'
if os.path.exists(config_file):
    with open(config_file, 'r') as f:
        config = json.load(f)
else:
    config = {'mcpServers': {}}

if 'mcpServers' not in config:
    config['mcpServers'] = {}

config['mcpServers']['$server_name'] = {
    'command': 'npx',
    'args': ['-y', '$package'],
    'env': {
        'CLOUDFLARE_API_TOKEN': '\${CLOUDFLARE_API_TOKEN}',
        'CLOUDFLARE_ACCOUNT_ID': '\${CLOUDFLARE_ACCOUNT_ID}'
    }
}

with open(config_file, 'w') as f:
    json.dump(config, f, indent=2)

print("✓ Added $server_name")
EOF
    fi
done

echo -e "\n${GREEN}✓ All Cloudflare MCP servers installed successfully!${NC}"
echo -e "\n${GREEN}Installed servers:${NC}"
for server_name in "${!CF_SERVERS[@]}"; do
    IFS='|' read -r package description <<< "${CF_SERVERS[$server_name]}"
    echo "  • $server_name - $description"
done

echo -e "\n${GREEN}Next steps:${NC}"
echo "1. Set CLOUDFLARE_API_TOKEN and CLOUDFLARE_ACCOUNT_ID if not done"
echo "2. Restart Claude for changes to take effect"
echo "3. Claude can now manage:"
echo "   - Cloudflare Workers"
echo "   - AI Gateway"
echo "   - DNS Analytics"
echo "   - Worker Observability"