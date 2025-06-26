# GitHub Actions Integration

Integrate Claude Code into your CI/CD pipelines with GitHub Actions for automated code review, testing, and quality assurance.

## Basic Workflow

### Simple Code Review Action

**.github/workflows/claude-review.yml:**
```yaml
name: Claude Code Review

on:
  pull_request:
    types: [opened, synchronize]
  push:
    branches: [main, develop]

jobs:
  claude-review:
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
        with:
          fetch-depth: 0
      
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'
          cache: 'npm'
      
      - name: Install Claude Code
        run: npm install -g @anthropic-ai/claude-code
      
      - name: Review changed files
        env:
          ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
        run: |
          # Get changed files
          CHANGED_FILES=$(git diff --name-only HEAD^ HEAD | grep -E '\.(js|jsx|ts|tsx|py|md)$' | head -10)
          
          if [ -n "$CHANGED_FILES" ]; then
            echo "Reviewing changed files with Claude..."
            for file in $CHANGED_FILES; do
              echo "Reviewing $file..."
              claude review "$file" --format json >> review-results.json
            done
          else
            echo "No relevant files changed"
          fi
      
      - name: Comment on PR
        if: github.event_name == 'pull_request'
        uses: actions/github-script@v7
        with:
          script: |
            const fs = require('fs');
            
            try {
              const reviewResults = fs.readFileSync('review-results.json', 'utf8');
              const results = reviewResults.split('\n').filter(line => line.trim()).map(line => JSON.parse(line));
              
              let comment = '## Claude Code Review\n\n';
              
              if (results.length === 0) {
                comment += '✅ No issues found by Claude Code review.';
              } else {
                results.forEach(result => {
                  if (result.issues && result.issues.length > 0) {
                    comment += `### ${result.file}\n\n`;
                    result.issues.forEach(issue => {
                      comment += `- **${issue.severity}**: ${issue.message}\n`;
                      if (issue.line) comment += `  - Line ${issue.line}\n`;
                    });
                    comment += '\n';
                  }
                });
              }
              
              await github.rest.issues.createComment({
                issue_number: context.issue.number,
                owner: context.repo.owner,
                repo: context.repo.repo,
                body: comment
              });
            } catch (error) {
              console.log('No review results found or error parsing results');
            }
```

## Advanced Workflows

### Comprehensive Quality Check

**.github/workflows/claude-quality.yml:**
```yaml
name: Claude Quality Check

on:
  pull_request:
    types: [opened, synchronize, ready_for_review]
  
jobs:
  quality-check:
    runs-on: ubuntu-latest
    if: github.event.pull_request.draft == false
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
        with:
          fetch-depth: 0
      
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'
          cache: 'npm'
      
      - name: Install dependencies
        run: |
          npm ci
          npm install -g @anthropic-ai/claude-code
      
      - name: Configure Claude
        env:
          ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
        run: |
          mkdir -p ~/.claude
          cat > ~/.claude/claude.json << EOF
          {
            "mcpServers": {
              "filesystem": {
                "command": "npx",
                "args": ["-y", "@modelcontextprotocol/server-filesystem", "$GITHUB_WORKSPACE"]
              }
            },
            "settings": {
              "verboseLogging": false
            }
          }
          EOF
      
      - name: Run comprehensive review
        env:
          ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
        run: |
          # Get changed files
          CHANGED_FILES=$(git diff --name-only origin/${{ github.base_ref }}..HEAD | grep -E '\.(js|jsx|ts|tsx|py)$')
          
          if [ -n "$CHANGED_FILES" ]; then
            echo "Running comprehensive Claude review..."
            
            # Security review
            echo "Security Review:" > security-review.md
            for file in $CHANGED_FILES; do
              claude review "$file" --focus security --format markdown >> security-review.md
            done
            
            # Performance review
            echo "Performance Review:" > performance-review.md
            for file in $CHANGED_FILES; do
              claude review "$file" --focus performance --format markdown >> performance-review.md
            done
            
            # Code quality review
            echo "Code Quality Review:" > quality-review.md
            for file in $CHANGED_FILES; do
              claude review "$file" --focus quality --format markdown >> quality-review.md
            done
            
            # Generate tests
            echo "Test Generation:" > test-suggestions.md
            for file in $CHANGED_FILES; do
              claude generate-tests "$file" --format markdown >> test-suggestions.md
            done
          fi
      
      - name: Upload review artifacts
        uses: actions/upload-artifact@v4
        with:
          name: claude-review-results
          path: |
            security-review.md
            performance-review.md
            quality-review.md
            test-suggestions.md
          retention-days: 30
      
      - name: Create comprehensive PR comment
        if: github.event_name == 'pull_request'
        uses: actions/github-script@v7
        with:
          script: |
            const fs = require('fs');
            
            let comment = '## 🤖 Claude Code Review Results\n\n';
            
            // Read review files
            const reviewFiles = [
              { name: 'Security Review', file: 'security-review.md', icon: '🔒' },
              { name: 'Performance Review', file: 'performance-review.md', icon: '⚡' },
              { name: 'Code Quality Review', file: 'quality-review.md', icon: '✨' },
              { name: 'Test Suggestions', file: 'test-suggestions.md', icon: '🧪' }
            ];
            
            for (const review of reviewFiles) {
              try {
                const content = fs.readFileSync(review.file, 'utf8');
                if (content.trim().length > review.name.length + 1) {
                  comment += `### ${review.icon} ${review.name}\n\n`;
                  comment += '<details>\n<summary>View details</summary>\n\n';
                  comment += content + '\n\n';
                  comment += '</details>\n\n';
                }
              } catch (error) {
                console.log(`Could not read ${review.file}`);
              }
            }
            
            comment += '\n---\n*Generated by Claude Code in GitHub Actions*';
            
            await github.rest.issues.createComment({
              issue_number: context.issue.number,
              owner: context.repo.owner,
              repo: context.repo.repo,
              body: comment
            });
```

### Security Focused Review

**.github/workflows/claude-security.yml:**
```yaml
name: Claude Security Review

on:
  pull_request:
    paths:
      - '**/*.js'
      - '**/*.jsx'
      - '**/*.ts'
      - '**/*.tsx'
      - '**/*.py'
      - '**/*.java'
      - '**/*.go'

jobs:
  security-review:
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
        with:
          fetch-depth: 0
      
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'
      
      - name: Install Claude Code
        run: npm install -g @anthropic-ai/claude-code
      
      - name: Security review
        env:
          ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
        run: |
          # Get changed files
          CHANGED_FILES=$(git diff --name-only HEAD^ HEAD | grep -E '\.(js|jsx|ts|tsx|py|java|go)$')
          
          if [ -n "$CHANGED_FILES" ]; then
            echo "# Security Review Results" > security-report.md
            echo "" >> security-report.md
            
            for file in $CHANGED_FILES; do
              echo "## $file" >> security-report.md
              echo "" >> security-report.md
              
              # Run security-focused review
              claude review "$file" \
                --prompt "Analyze this code for security vulnerabilities including:
                - SQL injection
                - XSS vulnerabilities  
                - Authentication bypasses
                - Authorization issues
                - Input validation problems
                - Cryptographic weaknesses
                - Dependency vulnerabilities
                - Information disclosure" \
                --format markdown >> security-report.md
              
              echo "" >> security-report.md
            done
          fi
      
      - name: Check for critical issues
        run: |
          if grep -i "critical\|high severity\|vulnerability" security-report.md; then
            echo "::error::Critical security issues found!"
            exit 1
          fi
      
      - name: Upload security report
        uses: actions/upload-artifact@v4
        with:
          name: security-report
          path: security-report.md
      
      - name: Comment security findings
        if: github.event_name == 'pull_request'
        uses: actions/github-script@v7
        with:
          script: |
            const fs = require('fs');
            
            try {
              const securityReport = fs.readFileSync('security-report.md', 'utf8');
              
              const comment = `## 🔒 Security Review
              
              <details>
              <summary>Claude Security Analysis</summary>
              
              ${securityReport}
              
              </details>
              
              ---
              *Automated security review by Claude Code*`;
              
              await github.rest.issues.createComment({
                issue_number: context.issue.number,
                owner: context.repo.owner,
                repo: context.repo.repo,
                body: comment
              });
            } catch (error) {
              console.log('No security report found');
            }
```

## Test Generation Workflow

**.github/workflows/claude-tests.yml:**
```yaml
name: Claude Test Generation

on:
  pull_request:
    types: [labeled]
  workflow_dispatch:
    inputs:
      target_files:
        description: 'Files to generate tests for (space-separated)'
        required: false

jobs:
  generate-tests:
    runs-on: ubuntu-latest
    if: contains(github.event.label.name, 'generate-tests') || github.event_name == 'workflow_dispatch'
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
        with:
          token: ${{ secrets.GITHUB_TOKEN }}
          fetch-depth: 0
      
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'
          cache: 'npm'
      
      - name: Install dependencies
        run: |
          npm ci
          npm install -g @anthropic-ai/claude-code
      
      - name: Generate tests
        env:
          ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
        run: |
          # Get target files
          if [ "${{ github.event_name }}" = "workflow_dispatch" ] && [ -n "${{ github.event.inputs.target_files }}" ]; then
            TARGET_FILES="${{ github.event.inputs.target_files }}"
          else
            TARGET_FILES=$(git diff --name-only HEAD^ HEAD | grep -E '\.(js|jsx|ts|tsx)$' | grep -v test | grep -v spec)
          fi
          
          if [ -n "$TARGET_FILES" ]; then
            echo "Generating tests for: $TARGET_FILES"
            
            for file in $TARGET_FILES; do
              # Skip if test file already exists
              test_file="${file%.*}.test.${file##*.}"
              if [ ! -f "$test_file" ]; then
                echo "Generating test for $file..."
                
                claude generate-tests "$file" \
                  --framework jest \
                  --coverage 80 \
                  --output "$test_file"
              fi
            done
            
            # Check if any test files were created
            if git diff --quiet; then
              echo "No new test files generated"
              echo "test_files_created=false" >> $GITHUB_ENV
            else
              echo "test_files_created=true" >> $GITHUB_ENV
            fi
          fi
      
      - name: Run generated tests
        if: env.test_files_created == 'true'
        run: npm test
      
      - name: Create pull request
        if: env.test_files_created == 'true'
        uses: peter-evans/create-pull-request@v5
        with:
          token: ${{ secrets.GITHUB_TOKEN }}
          commit-message: 'test: Add generated tests from Claude Code'
          title: 'Add generated tests for PR #${{ github.event.number }}'
          body: |
            ## Generated Tests
            
            This PR adds test files generated by Claude Code for the changes in PR #${{ github.event.number }}.
            
            ### Generated test files:
            - Review the generated tests for accuracy
            - Modify as needed for your specific use cases
            - Ensure all tests pass before merging
            
            Generated by Claude Code automation.
          branch: add-tests-${{ github.event.number }}
```

## Documentation Generation

**.github/workflows/claude-docs.yml:**
```yaml
name: Claude Documentation

on:
  push:
    branches: [main]
    paths:
      - 'src/**/*.js'
      - 'src/**/*.jsx'
      - 'src/**/*.ts'
      - 'src/**/*.tsx'
  workflow_dispatch:

jobs:
  generate-docs:
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
        with:
          token: ${{ secrets.GITHUB_TOKEN }}
      
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'
          cache: 'npm'
      
      - name: Install dependencies
        run: |
          npm ci
          npm install -g @anthropic-ai/claude-code
      
      - name: Generate documentation
        env:
          ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
        run: |
          echo "# API Documentation" > docs/api.md
          echo "" >> docs/api.md
          echo "Generated on $(date)" >> docs/api.md
          echo "" >> docs/api.md
          
          # Find all source files
          find src -name "*.js" -o -name "*.jsx" -o -name "*.ts" -o -name "*.tsx" | while read file; do
            echo "Generating docs for $file..."
            
            echo "## $file" >> docs/api.md
            echo "" >> docs/api.md
            
            claude document "$file" \
              --format markdown \
              --include-examples \
              --include-params \
              --include-returns >> docs/api.md
            
            echo "" >> docs/api.md
          done
      
      - name: Update README
        env:
          ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
        run: |
          # Generate project overview
          claude analyze-project . \
            --output-format markdown \
            --include-architecture \
            --include-setup \
            --include-usage > README_generated.md
          
          # Merge with existing README if needed
          if [ -f README.md ]; then
            echo "Updating existing README..."
          else
            mv README_generated.md README.md
          fi
      
      - name: Commit documentation
        run: |
          git config --local user.email "action@github.com"
          git config --local user.name "GitHub Action"
          git add docs/ README.md
          
          if git diff --staged --quiet; then
            echo "No documentation changes"
          else
            git commit -m "docs: Update documentation via Claude Code"
            git push
          fi
```

## Performance Analysis

**.github/workflows/claude-performance.yml:**
```yaml
name: Claude Performance Analysis

on:
  pull_request:
    types: [opened, synchronize]

jobs:
  performance-analysis:
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
        with:
          fetch-depth: 0
      
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'
          cache: 'npm'
      
      - name: Install dependencies
        run: |
          npm ci
          npm install -g @anthropic-ai/claude-code
      
      - name: Performance analysis
        env:
          ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
        run: |
          # Get changed files
          CHANGED_FILES=$(git diff --name-only origin/${{ github.base_ref }}..HEAD | grep -E '\.(js|jsx|ts|tsx)$')
          
          if [ -n "$CHANGED_FILES" ]; then
            echo "# Performance Analysis" > performance-report.md
            echo "" >> performance-report.md
            
            for file in $CHANGED_FILES; do
              echo "## $file" >> performance-report.md
              echo "" >> performance-report.md
              
              claude analyze-performance "$file" \
                --check-complexity \
                --check-memory \
                --check-algorithms \
                --suggest-optimizations \
                --format markdown >> performance-report.md
              
              echo "" >> performance-report.md
            done
          fi
      
      - name: Check performance thresholds
        run: |
          # Check for performance issues
          if grep -i "high complexity\|memory leak\|inefficient" performance-report.md; then
            echo "::warning::Performance issues detected"
          fi
      
      - name: Comment performance analysis
        if: github.event_name == 'pull_request'
        uses: actions/github-script@v7
        with:
          script: |
            const fs = require('fs');
            
            try {
              const performanceReport = fs.readFileSync('performance-report.md', 'utf8');
              
              const comment = `## ⚡ Performance Analysis
              
              <details>
              <summary>Claude Performance Review</summary>
              
              ${performanceReport}
              
              </details>
              
              ---
              *Automated performance analysis by Claude Code*`;
              
              await github.rest.issues.createComment({
                issue_number: context.issue.number,
                owner: context.repo.owner,
                repo: context.repo.repo,
                body: comment
              });
            } catch (error) {
              console.log('No performance report found');
            }
```

## Secrets and Configuration

### Required Secrets

Set these in your repository settings:

```bash
# GitHub Settings > Secrets and variables > Actions

ANTHROPIC_API_KEY=sk-ant-your-key-here
```

### Optional Secrets

```bash
# For advanced integrations
GITHUB_TOKEN=ghp_your-token-here  # Usually auto-provided
SLACK_WEBHOOK_URL=https://hooks.slack.com/...  # For notifications
DISCORD_WEBHOOK_URL=https://discord.com/api/webhooks/...
```

## Custom Actions

### Reusable Claude Action

**.github/actions/claude-review/action.yml:**
```yaml
name: 'Claude Code Review'
description: 'Run Claude Code review on specified files'

inputs:
  files:
    description: 'Files to review (space-separated)'
    required: true
  focus:
    description: 'Review focus area'
    required: false
    default: 'general'
  format:
    description: 'Output format'
    required: false
    default: 'markdown'

outputs:
  review-results:
    description: 'Path to review results file'
    value: ${{ steps.review.outputs.results-file }}

runs:
  using: 'composite'
  steps:
    - name: Install Claude Code
      shell: bash
      run: npm install -g @anthropic-ai/claude-code
    
    - name: Run review
      id: review
      shell: bash
      env:
        ANTHROPIC_API_KEY: ${{ env.ANTHROPIC_API_KEY }}
      run: |
        RESULTS_FILE="claude-review-$(date +%s).md"
        
        for file in ${{ inputs.files }}; do
          echo "Reviewing $file..."
          claude review "$file" \
            --focus ${{ inputs.focus }} \
            --format ${{ inputs.format }} >> "$RESULTS_FILE"
        done
        
        echo "results-file=$RESULTS_FILE" >> $GITHUB_OUTPUT
```

### Usage of Custom Action

```yaml
jobs:
  review:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Review with Claude
        uses: ./.github/actions/claude-review
        env:
          ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
        with:
          files: 'src/auth.js src/api.js'
          focus: 'security'
          format: 'json'
```

## Workflow Templates

### Minimal Setup

**.github/workflows/claude-minimal.yml:**
```yaml
name: Claude Review

on:
  pull_request:

jobs:
  review:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '18'
      - run: npm install -g @anthropic-ai/claude-code
      - env:
          ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
        run: |
          claude review $(git diff --name-only HEAD^ HEAD | grep -E '\.(js|jsx|ts|tsx)$' | head -5)
```

## Best Practices

1. **API Key Security** - Always use GitHub Secrets for API keys
2. **Rate Limiting** - Limit file reviews to avoid API limits
3. **Conditional Execution** - Only run on relevant file changes
4. **Artifact Storage** - Store review results for later reference
5. **PR Comments** - Provide actionable feedback in PR comments
6. **Parallel Jobs** - Use matrix strategies for large repositories
7. **Caching** - Cache dependencies for faster workflows
8. **Error Handling** - Handle API failures gracefully

## Troubleshooting

### Common Issues

**API rate limits:**
```yaml
- name: Handle rate limits
  if: failure()
  run: |
    echo "API rate limit reached, skipping review"
    exit 0
```

**Large file handling:**
```yaml
- name: Filter large files
  run: |
    CHANGED_FILES=$(git diff --name-only HEAD^ HEAD | grep -E '\.(js|jsx|ts|tsx)$' | head -10)
```

**Authentication issues:**
```yaml
- name: Verify API key
  env:
    ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
  run: |
    if [ -z "$ANTHROPIC_API_KEY" ]; then
      echo "::error::ANTHROPIC_API_KEY secret not set"
      exit 1
    fi
```

## Resources

- [GitHub Actions Documentation](https://docs.github.com/actions)
- [GitHub Actions Marketplace](https://github.com/marketplace?type=actions)
- [Workflow Syntax](https://docs.github.com/actions/using-workflows/workflow-syntax-for-github-actions)
- [Secrets Management](https://docs.github.com/actions/security-guides/encrypted-secrets)