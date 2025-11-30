# Exercise: Incident Response and Troubleshooting

## Scenario
You're on-call and receive an alert about high latency and intermittent 503 errors in your production Kubernetes cluster.

## Exercise Goals
- Practice crafting prompts for incident analysis
- Learn to generate systematic troubleshooting steps
- Create clear incident documentation

## Sample Alert Data
```
Alert: High Latency Detected
Severity: P1
Time: 2024-01-13 15:30 UTC
Details:
- Response time > 2000ms (threshold: 500ms)
- 503 errors rate: 15%
- CPU usage spike across multiple nodes
- Connection timeouts to database reported
```

## Sample Prompts

### 1. Initial Analysis Prompt
```
Given this production incident alert:
1. What are the potential root causes?
2. List immediate investigation steps
3. Suggest commands to gather more information
4. Identify potential impact areas
Prioritize steps based on severity and ease of investigation.
```

### 2. Troubleshooting Steps Prompt
```
Help me investigate this Kubernetes cluster issue by:
1. Providing kubectl commands to check cluster health
2. Listing key metrics to monitor
3. Suggesting log patterns to search for
4. Identifying potential bottlenecks
Format as step-by-step troubleshooting guide with commands and expected outputs.
```

### 3. Documentation Prompt
```
Help me document this incident with:
1. Timeline of events
2. Impact assessment
3. Root cause analysis
4. Resolution steps taken
5. Prevention measures
Format as a structured incident report suitable for stakeholders.
```

## Practice Tasks
1. Use the prompts to analyze the incident
2. Create prompts for different types of alerts
3. Generate runbooks using ChatGPT
4. Practice incident communication prompts

## Tips
- Include relevant metrics and logs
- Ask for specific commands and tools
- Request step-by-step procedures
- Consider different stakeholder perspectives
- Always validate suggested commands before execution 