# GitHub Copilot Custom Instructions

> A teaching example for effective AI pair programming

## 🎯 Core Principles

1. **Explicit > Implicit**: Always prefer clear, unambiguous instructions over clever shortcuts
2. **Context First**: Provide relevant context before asking for code
3. **Iterative Refinement**: Start broad, then narrow down with specific requirements
4. **Safety First**: Prioritize secure, maintainable code over clever solutions

## 📝 Markdown Formatting

### Auto-Linting Rules

```markdown
# Required Formatting

1. One blank line after each heading (## and ###)
2. One blank line before and after lists
3. One blank line before and after code blocks
4. Language specifier for all code blocks (e.g., ```markdown)
5. Consistent triple backtick fencing
6. No trailing whitespace
7. UTF-8 encoding
8. Line endings: LF (Unix-style)
```

### VS Code Settings

```json
{
    "markdownlint.config": {
        "MD013": false,  // Line length
        "MD024": false,  // Multiple headers with same content
        "MD033": false,  // Allow inline HTML
        "MD041": false,  // First line in file should be a top level header
        "MD022": true,   // Headings should be surrounded by blank lines
        "MD032": true,   // Lists should be surrounded by blank lines
        "MD031": true,   // Fenced code blocks should be surrounded by blank lines
        "MD040": true,   // Fenced code blocks should have a language specified
        "MD047": true    // Files should end with a single newline
    }
}
```

## 📝 Instruction Templates

### Basic Function Generation

```markdown
Create a function that [action] using [technology/framework].
Requirements:
- Input: [describe inputs]
- Output: [describe expected output]
- Error handling: [specific error cases]
- Performance: [any specific performance requirements]
```

### API Integration

```markdown
Implement an API client for [service] that:
- Handles authentication using [method]
- Implements rate limiting
- Includes retry logic with exponential backoff
- Provides TypeScript types for all responses
```

### Security-Focused

```markdown
Create a secure implementation of [feature] that:
- Validates all inputs using [validation library]
- Implements proper authentication/authorization
- Follows OWASP guidelines for [specific vulnerability]
- Includes security headers and CSP configuration
```

## 🎓 Teaching Examples

### Example 1: Basic Function

```markdown
Create a function to validate email addresses that:
- Uses regex for basic format validation
- Checks for common typos in popular domains
- Returns a detailed validation result object
- Includes JSDoc documentation
```

### Example 2: API Integration

```markdown
Build a GitHub API client that:
- Uses OAuth2 for authentication
- Implements proper caching
- Handles rate limiting gracefully
- Provides TypeScript types for all responses
```

### Example 3: Security Implementation

```markdown
Implement a secure file upload system that:
- Validates file types and sizes
- Implements virus scanning
- Uses secure file naming
- Stores files in a secure location
```

## 💡 Best Practices

### DO:

- Provide clear context and requirements
- Specify error handling expectations
- Include performance requirements
- Request documentation and tests
- Ask for security considerations

### DON'T:

- Use vague or ambiguous language
- Skip error handling requirements
- Forget to specify input/output formats
- Ignore security implications
- Use overly complex language

## 🔍 Debugging Tips

When Copilot generates unexpected results:

1. Break down the request into smaller parts
2. Add more specific requirements
3. Include example inputs/outputs
4. Specify edge cases to handle
5. Request step-by-step implementation

## 📚 Learning Resources

- [GitHub Copilot Documentation](https://docs.github.com/en/copilot)
- [OWASP Security Guidelines](https://owasp.org/www-project-top-ten/)
- [TypeScript Documentation](https://www.typescriptlang.org/docs/)
- [Node.js Best Practices](https://github.com/goldbergyoni/nodebestpractices)

## 🎯 Practice Exercises

1. Try implementing each example above
2. Modify the requirements and observe how Copilot adapts
3. Experiment with different levels of specificity
4. Practice debugging unexpected results
5. Create your own instruction templates

Remember: The quality of Copilot's output directly correlates with the quality of your instructions. Be specific, be clear, and iterate!
