#!/usr/bin/env python3
"""
MCP Manager - Advanced MCP Server Management for Claude

This tool provides advanced management capabilities for MCP servers,
including installation, configuration, testing, and troubleshooting.
"""

import json
import os
import sys
import argparse
import subprocess
import shutil
from pathlib import Path
from typing import Dict, List, Optional, Any
import tempfile
import datetime

# ANSI color codes
class Colors:
    RED = '\033[0;31m'
    GREEN = '\033[0;32m'
    YELLOW = '\033[1;33m'
    BLUE = '\033[0;34m'
    MAGENTA = '\033[0;35m'
    CYAN = '\033[0;36m'
    NC = '\033[0m'  # No Color

# Configuration paths
CLAUDE_CONFIG_PATHS = [
    Path.home() / ".claude.json",
    Path.home() / ".config" / "claude" / "claude.json",
    Path.home() / ".claude" / "claude.json",
    Path.home() / "Library" / "Application Support" / "Claude" / "claude.json",
]

# Popular MCP servers registry
MCP_REGISTRY = {
    "filesystem": {
        "package": "@modelcontextprotocol/server-filesystem",
        "description": "Local file system access",
        "args_template": ["-y", "{package}", "{path}"],
        "env_vars": [],
        "prompts": {
            "path": "Enter directory to allow access to (default: $HOME): "
        }
    },
    "github": {
        "package": "@modelcontextprotocol/server-github",
        "description": "GitHub API integration",
        "args_template": ["-y", "{package}"],
        "env_vars": ["GITHUB_TOKEN"],
        "setup_help": "Get a token at: https://github.com/settings/tokens"
    },
    "jina": {
        "package": "jina-mcp-tools",
        "description": "AI-powered search and content extraction",
        "args_template": ["jina-mcp-tools"],
        "env_vars": ["JINA_API_KEY"],
        "setup_help": "Get an API key at: https://jina.ai"
    },
    "context7": {
        "package": "@upstash/context7-mcp",
        "description": "Real-time documentation retrieval for programming libraries",
        "args_template": ["-y", "{package}"],
        "env_vars": [],
        "setup_help": "No API key required! Just add 'use context7' to your prompts"
    },
    "playwright": {
        "package": "@playwright/mcp",
        "description": "Browser automation and testing",
        "args_template": ["{package}"],
        "env_vars": [],
        "post_install": ["npx", "playwright", "install"]
    },
    "cloudflare-workers": {
        "package": "@cloudflare/mcp-server-workers",
        "description": "Cloudflare Workers management",
        "args_template": ["-y", "{package}"],
        "env_vars": ["CLOUDFLARE_API_TOKEN", "CLOUDFLARE_ACCOUNT_ID"]
    },
    "postgresql": {
        "package": "@modelcontextprotocol/server-postgresql",
        "description": "PostgreSQL database access",
        "args_template": ["-y", "{package}"],
        "env_vars": ["DATABASE_URL"]
    }
}

class MCPManager:
    def __init__(self):
        self.config_path = self._find_config()
        self.config = self._load_config()
        
    def _find_config(self) -> Optional[Path]:
        """Find Claude configuration file"""
        for path in CLAUDE_CONFIG_PATHS:
            if path.exists():
                return path
        return None
    
    def _load_config(self) -> Dict[str, Any]:
        """Load Claude configuration"""
        if not self.config_path:
            return {"mcpServers": {}}
        
        try:
            with open(self.config_path, 'r') as f:
                return json.load(f)
        except json.JSONDecodeError as e:
            print(f"{Colors.RED}Error reading configuration: {e}{Colors.NC}")
            sys.exit(1)
        except Exception as e:
            print(f"{Colors.RED}Error: {e}{Colors.NC}")
            return {"mcpServers": {}}
    
    def _save_config(self):
        """Save configuration with backup"""
        if self.config_path:
            # Create backup
            backup_path = self.config_path.with_suffix(
                f".json.backup.{datetime.datetime.now().strftime('%Y%m%d_%H%M%S')}"
            )
            shutil.copy2(self.config_path, backup_path)
            print(f"{Colors.GREEN}✓ Created backup: {backup_path}{Colors.NC}")
        else:
            # Create new config
            self.config_path = Path.home() / ".claude.json"
        
        # Save configuration
        with open(self.config_path, 'w') as f:
            json.dump(self.config, f, indent=2)
        print(f"{Colors.GREEN}✓ Saved configuration to: {self.config_path}{Colors.NC}")
    
    def list_servers(self, verbose: bool = False):
        """List installed MCP servers"""
        servers = self.config.get("mcpServers", {})
        
        if not servers:
            print(f"{Colors.YELLOW}No MCP servers installed{Colors.NC}")
            return
        
        print(f"\n{Colors.BLUE}Installed MCP Servers:{Colors.NC}")
        for name, details in servers.items():
            print(f"\n  {Colors.CYAN}{name}{Colors.NC}")
            print(f"    Command: {details.get('command', 'unknown')}")
            
            if 'args' in details:
                args_str = ' '.join(details['args'])
                print(f"    Args: {args_str}")
            
            if verbose and 'env' in details:
                print(f"    Environment:")
                for var, value in details['env'].items():
                    if value.startswith("${") and value.endswith("}"):
                        env_name = value[2:-1].split(':')[0]
                        is_set = env_name in os.environ
                        status = f"{Colors.GREEN}✓{Colors.NC}" if is_set else f"{Colors.RED}✗{Colors.NC}"
                        print(f"      {status} {var}: {value}")
                    else:
                        print(f"      {var}: [hidden]")
    
    def add_server(self, name: str, package: str = None, 
                   command: str = "npx", args: List[str] = None,
                   env: Dict[str, str] = None, force: bool = False):
        """Add a new MCP server"""
        # Check if server already exists
        if name in self.config.get("mcpServers", {}) and not force:
            print(f"{Colors.YELLOW}Server '{name}' already exists. Use --force to overwrite.{Colors.NC}")
            return False
        
        # Use registry if available
        if name in MCP_REGISTRY and not package:
            registry_info = MCP_REGISTRY[name]
            package = registry_info["package"]
            
            # Handle prompts
            if "prompts" in registry_info:
                for key, prompt in registry_info["prompts"].items():
                    value = input(prompt)
                    if not value and key == "path":
                        value = "$HOME"
                    # Update args template
                    args = [arg.replace(f"{{{key}}}", value) for arg in registry_info["args_template"]]
            else:
                args = registry_info["args_template"]
            
            # Replace package placeholder
            args = [arg.replace("{package}", package) for arg in args]
            
            # Handle environment variables
            if registry_info["env_vars"]:
                env = env or {}
                for var in registry_info["env_vars"]:
                    if var not in env:
                        env[var] = f"${{{var}}}"
                        if var not in os.environ:
                            print(f"{Colors.YELLOW}⚠ {var} not set in environment{Colors.NC}")
                            if "setup_help" in registry_info:
                                print(f"  {registry_info['setup_help']}")
        
        # Test the server
        print(f"\n{Colors.BLUE}Testing server...{Colors.NC}")
        test_cmd = [command] + (args or [])
        
        # For npx commands, add --version or help
        if command == "npx" and package:
            test_version = test_cmd + ["--version"]
            result = subprocess.run(test_version, capture_output=True, text=True)
            if result.returncode != 0:
                # Try help command
                test_help = test_cmd + ["help"]
                result = subprocess.run(test_help, capture_output=True, text=True)
        
        if result.returncode == 0:
            print(f"{Colors.GREEN}✓ Server package is accessible{Colors.NC}")
        else:
            print(f"{Colors.YELLOW}⚠ Could not verify server package{Colors.NC}")
            response = input("Continue anyway? (y/n): ")
            if response.lower() != 'y':
                return False
        
        # Add to configuration
        if "mcpServers" not in self.config:
            self.config["mcpServers"] = {}
        
        self.config["mcpServers"][name] = {
            "command": command,
            "args": args or []
        }
        
        if env:
            self.config["mcpServers"][name]["env"] = env
        
        # Save configuration
        self._save_config()
        
        # Run post-install if needed
        if name in MCP_REGISTRY and "post_install" in MCP_REGISTRY[name]:
            print(f"\n{Colors.BLUE}Running post-install commands...{Colors.NC}")
            post_cmd = MCP_REGISTRY[name]["post_install"]
            subprocess.run(post_cmd)
        
        print(f"\n{Colors.GREEN}✓ Successfully added '{name}' server{Colors.NC}")
        print(f"\n{Colors.BLUE}Next steps:{Colors.NC}")
        print("1. Set any required environment variables")
        print("2. Restart Claude for changes to take effect")
        
        return True
    
    def remove_server(self, name: str):
        """Remove an MCP server"""
        servers = self.config.get("mcpServers", {})
        
        if name not in servers:
            print(f"{Colors.RED}Server '{name}' not found{Colors.NC}")
            return False
        
        # Confirm removal
        print(f"\n{Colors.YELLOW}Are you sure you want to remove '{name}'?{Colors.NC}")
        response = input("Type 'yes' to confirm: ")
        
        if response.lower() != 'yes':
            print("Cancelled")
            return False
        
        # Remove from config
        del self.config["mcpServers"][name]
        self._save_config()
        
        print(f"{Colors.GREEN}✓ Successfully removed '{name}'{Colors.NC}")
        return True
    
    def update_server(self, name: str, **kwargs):
        """Update server configuration"""
        servers = self.config.get("mcpServers", {})
        
        if name not in servers:
            print(f"{Colors.RED}Server '{name}' not found{Colors.NC}")
            return False
        
        server = servers[name]
        
        # Update fields
        if "command" in kwargs:
            server["command"] = kwargs["command"]
        
        if "args" in kwargs:
            server["args"] = kwargs["args"]
        
        if "env" in kwargs:
            if "env" not in server:
                server["env"] = {}
            server["env"].update(kwargs["env"])
        
        self._save_config()
        print(f"{Colors.GREEN}✓ Successfully updated '{name}'{Colors.NC}")
        return True
    
    def test_server(self, name: str):
        """Test an MCP server connection"""
        servers = self.config.get("mcpServers", {})
        
        if name not in servers:
            print(f"{Colors.RED}Server '{name}' not found{Colors.NC}")
            return False
        
        server = servers[name]
        print(f"\n{Colors.BLUE}Testing '{name}' server...{Colors.NC}")
        
        # Check environment variables
        if "env" in server:
            print(f"\n{Colors.CYAN}Environment variables:{Colors.NC}")
            all_set = True
            for var, value in server["env"].items():
                if value.startswith("${") and value.endswith("}"):
                    env_name = value[2:-1].split(':')[0]
                    is_set = env_name in os.environ
                    status = f"{Colors.GREEN}✓{Colors.NC}" if is_set else f"{Colors.RED}✗{Colors.NC}"
                    print(f"  {status} {var}: {env_name}")
                    if not is_set:
                        all_set = False
            
            if not all_set:
                print(f"\n{Colors.YELLOW}⚠ Some environment variables are not set{Colors.NC}")
        
        # Test command
        cmd = [server["command"]] + server.get("args", [])
        print(f"\n{Colors.CYAN}Testing command:{Colors.NC} {' '.join(cmd)}")
        
        # Set environment for test
        test_env = os.environ.copy()
        if "env" in server:
            for var, value in server["env"].items():
                if value.startswith("${") and value.endswith("}"):
                    env_name = value[2:-1].split(':')[0]
                    if env_name in os.environ:
                        test_env[var] = os.environ[env_name]
        
        # Run test
        try:
            result = subprocess.run(cmd + ["--version"], 
                                  capture_output=True, 
                                  text=True, 
                                  env=test_env,
                                  timeout=10)
            
            if result.returncode == 0:
                print(f"{Colors.GREEN}✓ Server responded successfully{Colors.NC}")
                if result.stdout:
                    print(f"  Output: {result.stdout.strip()}")
            else:
                print(f"{Colors.RED}✗ Server test failed{Colors.NC}")
                if result.stderr:
                    print(f"  Error: {result.stderr.strip()}")
        except subprocess.TimeoutExpired:
            print(f"{Colors.RED}✗ Server test timed out{Colors.NC}")
        except Exception as e:
            print(f"{Colors.RED}✗ Error testing server: {e}{Colors.NC}")
        
        return True
    
    def validate_config(self):
        """Validate the entire configuration"""
        print(f"\n{Colors.BLUE}Validating configuration...{Colors.NC}")
        
        # Check JSON structure
        if not isinstance(self.config, dict):
            print(f"{Colors.RED}✗ Invalid configuration structure{Colors.NC}")
            return False
        
        # Check mcpServers
        if "mcpServers" not in self.config:
            print(f"{Colors.YELLOW}⚠ No mcpServers section found{Colors.NC}")
            self.config["mcpServers"] = {}
            self._save_config()
        
        servers = self.config["mcpServers"]
        issues = []
        
        for name, server in servers.items():
            print(f"\n{Colors.CYAN}Checking '{name}'...{Colors.NC}")
            
            # Check required fields
            if "command" not in server:
                issues.append(f"'{name}' missing 'command' field")
                print(f"  {Colors.RED}✗ Missing 'command' field{Colors.NC}")
            else:
                print(f"  {Colors.GREEN}✓ Command: {server['command']}{Colors.NC}")
            
            # Check environment variables
            if "env" in server:
                for var, value in server["env"].items():
                    if value.startswith("${") and value.endswith("}"):
                        env_name = value[2:-1].split(':')[0]
                        if env_name not in os.environ:
                            print(f"  {Colors.YELLOW}⚠ {var}: {env_name} not in environment{Colors.NC}")
        
        if issues:
            print(f"\n{Colors.RED}Found {len(issues)} issues:{Colors.NC}")
            for issue in issues:
                print(f"  • {issue}")
            return False
        else:
            print(f"\n{Colors.GREEN}✓ Configuration is valid{Colors.NC}")
            return True
    
    def export_config(self, output_file: str = None):
        """Export configuration"""
        if not output_file:
            output_file = f"claude-config-export-{datetime.datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
        
        # Create export without sensitive data
        export_config = json.loads(json.dumps(self.config))  # Deep copy
        
        # Sanitize environment variables
        for server_name, server in export_config.get("mcpServers", {}).items():
            if "env" in server:
                for var, value in server["env"].items():
                    if not (value.startswith("${") and value.endswith("}")):
                        server["env"][var] = "${" + var + "}"
        
        with open(output_file, 'w') as f:
            json.dump(export_config, f, indent=2)
        
        print(f"{Colors.GREEN}✓ Exported configuration to: {output_file}{Colors.NC}")
        return True
    
    def import_config(self, input_file: str, merge: bool = True):
        """Import configuration"""
        if not os.path.exists(input_file):
            print(f"{Colors.RED}File not found: {input_file}{Colors.NC}")
            return False
        
        try:
            with open(input_file, 'r') as f:
                import_config = json.load(f)
        except json.JSONDecodeError as e:
            print(f"{Colors.RED}Invalid JSON in import file: {e}{Colors.NC}")
            return False
        
        if merge:
            # Merge with existing
            if "mcpServers" in import_config:
                if "mcpServers" not in self.config:
                    self.config["mcpServers"] = {}
                
                for name, server in import_config["mcpServers"].items():
                    if name in self.config["mcpServers"]:
                        print(f"{Colors.YELLOW}⚠ '{name}' already exists, skipping{Colors.NC}")
                    else:
                        self.config["mcpServers"][name] = server
                        print(f"{Colors.GREEN}✓ Imported '{name}'{Colors.NC}")
        else:
            # Replace entire config
            self.config = import_config
            print(f"{Colors.GREEN}✓ Replaced configuration{Colors.NC}")
        
        self._save_config()
        return True
    
    def show_registry(self):
        """Show available MCP servers in registry"""
        print(f"\n{Colors.BLUE}Available MCP Servers:{Colors.NC}")
        
        for name, info in MCP_REGISTRY.items():
            print(f"\n  {Colors.CYAN}{name}{Colors.NC}")
            print(f"    Package: {info['package']}")
            print(f"    Description: {info['description']}")
            
            if info['env_vars']:
                print(f"    Required vars: {', '.join(info['env_vars'])}")
            
            if 'setup_help' in info:
                print(f"    Setup: {info['setup_help']}")

def main():
    parser = argparse.ArgumentParser(
        description="MCP Manager - Advanced MCP Server Management for Claude",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  %(prog)s list                          # List installed servers
  %(prog)s list -v                       # List with details
  %(prog)s add jina                      # Add Jina server from registry
  %(prog)s add custom-server --package @org/package
  %(prog)s remove jina                   # Remove server
  %(prog)s test github                   # Test server connection
  %(prog)s validate                      # Validate configuration
  %(prog)s registry                      # Show available servers
        """
    )
    
    subparsers = parser.add_subparsers(dest='command', help='Commands')
    
    # List command
    list_parser = subparsers.add_parser('list', help='List installed MCP servers')
    list_parser.add_argument('-v', '--verbose', action='store_true', 
                            help='Show detailed information')
    
    # Add command
    add_parser = subparsers.add_parser('add', help='Add a new MCP server')
    add_parser.add_argument('name', help='Server name')
    add_parser.add_argument('--package', help='NPM package name')
    add_parser.add_argument('--command', default='npx', help='Command to run')
    add_parser.add_argument('--args', nargs='*', help='Command arguments')
    add_parser.add_argument('--env', nargs='*', help='Environment variables (KEY=VALUE)')
    add_parser.add_argument('--force', action='store_true', help='Overwrite existing')
    
    # Remove command
    remove_parser = subparsers.add_parser('remove', help='Remove an MCP server')
    remove_parser.add_argument('name', help='Server name to remove')
    
    # Update command
    update_parser = subparsers.add_parser('update', help='Update server configuration')
    update_parser.add_argument('name', help='Server name')
    update_parser.add_argument('--command', help='New command')
    update_parser.add_argument('--args', nargs='*', help='New arguments')
    update_parser.add_argument('--env', nargs='*', help='Environment variables (KEY=VALUE)')
    
    # Test command
    test_parser = subparsers.add_parser('test', help='Test an MCP server')
    test_parser.add_argument('name', help='Server name to test')
    
    # Validate command
    subparsers.add_parser('validate', help='Validate configuration')
    
    # Export command
    export_parser = subparsers.add_parser('export', help='Export configuration')
    export_parser.add_argument('--output', help='Output file')
    
    # Import command
    import_parser = subparsers.add_parser('import', help='Import configuration')
    import_parser.add_argument('file', help='Import file')
    import_parser.add_argument('--replace', action='store_true', 
                              help='Replace instead of merge')
    
    # Registry command
    subparsers.add_parser('registry', help='Show available MCP servers')
    
    args = parser.parse_args()
    
    # Initialize manager
    manager = MCPManager()
    
    if not manager.config_path and args.command != 'add':
        print(f"{Colors.YELLOW}No Claude configuration found.{Colors.NC}")
        print(f"Run '{sys.argv[0]} add <server>' to create one.")
        sys.exit(1)
    
    # Execute command
    if args.command == 'list':
        manager.list_servers(verbose=args.verbose)
    
    elif args.command == 'add':
        env_dict = {}
        if args.env:
            for env_pair in args.env:
                if '=' in env_pair:
                    key, value = env_pair.split('=', 1)
                    env_dict[key] = value
        
        manager.add_server(
            args.name, 
            package=args.package,
            command=args.command,
            args=args.args,
            env=env_dict if env_dict else None,
            force=args.force
        )
    
    elif args.command == 'remove':
        manager.remove_server(args.name)
    
    elif args.command == 'update':
        kwargs = {}
        if args.command:
            kwargs['command'] = args.command
        if args.args:
            kwargs['args'] = args.args
        if args.env:
            env_dict = {}
            for env_pair in args.env:
                if '=' in env_pair:
                    key, value = env_pair.split('=', 1)
                    env_dict[key] = value
            kwargs['env'] = env_dict
        
        manager.update_server(args.name, **kwargs)
    
    elif args.command == 'test':
        manager.test_server(args.name)
    
    elif args.command == 'validate':
        manager.validate_config()
    
    elif args.command == 'export':
        manager.export_config(args.output)
    
    elif args.command == 'import':
        manager.import_config(args.file, merge=not args.replace)
    
    elif args.command == 'registry':
        manager.show_registry()
    
    else:
        parser.print_help()

if __name__ == "__main__":
    main()