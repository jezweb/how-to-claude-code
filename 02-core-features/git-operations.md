# Git Operations with Claude Code

Claude Code integrates seamlessly with Git, helping you manage version control, review changes, and maintain a clean commit history.

## Git Status and Information

### Current Status

```
What's the current git status?
```

```
Show me what files have been modified
```

```
What changes are staged for commit?
```

### Recent History

```
Show me the last 5 commits
```

```
What changed in the last commit?
```

```
Who made changes to @src/components/Button.jsx recently?
```

### Branch Information

```
What branch am I on?
```

```
List all branches
```

```
Show me branches that haven't been merged
```

## Reviewing Changes

### Diff Analysis

```
Show me what changed in @src/api/users.js
```

```
Compare my current changes with the last commit
```

```
What are the differences between @src/components/old.jsx and @src/components/new.jsx?
```

### Change Summary

```
Summarize all my current changes
```

```
What files have been added, modified, or deleted?
```

```
Are there any potential breaking changes in my modifications?
```

## Commit Management

### Commit Preparation

```
Stage all my current changes and create a commit
```

```
Only stage changes to @src/components/ and commit those
```

```
Help me write a good commit message for these changes
```

### Commit Messages

Claude can suggest conventional commit messages:

```
Current changes:
- Added user authentication
- Fixed login redirect bug
- Updated API endpoints

Generate a proper commit message.
```

Result:
```
feat: add user authentication system

- Implement JWT-based authentication flow
- Fix login redirect to dashboard
- Update API endpoints for auth validation

Fixes #123
```

### Staging Strategies

```
I've made changes to 10 files. Help me group them into logical commits.
```

```
Stage only the bug fixes, not the new features
```

```
Review my changes and suggest what should be committed together
```

## Branch Management

### Creating Branches

```
Create a new branch called feature/user-profiles
```

```
Create a branch for fixing the authentication bug
```

```
Switch to a new branch called refactor/api-cleanup
```

### Branch Operations

```
Merge the feature/shopping-cart branch into main
```

```
Rebase my current branch onto main
```

```
Cherry-pick commit abc123 into this branch
```

### Branch Cleanup

```
Delete branches that have been merged to main
```

```
Show me stale branches that haven't been updated in 30 days
```

```
Clean up my local branches
```

## Merge Conflict Resolution

### Conflict Detection

```
Are there any merge conflicts?
```

```
Show me files with merge conflicts
```

```
Help me understand this merge conflict in @src/config.js
```

### Conflict Resolution

```
Resolve the merge conflict in @src/components/Header.jsx by keeping both changes
```

```
For the conflict in @package.json, keep the incoming changes
```

```
Merge these conflicting functions manually:
[paste conflict]
```

### Post-Resolution

```
After resolving conflicts, complete the merge
```

```
Test that the resolved code still works
```

```
Commit the merge resolution
```

## Pull Request Workflows

### PR Preparation

```
My branch is ready. Help me prepare for a pull request.
```

```
Review my changes before I create a PR
```

```
Suggest a PR title and description for these changes
```

### PR Review

```
Review this pull request for potential issues:
[paste PR link or diff]
```

```
Check if this PR introduces any breaking changes
```

```
Suggest improvements for this pull request
```

### PR Updates

```
Address the review comments by updating my code
```

```
Rebase my PR branch to include latest main changes
```

```
Squash my commits into a single commit for the PR
```

## Git Best Practices

### Commit Guidelines

Claude helps enforce good practices:

```
Review my commit and suggest improvements:
- Message: "fixed stuff"
- Files: 15 changed files
```

Claude suggests:
```
Consider splitting this into smaller, focused commits:

1. "fix: resolve authentication timeout issue"
   - src/auth/login.js
   - src/auth/token.js

2. "feat: add user profile validation"
   - src/components/UserProfile.jsx
   - src/utils/validation.js

3. "docs: update API documentation"
   - docs/api.md
   - README.md
```

### Repository Hygiene

```
Clean up my repository:
- Remove large files from history
- Clean up .gitignore
- Remove dead branches
```

```
Check for secrets or sensitive data in my commits
```

```
Optimize repository size and performance
```

## Advanced Git Operations

### Interactive Rebase

```
Help me clean up my last 5 commits with interactive rebase
```

```
Squash my feature commits into a single commit
```

```
Edit the commit message for commit abc123
```

### Git Hooks

```
Create a pre-commit hook that runs linting
```

```
Add a commit-msg hook that validates commit message format
```

```
Set up a pre-push hook that runs tests
```

### Submodules

```
Add a git submodule for our shared components library
```

```
Update all submodules to their latest versions
```

```
Remove the old submodule and replace with npm package
```

## Working with Remotes

### Remote Management

```
Add a new remote for the upstream repository
```

```
Fetch latest changes from origin
```

```
Push my branch to origin and set up tracking
```

### Synchronization

```
Pull latest changes and rebase my work on top
```

```
Sync my fork with the upstream repository
```

```
Update my local main branch with remote changes
```

## Git Troubleshooting

### Common Issues

**Detached HEAD:**
```
I'm in detached HEAD state. Help me get back to a branch.
```

**Uncommitted changes:**
```
I need to switch branches but have uncommitted changes
```

**Large files:**
```
Git is complaining about large files. How do I fix this?
```

**Merge conflicts:**
```
I'm scared to resolve these merge conflicts. Guide me through it.
```

### Recovery Operations

```
I accidentally committed to the wrong branch. How do I fix this?
```

```
I need to undo my last commit but keep the changes
```

```
I deleted a file by mistake. How do I recover it?
```

```
I messed up my branch. Can I reset it to match origin?
```

## Git Workflows

### Feature Branch Workflow

```
Start a new feature following our team's git workflow
```

1. Create feature branch from main
2. Make commits
3. Push branch
4. Create pull request
5. Review and merge

### GitFlow

```
Initialize GitFlow in this repository
```

```
Start a new release branch for version 2.1.0
```

```
Create a hotfix for the production bug
```

### GitHub Flow

```
Follow GitHub flow for this feature
```

1. Create branch
2. Add commits
3. Open pull request
4. Discuss and review
5. Deploy and merge

## Commit Message Templates

### Conventional Commits

```
feat: add new user registration flow
fix: resolve login timeout issue
docs: update API documentation
style: format code with prettier
refactor: extract common validation logic
test: add integration tests for auth
chore: update dependencies
```

### Team Templates

```
Create commit message templates for our team:
- Bug fixes
- New features  
- Documentation updates
- Refactoring
```

## Git Integration Examples

### Daily Workflow

```
Help me start my day:
1. Check what I was working on yesterday
2. Pull latest changes
3. See if there are conflicts
4. Plan today's work
```

### End of Day

```
Help me wrap up:
1. Review my changes
2. Commit logical groups
3. Push my work
4. Clean up workspace
```

### Code Review

```
Prepare my changes for review:
1. Clean up commit history
2. Write good commit messages
3. Update documentation
4. Run tests
```

## Git Aliases and Shortcuts

```
Set up useful git aliases for our team:
- Quick status
- Pretty log
- Push with tracking
- Undo last commit
```

Example aliases:
```bash
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.cm commit
git config --global alias.lg "log --oneline --graph --all"
```

## Repository Analysis

### Code History

```
Who has been the main contributor to @src/components/?
```

```
What files change most frequently?
```

```
Show me the commit activity over the last month
```

### Impact Analysis

```
What would be affected if I change @src/api/auth.js?
```

```
Find all commits that modified the database schema
```

```
Which commits introduced the most bugs?
```

## Next Steps

- [Testing & Debugging](./testing-debugging.md) - Quality assurance with Git
- [Code Navigation](./code-navigation.md) - Finding code across history
- [Best Practices](../09-best-practices/) - Git workflow best practices