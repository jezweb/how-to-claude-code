#!/bin/bash

# MCP Server Interactive Installer for Claude
# This script helps you install and configure MCP servers for Claude Code
# Repository: https://github.com/jezweb/how-to-claude-code

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
CLAUDE_CONFIG_PATHS=(
    "$HOME/.claude.json"
    "$HOME/.config/claude/claude.json"
    "$HOME/.claude/claude.json"
    "$HOME/Library/Application Support/Claude/claude.json"
)

# Popular MCP servers
declare -A MCP_SERVERS=(
    ["filesystem"]="@modelcontextprotocol/server-filesystem|Local file system access"
    ["github"]="@modelcontextprotocol/server-github|GitHub API integration|GITHUB_TOKEN"
    ["jina"]="jina-mcp-tools|AI-powered search and content extraction|JINA_API_KEY"
    ["playwright"]="@playwright/mcp|Browser automation and testing"
    ["cloudflare-workers"]="@cloudflare/mcp-server-workers|Cloudflare Workers management|CLOUDFLARE_API_TOKEN,CLOUDFLARE_ACCOUNT_ID"
    ["postgresql"]="@modelcontextprotocol/server-postgresql|PostgreSQL database access|DATABASE_URL"
    ["docker"]="@modelcontextprotocol/server-docker|Docker container management"
    ["aws"]="@modelcontextprotocol/server-aws|Amazon Web Services|AWS_ACCESS_KEY_ID,AWS_SECRET_ACCESS_KEY"
)

# Helper functions
print_header() {
    echo -e "\n${BLUE}=== $1 ===${NC}\n"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

# Find Claude configuration file
find_claude_config() {
    for config_path in "${CLAUDE_CONFIG_PATHS[@]}"; do
        if [[ -f "$config_path" ]]; then
            echo "$config_path"
            return 0
        fi
    done
    return 1
}

# Check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check prerequisites
check_prerequisites() {
    print_header "Checking Prerequisites"
    
    local missing_deps=()
    
    # Check Node.js
    if command_exists node; then
        print_success "Node.js installed ($(node --version))"
    else
        print_error "Node.js not installed"
        missing_deps+=("nodejs")
    fi
    
    # Check npm
    if command_exists npm; then
        print_success "npm installed ($(npm --version))"
    else
        print_error "npm not installed"
        missing_deps+=("npm")
    fi
    
    # Check Python 3
    if command_exists python3; then
        print_success "Python 3 installed ($(python3 --version))"
    else
        print_error "Python 3 not installed"
        missing_deps+=("python3")
    fi
    
    # Check jq (optional but helpful)
    if command_exists jq; then
        print_success "jq installed (JSON processor)"
    else
        print_warning "jq not installed (optional but recommended)"
    fi
    
    if [[ ${#missing_deps[@]} -gt 0 ]]; then
        echo -e "\n${RED}Missing required dependencies: ${missing_deps[*]}${NC}"
        echo "Please install them before continuing."
        exit 1
    fi
}

# Find or create Claude configuration
setup_claude_config() {
    print_header "Claude Configuration"
    
    if CLAUDE_CONFIG=$(find_claude_config); then
        print_success "Found Claude configuration at: $CLAUDE_CONFIG"
        
        # Create backup
        BACKUP_FILE="${CLAUDE_CONFIG}.backup.$(date +%Y%m%d_%H%M%S)"
        cp "$CLAUDE_CONFIG" "$BACKUP_FILE"
        print_success "Created backup at: $BACKUP_FILE"
    else
        print_warning "Claude configuration not found"
        echo -e "\nWould you like to create a new configuration file?"
        select create_option in "Yes, create at ~/.claude.json" "No, exit"; do
            case $create_option in
                "Yes, create at ~/.claude.json")
                    CLAUDE_CONFIG="$HOME/.claude.json"
                    echo '{"mcpServers": {}}' > "$CLAUDE_CONFIG"
                    print_success "Created new configuration at: $CLAUDE_CONFIG"
                    break
                    ;;
                "No, exit")
                    echo "Exiting..."
                    exit 0
                    ;;
            esac
        done
    fi
}

# List installed MCP servers
list_installed_servers() {
    print_header "Currently Installed MCP Servers"
    
    if [[ -f "$CLAUDE_CONFIG" ]]; then
        # Use Python to parse JSON (more reliable than jq for large files)
        python3 -c "
import json
try:
    with open('$CLAUDE_CONFIG', 'r') as f:
        config = json.load(f)
    servers = config.get('mcpServers', {})
    if servers:
        print('Installed servers:')
        for name, details in servers.items():
            cmd = details.get('command', 'unknown')
            args = ' '.join(details.get('args', []))
            print(f'  • {name}: {cmd} {args}')
    else:
        print('No MCP servers currently installed')
except Exception as e:
    print(f'Error reading configuration: {e}')
"
    else
        print_error "Configuration file not found"
    fi
}

# Show available MCP servers
show_available_servers() {
    print_header "Available MCP Servers"
    
    echo "Popular MCP servers you can install:"
    echo
    
    local index=1
    declare -a server_keys=()
    
    for server_key in "${!MCP_SERVERS[@]}"; do
        IFS='|' read -r package description env_vars <<< "${MCP_SERVERS[$server_key]}"
        echo "  $index) $server_key - $description"
        if [[ -n "${env_vars:-}" ]]; then
            echo "     Required: $env_vars"
        fi
        server_keys+=("$server_key")
        ((index++))
    done
    
    echo "  $index) Custom (enter package name manually)"
    echo "  0) Back to main menu"
}

# Install MCP server
install_mcp_server() {
    local server_key="$1"
    local server_info="${MCP_SERVERS[$server_key]}"
    IFS='|' read -r package description env_vars <<< "$server_info"
    
    print_header "Installing $server_key"
    echo "Package: $package"
    echo "Description: $description"
    
    # Check if already installed
    if python3 -c "import json; config=json.load(open('$CLAUDE_CONFIG')); exit(0 if '$server_key' in config.get('mcpServers', {}) else 1)" 2>/dev/null; then
        print_warning "$server_key is already installed"
        read -p "Do you want to reinstall/update it? (y/n): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            return
        fi
    fi
    
    # Test the package
    echo -e "\nTesting MCP server..."
    if npx -y "$package" --version 2>/dev/null || npx -y "$package" help 2>/dev/null; then
        print_success "Server package is accessible"
    else
        print_warning "Could not verify server package (this might be normal for some servers)"
        read -p "Continue with installation? (y/n): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            return
        fi
    fi
    
    # Handle environment variables
    local env_config="{}"
    if [[ -n "${env_vars:-}" ]]; then
        echo -e "\nThis server requires the following environment variables:"
        IFS=',' read -ra REQUIRED_VARS <<< "$env_vars"
        
        env_config="{"
        for var in "${REQUIRED_VARS[@]}"; do
            var=$(echo "$var" | xargs)  # Trim whitespace
            current_value="${!var:-}"
            
            if [[ -n "$current_value" ]]; then
                echo -e "${GREEN}✓${NC} $var is set in your environment"
                env_config+='"'$var'": "${'$var'}", '
            else
                echo -e "${YELLOW}⚠${NC} $var is not set"
                read -p "Enter value for $var (or press Enter to use \${$var}): " var_value
                
                if [[ -n "$var_value" ]]; then
                    # For security, we'll still reference the env var
                    echo "export $var=\"$var_value\"" >> ~/.claude-env-temp
                    print_info "Add this to your shell profile: export $var=\"...\""
                fi
                env_config+='"'$var'": "${'$var'}", '
            fi
        done
        env_config="${env_config%, }}"
    fi
    
    # Special handling for different servers
    local args_array='[]'
    case "$server_key" in
        "filesystem")
            read -p "Enter directory to allow access to (default: \$HOME): " fs_dir
            fs_dir="${fs_dir:-\$HOME}"
            args_array='["-y", "'$package'", "'$fs_dir'"]'
            ;;
        "jina")
            args_array='["jina-mcp-tools"]'
            ;;
        *)
            args_array='["-y", "'$package'"]'
            ;;
    esac
    
    # Add to configuration using Python
    print_info "Adding $server_key to configuration..."
    
    python3 << EOF
import json
import os

config_path = '$CLAUDE_CONFIG'
with open(config_path, 'r') as f:
    config = json.load(f)

if 'mcpServers' not in config:
    config['mcpServers'] = {}

config['mcpServers']['$server_key'] = {
    'command': 'npx',
    'args': $args_array,
    'env': $env_config
}

with open(config_path, 'w') as f:
    json.dump(config, f, indent=2)

print("✓ Successfully added $server_key to configuration")
EOF
    
    if [[ -f ~/.claude-env-temp ]]; then
        echo -e "\n${YELLOW}Important:${NC} Add these environment variables to your shell profile:"
        cat ~/.claude-env-temp
        rm ~/.claude-env-temp
    fi
    
    print_success "Installation complete!"
    echo -e "\n${BLUE}Next steps:${NC}"
    echo "1. Set any required environment variables"
    echo "2. Restart Claude for changes to take effect"
}

# Install custom MCP server
install_custom_server() {
    print_header "Install Custom MCP Server"
    
    read -p "Enter the package name (e.g., @org/mcp-server): " package_name
    read -p "Enter a name for this server: " server_name
    read -p "Enter a description: " server_description
    
    # Create custom server entry
    MCP_SERVERS["$server_name"]="$package_name|$server_description|"
    
    # Install using the standard process
    install_mcp_server "$server_name"
}

# Remove MCP server
remove_mcp_server() {
    print_header "Remove MCP Server"
    
    # List installed servers
    local servers=$(python3 -c "
import json
with open('$CLAUDE_CONFIG', 'r') as f:
    config = json.load(f)
servers = list(config.get('mcpServers', {}).keys())
for i, server in enumerate(servers, 1):
    print(f'{i}) {server}')
print('0) Cancel')
")
    
    if [[ -z "$servers" ]] || [[ "$servers" == "0) Cancel" ]]; then
        print_warning "No MCP servers installed"
        return
    fi
    
    echo "$servers"
    read -p "Select server to remove: " choice
    
    if [[ "$choice" == "0" ]]; then
        return
    fi
    
    # Get server name and remove it
    local server_name=$(python3 -c "
import json
with open('$CLAUDE_CONFIG', 'r') as f:
    config = json.load(f)
servers = list(config.get('mcpServers', {}).keys())
try:
    print(servers[$choice - 1])
except:
    pass
")
    
    if [[ -n "$server_name" ]]; then
        python3 << EOF
import json

with open('$CLAUDE_CONFIG', 'r') as f:
    config = json.load(f)

if 'mcpServers' in config and '$server_name' in config['mcpServers']:
    del config['mcpServers']['$server_name']
    
    with open('$CLAUDE_CONFIG', 'w') as f:
        json.dump(config, f, indent=2)
    
    print("✓ Successfully removed $server_name")
else:
    print("✗ Server not found")
EOF
    fi
}

# Validate configuration
validate_configuration() {
    print_header "Validate Configuration"
    
    echo "Checking configuration file..."
    
    # Check JSON syntax
    if python3 -m json.tool "$CLAUDE_CONFIG" > /dev/null 2>&1; then
        print_success "JSON syntax is valid"
    else
        print_error "JSON syntax error"
        python3 -m json.tool "$CLAUDE_CONFIG" 2>&1 | head -10
        return 1
    fi
    
    # Check structure
    python3 << EOF
import json
import sys

try:
    with open('$CLAUDE_CONFIG', 'r') as f:
        config = json.load(f)
    
    # Check for mcpServers
    if 'mcpServers' not in config:
        print("⚠ No mcpServers section found")
        sys.exit(1)
    
    # Validate each server
    servers = config['mcpServers']
    for name, server in servers.items():
        print(f"\nValidating {name}:")
        
        if 'command' not in server:
            print(f"  ✗ Missing 'command' field")
        else:
            print(f"  ✓ Command: {server['command']}")
        
        if 'args' in server:
            print(f"  ✓ Args: {' '.join(server['args'])}")
        
        if 'env' in server:
            missing_vars = []
            for var, value in server['env'].items():
                if value.startswith('\${') and value.endswith('}'):
                    env_var = value[2:-1].split(':')[0]
                    import os
                    if env_var not in os.environ:
                        missing_vars.append(env_var)
            
            if missing_vars:
                print(f"  ⚠ Missing environment variables: {', '.join(missing_vars)}")
            else:
                print(f"  ✓ All environment variables configured")
    
    print("\n✓ Configuration validation complete")
    
except Exception as e:
    print(f"✗ Error validating configuration: {e}")
    sys.exit(1)
EOF
}

# Main menu
main_menu() {
    while true; do
        print_header "Claude MCP Server Installer"
        
        echo "What would you like to do?"
        echo
        echo "  1) List installed MCP servers"
        echo "  2) Install new MCP server"
        echo "  3) Remove MCP server"
        echo "  4) Validate configuration"
        echo "  5) Show configuration location"
        echo "  6) Exit"
        echo
        
        read -p "Select an option: " choice
        
        case $choice in
            1)
                list_installed_servers
                read -p "Press Enter to continue..."
                ;;
            2)
                show_available_servers
                echo
                read -p "Select a server to install: " server_choice
                
                # Get server key from choice
                local server_keys=($(printf '%s\n' "${!MCP_SERVERS[@]}"))
                
                if [[ "$server_choice" == "0" ]]; then
                    continue
                elif [[ "$server_choice" -gt 0 && "$server_choice" -le "${#server_keys[@]}" ]]; then
                    local selected_server="${server_keys[$((server_choice-1))]}"
                    install_mcp_server "$selected_server"
                elif [[ "$server_choice" == "$((${#server_keys[@]}+1))" ]]; then
                    install_custom_server
                else
                    print_error "Invalid selection"
                fi
                
                read -p "Press Enter to continue..."
                ;;
            3)
                remove_mcp_server
                read -p "Press Enter to continue..."
                ;;
            4)
                validate_configuration
                read -p "Press Enter to continue..."
                ;;
            5)
                echo -e "\nConfiguration file: ${BLUE}$CLAUDE_CONFIG${NC}"
                if [[ -f "${CLAUDE_CONFIG}.backup."* ]]; then
                    echo -e "Latest backup: ${BLUE}$(ls -t "${CLAUDE_CONFIG}.backup."* | head -1)${NC}"
                fi
                read -p "Press Enter to continue..."
                ;;
            6)
                echo "Goodbye!"
                exit 0
                ;;
            *)
                print_error "Invalid option"
                sleep 1
                ;;
        esac
    done
}

# Script entry point
main() {
    echo -e "${BLUE}╔══════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║     Claude MCP Server Installer v1.0     ║${NC}"
    echo -e "${BLUE}╚══════════════════════════════════════════╝${NC}"
    
    # Check prerequisites
    check_prerequisites
    
    # Setup Claude configuration
    setup_claude_config
    
    # Show main menu
    main_menu
}

# Run main function
main "$@"