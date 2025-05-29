# Exercise: Test Generation with GitHub Copilot

## Scenario
You need to write unit tests for a new function that processes user data.

## Exercise Goals
- Learn to generate test cases with Copilot
- Practice test-driven development
- Understand how to guide Copilot for better test coverage

## Sample Function to Test
```python
def validate_user_data(user_dict):
    """
    Validates user data according to the following rules:
    - Username must be 3-20 characters
    - Email must be valid format
    - Age must be between 13 and 120
    Returns tuple of (is_valid: bool, errors: list)
    """
    # Write this function using Copilot suggestions
```

## Exercise Steps

1. **Initial Test Structure**
```python
# Type: def test_validate_user_data
# Let Copilot suggest test cases
```

2. **Edge Cases**
```python
# Type: def test_validate_user_data_edge_cases
# Let Copilot suggest edge cases
```

3. **Error Cases**
```python
# Type: def test_validate_user_data_errors
# Let Copilot suggest error cases
```

## Tips for Working with Copilot
- Start with clear function docstrings
- Use descriptive test function names
- Write comments about what you want to test
- Press Tab to accept suggestions
- Press Alt+] to see alternative suggestions
- Type more specific comments for better suggestions

## Practice Tasks
1. Implement the `validate_user_data` function using Copilot
2. Generate test cases using the patterns above
3. Add more edge cases that Copilot might have missed
4. Create similar test patterns for your own functions 