# Exercise: Code Review and Best Practices

## Scenario
You're reviewing a pull request that implements a new API endpoint for user authentication.

## Exercise Goals
- Practice crafting prompts for code review
- Learn to identify security and performance issues
- Generate constructive feedback

## Sample Code to Review
```python
@app.route('/api/login', methods=['POST'])
def login():
    data = request.json
    user = db.query(f"SELECT * FROM users WHERE username='{data['username']}'")
    if user and user.password == data['password']:
        token = generate_token(user.id)
        return jsonify({'token': token})
    return jsonify({'error': 'Invalid credentials'}), 401
```

## Sample Prompts

### 1. Initial Review Prompt
```
Please review this Python code for a login endpoint with focus on:
- Security vulnerabilities
- Performance issues
- Best practices
- Code organization
Format the response as a structured review with severity levels for each issue.
```

### 2. Security-Focused Prompt
```
For this login endpoint code:
1. Identify all potential security vulnerabilities
2. Suggest secure alternatives for each issue
3. Provide example code snippets showing secure implementation
Focus especially on SQL injection, password handling, and token generation.
```

### 3. Improvement Prompt
```
Help me refactor this login endpoint to:
1. Follow REST best practices
2. Implement proper error handling
3. Add input validation
4. Use secure password comparison
5. Add appropriate logging
Please provide the refactored code with comments explaining each improvement.
```

## Practice Tasks
1. Review the code using each prompt
2. Create your own security-focused prompts
3. Generate prompts for specific aspects (logging, validation, etc.)
4. Create prompts for suggesting test cases

## Tips
- Be specific about what aspects to review
- Ask for severity levels and priorities
- Request example code for improvements
- Use follow-up prompts for deeper analysis
- Always verify security-related suggestions 