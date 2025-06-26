# Contributing to Open Source with Claude Code

This guide demonstrates how to effectively use Claude Code to contribute to open source projects, using our Twenty CRM contributions as real-world examples.

## Table of Contents
- [Overview](#overview)
- [Step-by-Step Process](#step-by-step-process)
- [Example Claude Code Prompts](#example-claude-code-prompts)
- [Tips for Working with Claude Code](#tips-for-working-with-claude-code)
- [Common Issue Patterns](#common-issue-patterns)
- [Debugging Strategies](#debugging-strategies)
- [Real Example: Twenty CRM Contribution](#real-example-twenty-crm-contribution)

## Overview

Claude Code is an AI-powered coding assistant that can help you:
- Set up development environments
- Find and understand issues in codebases
- Implement fixes with proper code style
- Create well-documented pull requests
- Capture evidence of your fixes

## Step-by-Step Process

### 1. Setting Up Your Fork

```bash
# Fork the repository on GitHub first
git clone https://github.com/YOUR_USERNAME/PROJECT_NAME.git
cd PROJECT_NAME

# Add upstream remote
git remote add upstream https://github.com/ORIGINAL_OWNER/PROJECT_NAME.git
```

### 2. Finding Good Issues to Work On

Look for issues with these characteristics:
- Labels: `good first issue`, `help wanted`, `bug`
- No linked PRs (check if someone's already working on it)
- Clear description of the problem
- Reasonable scope (not architectural changes)

### 3. Creating a Development Environment

Ask Claude Code to help set up the project:
```
Can you help me set up the development environment for this project? 
Please:
1. Check the README for setup instructions
2. Create any helper scripts needed
3. Use non-conflicting ports if needed (e.g., 7000 instead of 3000)
```

### 4. Making the Fix

1. **Create a feature branch**: 
   ```bash
   git checkout -b fix/description-issue-NUMBER
   ```

2. **Investigate the issue**:
   - Use Claude Code's search capabilities
   - Understand the current behavior
   - Plan the fix

3. **Implement the solution**:
   - Follow existing code patterns
   - Make minimal necessary changes
   - Test thoroughly

### 5. Creating a Quality PR

Include:
- Clear title and description
- Screenshots for UI changes
- Test plan
- Issue reference (Fixes #XXXX)
- Attribution

## Example Claude Code Prompts

### Prompt 1: Initial Project Setup
```
I want to contribute to [PROJECT NAME]. I've forked it to https://github.com/USERNAME/PROJECT. 
Can you help me:
1. Clone it locally
2. Understand the project structure
3. Set up the development environment
4. Create a helper script to manage dev services
```

### Prompt 2: Finding Suitable Issues
```
Can you browse the issues at https://github.com/OWNER/PROJECT/issues and find some good first issues that:
- Aren't too complex or deep in the architecture
- Are achievable bugs or UI fixes
- Don't have existing PRs
- Have clear descriptions
```

### Prompt 3: Investigating a Specific Issue
```
I want to work on issue #XXXX which says "[ISSUE DESCRIPTION]". Can you:
1. Create a feature branch for this issue
2. Find the relevant code files
3. Analyze what's causing the problem
4. Suggest a fix approach
```

### Prompt 4: Implementing the Fix
```
Based on our investigation of issue #XXXX, please:
1. Implement the fix we discussed
2. Follow the existing code patterns
3. Make sure the fix is minimal and focused
4. Check if there are any tests that need updating
```

### Prompt 5: Testing and Documentation
```
I've implemented a fix for issue #XXXX. Can you:
1. Test that the fix works correctly
2. Use Playwright to capture before/after screenshots
3. Run any linting or type checking
4. Create a commit with a descriptive message
5. Create a PR with proper documentation
```

## Tips for Working with Claude Code

### 1. Be Specific About Requirements

Instead of: "Fix the button"

Try: "The customize fields button in the table header should navigate to the specific object's fields page, not the general objects list"

### 2. Use Task Management

Claude Code's TodoWrite feature helps track complex tasks:
- Automatically breaks down work
- Tracks progress
- Ensures nothing is missed

### 3. Request Visual Evidence

For UI changes, always ask:
```
Can you use Playwright to capture screenshots showing:
1. The issue before the fix
2. The working behavior after the fix
```

### 4. Follow Code Conventions

Ask Claude Code to:
```
Before making changes, can you check:
1. The existing code style in similar files
2. What libraries/patterns are already used
3. The project's contribution guidelines
```

### 5. Attribution Template

Always include in commits/PRs:
```
🤖 Generated with [Claude Code](https://claude.ai/code)

Co-authored-by: Your Name <your.email@example.com>
```

## Common Issue Patterns

### UI/CSS Issues
```
"Find the component for [UI ELEMENT]. The issue reports [PROBLEM].
Look for:
- CSS/styled-components definitions
- Spacing/padding/margin issues
- Flexbox/grid alignment
- Responsive design problems"
```

### Navigation/Routing Issues
```
"Trace the navigation from [SOURCE] to [DESTINATION].
Find:
- Route definitions
- Navigation logic
- URL parameters
- Path construction"
```

### Event Handler Issues
```
"Find the event handlers for [ACTION].
Check for:
- Event propagation
- Condition checks
- State management
- Side effects"
```

### Data Display Issues
```
"Find where [DATA] is displayed.
Look for:
- Data fetching logic
- Formatting/transformation
- Component props
- State updates"
```

## Debugging Strategies

### 1. Start Broad, Then Narrow

```
# First search
"Find files related to 'customize fields'"

# Then narrow
"Look specifically at RecordTableHeaderPlusButtonContent"

# Finally pinpoint
"Show me the navigation logic in this component"
```

### 2. Understand Context

Before changing code:
- Read the entire file
- Check imports
- Look for similar patterns
- Understand the component hierarchy

### 3. Test Incrementally

1. Make small changes
2. Test each change
3. Verify no regressions
4. Build confidence in the fix

### 4. Use the Development Environment

Always run the app locally to:
- See the current behavior
- Test your changes
- Capture screenshots
- Verify the fix works

## Real Example: Twenty CRM Contribution

### The Issue (#12835)
"When clicking customize fields of specific object, it doesn't lead to descriptions of that object"

### Investigation Process

1. **Found the component**:
   ```
   Claude: "Search for 'customize fields' in the codebase"
   Result: Found RecordTableHeaderPlusButtonContent.tsx
   ```

2. **Understood the problem**:
   - Current: Navigates to `/settings/objects` (general list)
   - Expected: Navigate to `/settings/objects/companies` (specific object)

3. **Identified the fix**:
   ```typescript
   // Before
   to={getSettingsPath(SettingsPath.Objects, {
     objectNamePlural: objectMetadataItem.namePlural,
   })}
   
   // After
   to={getSettingsPath(SettingsPath.ObjectDetail, {
     objectNamePlural: objectMetadataItem.namePlural,
   })}
   ```

4. **Verified the solution**:
   - Started dev environment
   - Clicked "Customize fields"
   - Confirmed navigation to `/settings/objects/companies`
   - Captured screenshots

### The Result
- Clean, focused fix (1 line change)
- Clear PR documentation
- Visual evidence of the fix
- Successfully merged contribution

## Best Practices Summary

1. **Research First**: Understand the issue and codebase
2. **Minimal Changes**: Make only necessary modifications
3. **Follow Patterns**: Match existing code style
4. **Test Thoroughly**: Verify the fix works
5. **Document Well**: Clear PR with evidence
6. **Give Attribution**: Credit tools and collaborators

## Getting Started

Ready to contribute? Start with:

```
Hey Claude Code, I want to contribute to [PROJECT]. 
Can you help me:
1. Find a good first issue
2. Set up the development environment
3. Create a fix
4. Submit a quality PR
```

Remember: Open source contribution is about solving real problems for real users. Claude Code is here to help you make meaningful contributions to projects you care about!

---

*This guide was created based on real contributions to the Twenty CRM project using Claude Code.*