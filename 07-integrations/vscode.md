# VS Code Integration

Integrate Claude Code with Visual Studio Code for a seamless development experience using extensions, settings, and workflows.

## Official Claude Code Extension

### Installation

1. Open VS Code
2. Go to Extensions (Ctrl+Shift+X)
3. Search for "Claude Code"
4. Install the official Anthropic extension
5. Reload VS Code

### Features

- **Inline Code Assistance** - Get help directly in the editor
- **File Context Awareness** - Claude understands your current file
- **Project Integration** - Automatic project configuration detection
- **Terminal Integration** - Run Claude Code commands from VS Code terminal
- **Settings Sync** - Synchronize Claude Code settings with VS Code

## Extension Configuration

### Basic Settings

**settings.json:**
```json
{
  "claude.apiKey": "${ANTHROPIC_API_KEY}",
  "claude.model": "claude-3-5-sonnet-20241022",
  "claude.configPath": ".claude/claude.json",
  "claude.autostart": true,
  "claude.enableInlineHelp": true,
  "claude.enableContextAwareness": true
}
```

### Advanced Settings

```json
{
  "claude.apiKey": "${ANTHROPIC_API_KEY}",
  "claude.model": "claude-3-5-sonnet-20241022",
  "claude.maxTokens": 4096,
  "claude.temperature": 0.1,
  "claude.configPath": ".claude/claude.json",
  "claude.autostart": true,
  "claude.enableInlineHelp": true,
  "claude.enableContextAwareness": true,
  "claude.fileExtensions": [".js", ".jsx", ".ts", ".tsx", ".py", ".md"],
  "claude.excludePatterns": ["node_modules/**", "dist/**", ".git/**"],
  "claude.keyboardShortcuts": {
    "askClaude": "Ctrl+Shift+C",
    "explainCode": "Ctrl+Shift+E",
    "reviewCode": "Ctrl+Shift+R",
    "generateTests": "Ctrl+Shift+T"
  },
  "claude.ui": {
    "showInlineSuggestions": true,
    "showInStatusBar": true,
    "sidebarPosition": "right"
  }
}
```

## Workspace Configuration

### Project-specific Settings

**.vscode/settings.json:**
```json
{
  "claude.configPath": ".claude/claude.json",
  "claude.projectContext": true,
  "claude.codeStyle": {
    "formatter": "prettier",
    "linter": "eslint",
    "tabSize": 2
  },
  "claude.autoCommands": {
    "onSave": ["format", "lint"],
    "onFileOpen": ["loadContext"]
  },
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": true
  }
}
```

### Launch Configuration

**.vscode/launch.json:**
```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Claude Code Debug",
      "type": "node",
      "request": "launch",
      "program": "${workspaceFolder}/node_modules/@anthropic-ai/claude-code/bin/claude",
      "args": ["--debug"],
      "env": {
        "DEBUG": "claude:*",
        "ANTHROPIC_API_KEY": "${env:ANTHROPIC_API_KEY}"
      }
    }
  ]
}
```

### Tasks Configuration

**.vscode/tasks.json:**
```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Claude: Code Review",
      "type": "shell",
      "command": "claude",
      "args": ["review", "${file}"],
      "group": "build",
      "presentation": {
        "echo": true,
        "reveal": "always",
        "focus": false,
        "panel": "shared"
      }
    },
    {
      "label": "Claude: Generate Tests",
      "type": "shell",
      "command": "claude",
      "args": ["test", "${file}"],
      "group": "test"
    },
    {
      "label": "Claude: Explain Code",
      "type": "shell",
      "command": "claude",
      "args": ["explain", "${file}"],
      "group": "build"
    },
    {
      "label": "Claude: Refactor",
      "type": "shell",
      "command": "claude",
      "args": ["refactor", "${file}"],
      "group": "build"
    }
  ]
}
```

## Keyboard Shortcuts

### Default Shortcuts

**.vscode/keybindings.json:**
```json
[
  {
    "key": "ctrl+shift+c",
    "command": "claude.askQuestion",
    "when": "editorTextFocus"
  },
  {
    "key": "ctrl+shift+e",
    "command": "claude.explainCode",
    "when": "editorHasSelection"
  },
  {
    "key": "ctrl+shift+r",
    "command": "claude.reviewCode",
    "when": "editorTextFocus"
  },
  {
    "key": "ctrl+shift+t",
    "command": "claude.generateTests",
    "when": "editorTextFocus"
  },
  {
    "key": "ctrl+shift+d",
    "command": "claude.generateDocs",
    "when": "editorTextFocus"
  },
  {
    "key": "ctrl+shift+f",
    "command": "claude.fixCode",
    "when": "editorHasSelection"
  }
]
```

### Custom Shortcuts

```json
[
  {
    "key": "alt+c alt+r",
    "command": "claude.reviewCode",
    "when": "editorTextFocus",
    "args": {
      "focus": "security"
    }
  },
  {
    "key": "alt+c alt+p",
    "command": "claude.reviewCode",
    "when": "editorTextFocus",
    "args": {
      "focus": "performance"
    }
  },
  {
    "key": "alt+c alt+t",
    "command": "claude.generateTests",
    "when": "editorTextFocus",
    "args": {
      "testType": "unit"
    }
  }
]
```

## Snippets Integration

### Custom Snippets

**.vscode/snippets/claude.code-snippets:**
```json
{
  "Claude Code Review": {
    "prefix": "claude-review",
    "body": [
      "// Claude Code Review Request",
      "// Focus: ${1|security,performance,maintainability,all|}",
      "// File: ${TM_FILENAME}",
      "// Description: $2",
      "",
      "$0"
    ],
    "description": "Request Claude code review"
  },
  "Claude Test Generation": {
    "prefix": "claude-test",
    "body": [
      "// Claude Test Generation",
      "// Test Type: ${1|unit,integration,e2e|}",
      "// Function: $2",
      "// Requirements: $3",
      "",
      "$0"
    ],
    "description": "Request Claude test generation"
  },
  "Claude Documentation": {
    "prefix": "claude-docs",
    "body": [
      "/**",
      " * Claude Documentation Request",
      " * Function: $1",
      " * Purpose: $2",
      " * Parameters: $3",
      " * Returns: $4",
      " */",
      "$0"
    ],
    "description": "Request Claude documentation"
  }
}
```

## Command Palette Integration

### Custom Commands

**package.json (for extension development):**
```json
{
  "contributes": {
    "commands": [
      {
        "command": "claude.reviewCurrentFile",
        "title": "Claude: Review Current File"
      },
      {
        "command": "claude.explainSelection",
        "title": "Claude: Explain Selection"
      },
      {
        "command": "claude.generateTests",
        "title": "Claude: Generate Tests"
      },
      {
        "command": "claude.optimizeCode",
        "title": "Claude: Optimize Code"
      },
      {
        "command": "claude.addDocumentation",
        "title": "Claude: Add Documentation"
      }
    ],
    "menus": {
      "editor/context": [
        {
          "command": "claude.explainSelection",
          "when": "editorHasSelection",
          "group": "claude"
        },
        {
          "command": "claude.reviewCurrentFile",
          "when": "editorTextFocus",
          "group": "claude"
        }
      ]
    }
  }
}
```

## Terminal Integration

### Integrated Terminal Setup

**settings.json:**
```json
{
  "terminal.integrated.profiles.linux": {
    "claude": {
      "path": "/bin/bash",
      "args": ["-c", "export PATH=$PATH:~/.npm-global/bin && claude"],
      "icon": "robot"
    }
  },
  "terminal.integrated.defaultProfile.linux": "claude",
  "terminal.integrated.env.linux": {
    "ANTHROPIC_API_KEY": "${env:ANTHROPIC_API_KEY}",
    "CLAUDE_CONFIG_PATH": "${workspaceFolder}/.claude/claude.json"
  }
}
```

### Terminal Commands

```bash
# Quick access to Claude from VS Code terminal
alias cr="claude review"
alias ct="claude test"
alias ce="claude explain"
alias cf="claude fix"

# Context-aware commands
alias crf="claude review \$file"
alias ctf="claude test \$file"
alias cef="claude explain \$file"
```

## Debugging Integration

### Debug Configuration

**.vscode/launch.json:**
```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Debug with Claude",
      "type": "node",
      "request": "launch",
      "program": "${workspaceFolder}/src/index.js",
      "env": {
        "DEBUG": "app:*",
        "NODE_ENV": "development"
      },
      "preLaunchTask": "claude:review",
      "postDebugTask": "claude:analyze-logs"
    }
  ]
}
```

### Debug Tasks

**.vscode/tasks.json:**
```json
{
  "tasks": [
    {
      "label": "claude:review",
      "type": "shell",
      "command": "claude",
      "args": ["review", "${workspaceFolder}/src", "--format", "json"],
      "group": "build",
      "presentation": {
        "reveal": "silent"
      }
    },
    {
      "label": "claude:analyze-logs",
      "type": "shell",
      "command": "claude",
      "args": ["analyze", "debug.log"],
      "group": "test"
    }
  ]
}
```

## Extension Development

### Creating a Custom Extension

**extension.js:**
```javascript
const vscode = require('vscode');
const { exec } = require('child_process');

function activate(context) {
    // Register Claude review command
    let reviewCommand = vscode.commands.registerCommand('claude.reviewCode', async () => {
        const editor = vscode.window.activeTextEditor;
        if (!editor) return;

        const document = editor.document;
        const filePath = document.fileName;
        
        // Run Claude Code review
        exec(`claude review "${filePath}"`, (error, stdout, stderr) => {
            if (error) {
                vscode.window.showErrorMessage(`Claude Error: ${error.message}`);
                return;
            }
            
            // Show results in output panel
            const channel = vscode.window.createOutputChannel('Claude Code');
            channel.clear();
            channel.appendLine(stdout);
            channel.show();
        });
    });

    // Register explain command
    let explainCommand = vscode.commands.registerCommand('claude.explainCode', async () => {
        const editor = vscode.window.activeTextEditor;
        if (!editor) return;

        const selection = editor.selection;
        const selectedText = editor.document.getText(selection);
        
        if (!selectedText) {
            vscode.window.showWarningMessage('Please select code to explain');
            return;
        }

        // Create and show webview with explanation
        const panel = vscode.window.createWebviewPanel(
            'claudeExplanation',
            'Claude Code Explanation',
            vscode.ViewColumn.Beside,
            {}
        );

        // Get explanation from Claude
        exec(`claude explain --input "${selectedText}"`, (error, stdout, stderr) => {
            if (error) {
                panel.webview.html = `<h3>Error</h3><p>${error.message}</p>`;
                return;
            }
            
            panel.webview.html = `
                <h3>Code Explanation</h3>
                <pre><code>${selectedText}</code></pre>
                <div>${stdout}</div>
            `;
        });
    });

    context.subscriptions.push(reviewCommand, explainCommand);
}

module.exports = { activate };
```

### Extension Configuration

**package.json:**
```json
{
  "name": "claude-code-integration",
  "displayName": "Claude Code Integration",
  "description": "Enhanced VS Code integration for Claude Code",
  "version": "1.0.0",
  "engines": {
    "vscode": "^1.60.0"
  },
  "categories": ["Other"],
  "activationEvents": [
    "onCommand:claude.reviewCode",
    "onCommand:claude.explainCode"
  ],
  "main": "./extension.js",
  "contributes": {
    "commands": [
      {
        "command": "claude.reviewCode",
        "title": "Review with Claude"
      },
      {
        "command": "claude.explainCode",
        "title": "Explain with Claude"
      }
    ],
    "configuration": {
      "title": "Claude Code",
      "properties": {
        "claude.apiKey": {
          "type": "string",
          "description": "Anthropic API Key"
        },
        "claude.model": {
          "type": "string",
          "default": "claude-3-5-sonnet-20241022",
          "description": "Claude model to use"
        }
      }
    }
  }
}
```

## Git Integration

### Pre-commit Hooks with Claude

**.git/hooks/pre-commit:**
```bash
#!/bin/bash

# Run Claude Code review on changed files
changed_files=$(git diff --cached --name-only --diff-filter=ACM | grep -E '\.(js|jsx|ts|tsx|py)$')

if [ -n "$changed_files" ]; then
    echo "Running Claude Code review on changed files..."
    
    for file in $changed_files; do
        echo "Reviewing $file..."
        claude review "$file" --format json > /tmp/claude-review.json
        
        # Check if review found issues
        if jq -e '.issues | length > 0' /tmp/claude-review.json > /dev/null; then
            echo "Claude found issues in $file:"
            jq -r '.issues[].message' /tmp/claude-review.json
            echo "Please fix these issues before committing."
            exit 1
        fi
    done
fi

echo "Claude Code review passed!"
```

### Commit Message Generation

**.vscode/tasks.json:**
```json
{
  "tasks": [
    {
      "label": "Generate Commit Message",
      "type": "shell",
      "command": "claude",
      "args": [
        "generate-commit-message",
        "--changes", "$(git diff --cached)"
      ],
      "group": "build",
      "presentation": {
        "echo": true,
        "reveal": "always"
      }
    }
  ]
}
```

## Workspace Templates

### Project Template

**.vscode/settings.json template:**
```json
{
  "claude.configPath": ".claude/claude.json",
  "claude.autostart": true,
  "claude.projectContext": true,
  "claude.codeStyle": {
    "framework": "${framework}",
    "linter": "${linter}",
    "formatter": "${formatter}"
  },
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": true
  },
  "files.exclude": {
    "**/node_modules": true,
    "**/dist": true,
    "**/.git": true
  },
  "search.exclude": {
    "**/node_modules": true,
    "**/dist": true
  }
}
```

## Troubleshooting

### Common Issues

**Extension not loading:**
```bash
# Check VS Code logs
code --log debug

# Verify extension installation
code --list-extensions | grep claude
```

**Claude commands not found:**
```bash
# Check PATH in VS Code terminal
echo $PATH

# Verify Claude installation
which claude
claude --version
```

**Configuration not loading:**
```bash
# Verify configuration file
claude config validate

# Check VS Code settings
code --list-extensions --show-versions
```

### Debug Mode

**settings.json:**
```json
{
  "claude.debug": true,
  "claude.logLevel": "debug",
  "developer.reload": true
}
```

## Best Practices

1. **Consistent Configuration** - Use workspace settings for team consistency
2. **Keyboard Shortcuts** - Set up efficient shortcuts for common tasks
3. **Context Awareness** - Configure Claude to understand your project structure
4. **Git Integration** - Use Claude in pre-commit hooks and workflows
5. **Extension Updates** - Keep Claude Code extension updated
6. **Performance** - Exclude unnecessary files from Claude context
7. **Security** - Don't commit API keys in workspace settings
8. **Team Sharing** - Share workspace configuration with team

## Resources

- [VS Code Extension API](https://code.visualstudio.com/api)
- [VS Code Settings Reference](https://code.visualstudio.com/docs/getstarted/settings)
- [VS Code Keybindings](https://code.visualstudio.com/docs/getstarted/keybindings)
- [VS Code Tasks](https://code.visualstudio.com/docs/editor/tasks)