# Exercise: Implementing Secure API Endpoints

## Scenario
You need to implement a secure API endpoint for handling sensitive user data with proper authentication, authorization, and input validation.

## Exercise Goals
- Practice secure coding with Copilot
- Implement security best practices
- Learn to guide Copilot for security-focused code

## Base Implementation

Start with this basic endpoint structure:
```python
from fastapi import FastAPI
app = FastAPI()

@app.post("/api/users/profile")
async def update_user_profile():
    # TODO: Implement secure profile update
    pass
```

## Exercise Steps

### 1. Authentication Middleware
```python
# Type the following comment and let Copilot suggest the implementation:
# Implement JWT authentication middleware with rate limiting and token validation
```

### 2. Input Validation
```python
# Type these comments sequentially:
# Create Pydantic model for user profile data with strict validation
# Add validation for potentially dangerous fields like URLs and file paths
```

### 3. Authorization Check
```python
# Guide Copilot with:
# Add role-based access control middleware
# Implement function to verify user has permission to update profile
```

### 4. Secure Data Handling
```python
# Lead Copilot with:
# Add input sanitization for XSS prevention
# Implement secure file upload handling with virus scanning
```

### 5. Audit Logging
```python
# Direct Copilot:
# Add structured audit logging for security events
# Implement secure logging that masks sensitive data
```

## Security Checklist
- [ ] Input validation and sanitization
- [ ] Authentication and authorization
- [ ] Secure password handling
- [ ] Rate limiting
- [ ] Audit logging
- [ ] Error handling without info disclosure
- [ ] Security headers
- [ ] CSRF protection

## Tips for Working with Copilot
- Start with security-focused comments
- Review each suggestion carefully
- Use security-related keywords
- Break down complex security features
- Always validate generated security code
- Add explicit security checks in comments

## Verification Steps
1. Test authentication bypass attempts
2. Verify input validation
3. Check authorization rules
4. Validate audit log contents
5. Test rate limiting
6. Verify error handling
7. Check security headers 