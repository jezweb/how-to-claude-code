# Creating Custom Commands

Create reusable custom commands for Claude Code to standardize workflows and improve team productivity.

## Command Structure

### Basic Command Format

Custom commands are markdown files with YAML frontmatter:

```markdown
---
name: command-name
description: Brief description of what the command does
version: 1.0.0
author: Your Name
category: development
tags: [review, security, performance]
---

# Command Implementation

Your command instructions and prompts go here.
```

## Command Metadata

### Required Fields

```yaml
---
name: code-review
description: Comprehensive code review with security focus
---
```

### Optional Fields

```yaml
---
name: code-review
description: Comprehensive code review with security focus
version: 1.2.0
author: Development Team
category: quality-assurance
tags: [review, security, performance, maintainability]
aliases: [review, cr]
usage: "claude code-review <file> [--focus=security|performance|all]"
examples:
  - "claude code-review src/auth.js --focus=security"
  - "claude code-review . --focus=all"
parameters:
  - name: file
    type: string
    required: true
    description: File or directory to review
  - name: focus
    type: string
    required: false
    default: all
    choices: [security, performance, maintainability, all]
    description: Focus area for the review
prerequisites:
  - Node.js project
  - ESLint configuration
conditions:
  - file_exists: "package.json"
  - not_empty: "{file}"
---
```

## Parameter Handling

### Basic Parameters

```yaml
---
name: generate-component
description: Generate React component with tests
parameters:
  - name: name
    type: string
    required: true
    description: Component name in PascalCase
  - name: props
    type: array
    required: false
    description: Component props as key:type pairs
  - name: has_children
    type: boolean
    required: false
    default: false
    description: Whether component accepts children
---

# Generate React Component

Create a React component named **{name}** with the following specifications:

## Component Details
- **Name**: {name}
- **Props**: {props}
- **Children**: {has_children}

## Requirements
- Use TypeScript interfaces for props
- Include PropTypes for runtime validation
- Add JSDoc comments
- Create accompanying test file
- Follow project naming conventions

{if has_children}
## Children Support
This component should accept and render children props.
{endif}

{if props}
## Props Interface
```typescript
interface {name}Props {
  {for prop in props}
  {prop.key}: {prop.type};
  {endfor}
}
```
{endif}
```

### Parameter Types

```yaml
parameters:
  - name: string_param
    type: string
    required: true
    pattern: "^[A-Za-z][A-Za-z0-9]*$"
    
  - name: number_param
    type: number
    required: false
    min: 1
    max: 100
    default: 10
    
  - name: boolean_param
    type: boolean
    required: false
    default: false
    
  - name: choice_param
    type: string
    required: true
    choices: [option1, option2, option3]
    
  - name: array_param
    type: array
    required: false
    item_type: string
    
  - name: file_param
    type: file
    required: true
    extensions: [.js, .jsx, .ts, .tsx]
    must_exist: true
```

## Template Variables

### Basic Substitution

```markdown
# Review File: {file}

Analyze **{file}** focusing on {focus} aspects.

## Context
- Project: {project_name}
- Framework: {framework}
- Last modified: {file_modified_date}
```

### Conditional Content

```markdown
{if focus == "security"}
## Security Review Checklist
- [ ] Input validation
- [ ] Authentication checks
- [ ] Authorization verification
- [ ] SQL injection prevention
- [ ] XSS protection
{endif}

{if focus == "performance"}
## Performance Review Checklist
- [ ] Algorithm efficiency
- [ ] Memory usage
- [ ] Database queries
- [ ] Caching strategy
- [ ] Bundle size impact
{endif}

{if framework == "react"}
## React-Specific Checks
- [ ] Hook usage
- [ ] State management
- [ ] Re-render optimization
- [ ] Component composition
{endif}
```

### Loops and Iteration

```markdown
{for file in files}
## Reviewing {file}

{if file.endswith('.test.js')}
This is a test file - checking test coverage and quality.
{else}
This is a source file - checking implementation quality.
{endif}

{endfor}

## File Summary
{for file in files}
- **{file}**: {file.size} bytes, {file.lines} lines
{endfor}
```

## File Operations

### Reading Files

```yaml
---
name: analyze-imports
description: Analyze import statements in JavaScript/TypeScript files
parameters:
  - name: directory
    type: directory
    required: true
    description: Directory to analyze
---

# Import Analysis for {directory}

## File Analysis

{read_files directory="**/*.{js,jsx,ts,tsx}" as files}

{for file in files}
### {file.path}

{read_file file.path as content}

**Import statements:**
{extract_imports content as imports}
{for import in imports}
- `{import.module}` {if import.default}(default){endif} {if import.named}(named: {import.named.join(', ')}){endif}
{endfor}

{endfor}

## Summary
- Total files: {files.length}
- External dependencies: {unique_external_imports.length}
- Internal imports: {unique_internal_imports.length}
```

### File Pattern Matching

```yaml
---
name: update-headers
description: Add/update file headers in source files
parameters:
  - name: pattern
    type: string
    required: true
    description: File pattern to match
  - name: header_text
    type: string
    required: true
    description: Header text to add
---

# Update File Headers

{glob pattern=pattern as matched_files}

{for file in matched_files}
{read_file file as content}

{if not content.startswith("/*")}
**{file}** - Adding header
{write_file file with header_text + "\n" + content}
{else}
**{file}** - Header already exists
{endif}

{endfor}

Updated {modified_files.length} files.
```

## Command Categories

### Code Quality Commands

**.claude/commands/quality/review.md:**
```yaml
---
name: comprehensive-review
description: Multi-aspect code review
category: quality
tags: [review, quality, security, performance]
parameters:
  - name: files
    type: array
    required: true
    item_type: file
---

# Comprehensive Code Review

{for file in files}
## {file}

### Security Analysis
{review file focus="security" format="checklist"}

### Performance Analysis  
{review file focus="performance" format="checklist"}

### Code Quality Analysis
{review file focus="maintainability" format="checklist"}

### Test Coverage
{check_test_coverage file}

---
{endfor}

## Summary
- Files reviewed: {files.length}
- Security issues: {count_issues type="security"}
- Performance issues: {count_issues type="performance"}
- Quality issues: {count_issues type="quality"}
```

### Testing Commands

**.claude/commands/testing/generate-tests.md:**
```yaml
---
name: generate-test-suite
description: Generate comprehensive test suite for a module
category: testing
tags: [testing, automation, quality]
parameters:
  - name: source_file
    type: file
    required: true
    extensions: [.js, .jsx, .ts, .tsx]
  - name: test_type
    type: string
    required: false
    default: unit
    choices: [unit, integration, e2e]
  - name: coverage_target
    type: number
    required: false
    default: 80
    min: 0
    max: 100
---

# Generate Test Suite for {source_file}

{analyze_file source_file as analysis}

## Test Generation Plan

**File**: {source_file}
**Test Type**: {test_type}
**Coverage Target**: {coverage_target}%

### Functions to Test
{for function in analysis.functions}
- `{function.name}` - {function.description}
  - Parameters: {function.parameters.join(', ')}
  - Return type: {function.return_type}
  - Complexity: {function.complexity}
{endfor}

### Classes to Test
{for class in analysis.classes}
- `{class.name}` - {class.description}
  - Methods: {class.methods.length}
  - Properties: {class.properties.length}
{endfor}

## Test File Generation

{if test_type == "unit"}
Generate unit tests focusing on:
- Function behavior
- Edge cases
- Error handling
- Input validation
{endif}

{if test_type == "integration"}
Generate integration tests focusing on:
- Module interactions
- API calls
- Database operations
- External dependencies
{endif}

{if test_type == "e2e"}
Generate end-to-end tests focusing on:
- User workflows
- UI interactions
- Complete feature flows
- Cross-browser compatibility
{endif}

## Expected Test Coverage
Target {coverage_target}% code coverage with emphasis on:
- Critical business logic
- Error paths
- Security-sensitive functions
- Performance-critical sections
```

### Documentation Commands

**.claude/commands/docs/generate-api-docs.md:**
```yaml
---
name: generate-api-docs
description: Generate API documentation from source code
category: documentation
tags: [documentation, api, automation]
parameters:
  - name: api_directory
    type: directory
    required: true
    description: Directory containing API routes
  - name: output_format
    type: string
    required: false
    default: markdown
    choices: [markdown, openapi, html]
  - name: include_examples
    type: boolean
    required: false
    default: true
---

# API Documentation Generation

{scan_directory api_directory pattern="**/*.js" as api_files}

## API Endpoints

{for file in api_files}
{analyze_api_routes file as routes}

{for route in routes}
### {route.method} {route.path}

**Description**: {route.description}

{if route.parameters}
**Parameters**:
{for param in route.parameters}
- `{param.name}` ({param.type}) - {param.description} {if param.required}*required*{endif}
{endfor}
{endif}

{if route.body}
**Request Body**:
```json
{route.body_schema}
```
{endif}

**Response**:
```json
{route.response_schema}
```

{if include_examples}
**Example Request**:
```bash
curl -X {route.method} \\
  {route.example_url} \\
  {if route.headers}
  {for header in route.headers}
  -H "{header.name}: {header.value}" \\
  {endfor}
  {endif}
  {if route.body}
  -d '{route.example_body}'
  {endif}
```

**Example Response**:
```json
{route.example_response}
```
{endif}

---
{endfor}
{endfor}

## Authentication
{extract_auth_info api_directory}

## Rate Limiting
{extract_rate_limits api_directory}

## Error Codes
{extract_error_codes api_directory}
```

## Advanced Features

### Environment Detection

```yaml
---
name: deploy-check
description: Pre-deployment validation
conditions:
  - env_var_exists: "NODE_ENV"
  - file_exists: "package.json"
  - command_exists: "npm"
---

# Deployment Validation

{detect_environment as env}

## Environment: {env.name}

{if env.name == "production"}
## Production Deployment Checks
- [ ] All tests passing
- [ ] Security scan completed
- [ ] Performance benchmarks met
- [ ] Database migrations ready
- [ ] Monitoring configured
{endif}

{if env.name == "staging"}
## Staging Deployment Checks
- [ ] Feature flags configured
- [ ] Test data prepared
- [ ] Integration tests ready
{endif}

{if env.name == "development"}
## Development Environment
- [ ] Local dependencies installed
- [ ] Development server configuration
- [ ] Debug tools enabled
{endif}
```

### Integration with External Tools

```yaml
---
name: security-scan
description: Run security scan and analyze results
category: security
requires:
  - command: "snyk"
    install_hint: "npm install -g snyk"
  - command: "npm audit"
---

# Security Scan Report

## Dependency Vulnerability Scan

{run_command "npm audit --json" as audit_result}
{parse_json audit_result as audit_data}

### Summary
- Total vulnerabilities: {audit_data.metadata.vulnerabilities.total}
- Critical: {audit_data.metadata.vulnerabilities.critical}
- High: {audit_data.metadata.vulnerabilities.high}
- Moderate: {audit_data.metadata.vulnerabilities.moderate}
- Low: {audit_data.metadata.vulnerabilities.low}

{if audit_data.metadata.vulnerabilities.critical > 0}
## ⚠️ Critical Vulnerabilities
{for vuln in audit_data.vulnerabilities where vuln.severity == "critical"}
- **{vuln.title}** in {vuln.module_name}
  - Severity: {vuln.severity}
  - Recommendation: {vuln.recommendation}
{endfor}
{endif}

## Snyk Security Scan

{run_command "snyk test --json" as snyk_result}
{parse_json snyk_result as snyk_data}

{if snyk_data.ok}
✅ No vulnerabilities found by Snyk
{else}
### Snyk Findings
{for issue in snyk_data.vulnerabilities}
- **{issue.title}** ({issue.severity})
  - Package: {issue.packageName}
  - Path: {issue.from.join(' > ')}
  - Fix: {issue.upgrade.join(', ') or "No automatic fix available"}
{endfor}
{endif}
```

## Command Installation

### Local Installation

```bash
# Create command directory
mkdir -p .claude/commands

# Add command file
cat > .claude/commands/my-command.md << 'EOF'
---
name: my-command
description: My custom command
---

# My Custom Command
...
EOF
```

### Global Installation

```bash
# Create global commands directory
mkdir -p ~/.claude/commands

# Install command globally
cp my-command.md ~/.claude/commands/
```

### Team Sharing

```bash
# In project repository
mkdir -p .claude/commands/team
git add .claude/commands/
git commit -m "Add team custom commands"
```

## Command Testing

### Validation

```bash
# Validate command syntax
claude command validate .claude/commands/my-command.md

# Test command execution
claude command test my-command --dry-run

# List available commands
claude command list
```

### Debug Mode

```yaml
---
name: debug-command
description: Command with debug information
debug: true
---

# Debug Command

{debug "Starting command execution"}
{debug "Parameters: " + params}

{for file in files}
{debug "Processing file: " + file}
...
{endfor}

{debug "Command completed"}
```

## Best Practices

1. **Clear Documentation** - Provide detailed descriptions and examples
2. **Parameter Validation** - Use appropriate types and constraints
3. **Error Handling** - Handle edge cases gracefully
4. **Reusability** - Design commands to work in different contexts
5. **Performance** - Consider command execution time
6. **Security** - Validate inputs and handle sensitive data carefully
7. **Testing** - Test commands with various inputs
8. **Versioning** - Use semantic versioning for command updates

## Resources

- [YAML Frontmatter Reference](https://jekyllrb.com/docs/front-matter/)
- [Markdown Template Syntax](https://mustache.github.io/)
- [Command Examples Repository](../examples/)
- [Claude Code CLI Reference](../../10-reference/cli-commands.md)