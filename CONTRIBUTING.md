# Contributing to How to Claude Code

First off, thank you for considering contributing to this project! This repository aims to be a comprehensive resource for the Claude Code community, and contributions from users like you make it better for everyone.

## How Can I Contribute?

### 🐛 Reporting Issues

- Check if the issue already exists
- Use the issue templates when available
- Provide clear reproduction steps
- Include relevant configuration details

### 💡 Suggesting Enhancements

- Open an issue with the "enhancement" label
- Clearly describe the proposed improvement
- Explain why it would be valuable
- Provide examples if possible

### 📝 Improving Documentation

- Fix typos and grammar
- Clarify confusing sections
- Add missing information
- Update outdated content

### 🎯 Contributing Prompts

- Test prompts before submitting
- Follow the existing format
- Include real-world use cases
- Document expected outputs

### 🔧 Adding MCP Servers

- Test the server configuration
- Document all required settings
- Include troubleshooting tips
- Provide practical examples

### 📜 Creating Custom Commands

- Follow the markdown format with frontmatter
- Test commands thoroughly
- Include clear documentation
- Provide usage examples

## Getting Started

1. Fork the repository
2. Clone your fork:
   ```bash
   git clone https://github.com/your-username/how-to-claude-code.git
   ```
3. Create a branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```
4. Make your changes
5. Test your changes with Claude Code
6. Commit with a clear message:
   ```bash
   git commit -m "Add: New prompt for debugging React apps"
   ```
7. Push to your fork:
   ```bash
   git push origin feature/your-feature-name
   ```
8. Open a Pull Request

## Style Guidelines

### Markdown Files

- Use clear, descriptive headings
- Include code blocks with language tags
- Add table of contents for long documents
- Use relative links for internal navigation

### Code Examples

```markdown
```javascript
// Always include language tags
const example = "like this";
```‎
```

### Prompts Format

```markdown
# Prompt Title

## One-line Description

```
The actual prompt text goes here
```

## Use Cases

- When to use this prompt
- What problems it solves

## Example Output

What to expect from Claude
```

### Custom Commands Format

```markdown
---
name: command-name
description: Brief description
---

# Command Title

Full command documentation...
```

## File Organization

- Place files in appropriate directories
- Use kebab-case for file names
- Keep related content together
- Update navigation in README.md

## Testing

Before submitting:

1. **Test with Claude Code**: Ensure prompts and commands work
2. **Check Links**: Verify all links work
3. **Validate JSON**: Use a JSON validator for configurations
4. **Review Formatting**: Ensure consistent markdown

## Commit Messages

Use clear, descriptive commit messages:

- `Add: New MCP server guide for PostgreSQL`
- `Fix: Typo in installation instructions`
- `Update: React debugging prompt with hooks examples`
- `Improve: Performance analysis prompt clarity`
- `Remove: Outdated Docker configuration`

## Pull Request Process

1. Update README.md if adding new sections
2. Add yourself to contributors (if desired)
3. Ensure all tests/checks pass
4. Request review from maintainers
5. Address review feedback promptly

## Code of Conduct

### Our Standards

- Be welcoming and inclusive
- Respect different viewpoints
- Accept constructive criticism
- Focus on the community's best interests

### Unacceptable Behavior

- Harassment or discrimination
- Trolling or insulting comments
- Public or private harassment
- Publishing private information

## Recognition

Contributors will be:
- Listed in the contributors section
- Credited in release notes
- Appreciated by the community! 🎉

## Questions?

- Open an issue with the "question" label
- Check existing discussions
- Reach out to maintainers

## License

By contributing, you agree that your contributions will be licensed under the same MIT License that covers this project.

---

Thank you for helping make Claude Code better for everyone! 🚀