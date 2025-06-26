#!/bin/bash
# Find Claude configuration file on the system

set -euo pipefail

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}Searching for Claude configuration files...${NC}\n"

# Common locations to check
CONFIG_PATHS=(
    "$HOME/.claude.json"
    "$HOME/.config/claude/claude.json"
    "$HOME/.claude/claude.json"
    "$HOME/Library/Application Support/Claude/claude.json"
    "$HOME/.config/Claude/claude.json"
    "$HOME/AppData/Roaming/Claude/claude.json"
)

found=false

# Check known locations
for path in "${CONFIG_PATHS[@]}"; do
    if [ -f "$path" ]; then
        echo -e "${GREEN}✓ Found: $path${NC}"
        
        # Show file info
        size=$(du -h "$path" | cut -f1)
        modified=$(date -r "$path" "+%Y-%m-%d %H:%M:%S" 2>/dev/null || stat -c "%y" "$path" 2>/dev/null | cut -d. -f1 || echo "unknown")
        
        echo "  Size: $size"
        echo "  Modified: $modified"
        
        # Check if mcpServers configured
        if command -v python3 >/dev/null 2>&1; then
            server_count=$(python3 -c "
import json
try:
    with open('$path', 'r') as f:
        config = json.load(f)
    servers = config.get('mcpServers', {})
    print(len(servers))
except:
    print('?')
" 2>/dev/null || echo "?")
            
            if [ "$server_count" != "?" ]; then
                echo "  MCP Servers: $server_count"
            fi
        fi
        
        echo
        found=true
    fi
done

# Search for other possible locations
if command -v find >/dev/null 2>&1; then
    echo -e "${BLUE}Searching for other .claude.json files...${NC}"
    
    other_files=$(find ~ -name ".claude.json" -o -name "claude.json" 2>/dev/null | grep -v -E "(node_modules|\.git|cache|tmp|temp)" | sort -u)
    
    if [ -n "$other_files" ]; then
        echo "$other_files" | while read -r file; do
            already_shown=false
            for path in "${CONFIG_PATHS[@]}"; do
                if [ "$file" = "$path" ]; then
                    already_shown=true
                    break
                fi
            done
            
            if [ "$already_shown" = false ]; then
                echo -e "${YELLOW}? Found: $file${NC}"
                found=true
            fi
        done
    fi
fi

if [ "$found" = false ]; then
    echo -e "${YELLOW}No Claude configuration files found.${NC}"
    echo
    echo "Claude configuration is typically located at:"
    echo "  • Linux/macOS: ~/.claude.json"
    echo "  • Windows: %USERPROFILE%\.claude.json"
    echo
    echo "To create a new configuration, run:"
    echo "  ./install-mcp-server.sh"
fi

# Check for backups
echo -e "\n${BLUE}Checking for backup files...${NC}"
backup_count=0
for path in "${CONFIG_PATHS[@]}"; do
    dir=$(dirname "$path")
    if [ -d "$dir" ]; then
        backups=$(find "$dir" -name "*.claude.json.backup.*" -o -name "claude.json.backup.*" 2>/dev/null | sort -r)
        if [ -n "$backups" ]; then
            echo "$backups" | head -5 | while read -r backup; do
                echo -e "${BLUE}↻ Backup: $backup${NC}"
                backup_count=$((backup_count + 1))
            done
        fi
    fi
done

if [ $backup_count -eq 0 ]; then
    echo "No backup files found."
fi