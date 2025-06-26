# GitHub MCP Server

The GitHub MCP server enables Claude Code to interact with GitHub repositories, issues, pull requests, and workflows directly.

## Installation

```bash
npm install -g @modelcontextprotocol/server-github
```

## Configuration

Add to your `~/.claude/claude.json`:

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    }
  }
}
```

## Authentication Setup

### 1. Create Personal Access Token

1. Go to [GitHub Settings > Developer settings > Personal access tokens](https://github.com/settings/tokens)
2. Click "Generate new token (classic)"
3. Select scopes based on your needs:
   - `repo` - Full repository access
   - `read:org` - Read organization data
   - `workflow` - Update GitHub Actions workflows
   - `admin:repo_hook` - Manage repository webhooks

### 2. Set Environment Variable

```bash
export GITHUB_TOKEN="ghp_your-token-here"
```

Add to your shell profile to make permanent.

### 3. Verify Connection

```
Claude, can you list my GitHub repositories?
```

## Repository Operations

### Repository Information

```
Show me details about my repository 'my-project'
```

```
List all repositories in my organization
```

```
What's the latest commit in the main branch of 'user/repo'?
```

```
Show repository statistics for 'owner/repository'
```

### Repository Management

```
Create a new repository called 'new-project' with description 'My awesome project'
```

```
Fork the repository 'original-owner/repo' to my account
```

```
Update the description of my repository 'my-repo'
```

## Issue Management

### Viewing Issues

```
List all open issues in 'owner/repo'
```

```
Show me issues assigned to me across all repositories
```

```
Find issues labeled 'bug' in my project
```

```
Show details of issue #123 in 'owner/repo'
```

### Creating Issues

```
Create a new issue in 'my-project':
Title: "Add user authentication"
Description: "Need to implement JWT-based authentication system"
Labels: ["feature", "priority-high"]
```

```
Create a bug report for the login issue:
- Title: Login fails with special characters
- Steps to reproduce
- Expected vs actual behavior
- Environment details
```

### Issue Updates

```
Add a comment to issue #456 in 'owner/repo':
"I've investigated this and found the root cause is in the validation logic"
```

```
Close issue #123 with a comment explaining the resolution
```

```
Add labels ["bug", "urgent"] to issue #789
```

## Pull Request Operations

### Viewing Pull Requests

```
List all open pull requests in 'owner/repo'
```

```
Show me pull requests that need my review
```

```
Get details of pull request #45 including changed files
```

```
Show the diff for pull request #67
```

### Creating Pull Requests

```
Create a pull request:
- From: feature/user-auth
- To: main
- Title: "Add user authentication system"
- Description: "Implements JWT authentication with login/logout"
```

```
Create a draft pull request for my current branch with:
- Summary of changes
- Testing instructions
- Breaking changes notes
```

### PR Reviews

```
Review pull request #89 and provide feedback on:
- Code quality
- Security concerns
- Performance impact
- Test coverage
```

```
Approve pull request #45 with comment: "LGTM! Great implementation of the caching layer"
```

```
Request changes on PR #123 with specific feedback about error handling
```

## Branch Operations

### Branch Information

```
List all branches in 'owner/repo'
```

```
Show branches that are ahead/behind main
```

```
Find stale branches that haven't been updated in 30 days
```

### Branch Management

```
Create a new branch 'feature/new-api' from main
```

```
Delete the merged branch 'hotfix/login-bug'
```

```
Compare branches 'feature/auth' and 'main'
```

## File Operations

### Reading Files

```
Show me the README.md from 'owner/repo'
```

```
Get the contents of src/auth.js from the main branch
```

```
Compare the same file across different branches
```

### File History

```
Show the commit history for src/components/Button.jsx
```

```
Who last modified the package.json file?
```

```
Show changes to src/api.js in the last 10 commits
```

## Workflow Operations

### GitHub Actions

```
List all workflows in 'owner/repo'
```

```
Show the status of the latest workflow run
```

```
Get logs for the failed CI workflow
```

```
Trigger a workflow manually with parameters
```

### Workflow Analysis

```
Analyze workflow failures in the last week
```

```
Suggest optimizations for slow CI workflows
```

```
Check if workflows are using outdated actions
```

## Release Management

### Releases

```
List all releases for 'owner/repo'
```

```
Create a new release v2.1.0 with changelog
```

```
Update the release notes for v2.0.0
```

### Tags

```
List all tags in the repository
```

```
Create a new tag v1.5.0 on the current commit
```

```
Delete the tag v1.4.0-beta
```

## Organization Management

### Organization Info

```
Show members of my organization
```

```
List all repositories in the organization
```

```
Show organization settings and permissions
```

### Team Management

```
List teams in my organization
```

```
Add user 'username' to team 'developers'
```

```
Show team permissions for repository access
```

## Advanced Operations

### Repository Analytics

```
Show repository insights for 'owner/repo':
- Traffic statistics
- Clone counts
- Popular content
- Contributor activity
```

```
Analyze commit patterns over the last 6 months
```

```
Find the most active contributors
```

### Security Analysis

```
Check for security vulnerabilities in 'owner/repo'
```

```
Review Dependabot alerts
```

```
Analyze repository security settings
```

### Project Management

```
List GitHub Projects for this repository
```

```
Show project board status
```

```
Move issue #123 to "In Progress" column
```

## Integration Examples

### Development Workflow

```
Help me with my daily GitHub workflow:
1. Check issues assigned to me
2. Review pending pull requests
3. Check CI status for my branches
4. Update project board
```

### Code Review Process

```
Review all open PRs in my repositories and:
1. Prioritize by importance
2. Check if they're ready for review
3. Identify any blocking issues
4. Suggest review assignments
```

### Release Preparation

```
Prepare for release v2.0.0:
1. Generate changelog from commits
2. Check for breaking changes
3. Update version numbers
4. Create release notes
5. Tag the release
```

## Automation Examples

### Issue Triage

```
Triage new issues:
1. Check for duplicates
2. Add appropriate labels
3. Assign to team members
4. Set milestones
```

### PR Management

```
Manage pull requests:
1. Check CI status
2. Request reviews if needed
3. Auto-merge when ready
4. Update related issues
```

## Best Practices

### Token Security

1. **Use minimal permissions** - Only grant necessary scopes
2. **Rotate tokens regularly** - Set expiration dates
3. **Use organization tokens** - For team access
4. **Monitor token usage** - Check audit logs

### API Usage

1. **Respect rate limits** - GitHub API has limits
2. **Cache responses** - Avoid repeated calls
3. **Use webhooks** - For real-time updates
4. **Batch operations** - When possible

### Repository Organization

1. **Use consistent naming** - For repositories and branches
2. **Leverage templates** - For issues and PRs
3. **Automate workflows** - Use GitHub Actions
4. **Document processes** - In repository wikis

## Troubleshooting

### Common Issues

**Authentication Failed:**
```
Error: Bad credentials

Solutions:
1. Check token is correct
2. Verify token hasn't expired
3. Ensure required scopes are granted
```

**Rate Limit Exceeded:**
```
Error: API rate limit exceeded

Solutions:
1. Wait for rate limit reset
2. Use authenticated requests
3. Implement request caching
```

**Permission Denied:**
```
Error: Not Found (often means no permission)

Solutions:
1. Check repository access
2. Verify token scopes
3. Confirm repository exists
```

### Debug Commands

```bash
# Test token
curl -H "Authorization: token YOUR_TOKEN" https://api.github.com/user

# Check rate limit
curl -H "Authorization: token YOUR_TOKEN" https://api.github.com/rate_limit
```

## Resources

- [GitHub REST API Documentation](https://docs.github.com/en/rest)
- [GitHub GraphQL API](https://docs.github.com/en/graphql)
- [Personal Access Tokens](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)
- [GitHub CLI](https://cli.github.com/)