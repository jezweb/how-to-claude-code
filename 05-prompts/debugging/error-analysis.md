# Error Analysis Prompts

## Stack Trace Analysis

```
Analyze this error stack trace and help me fix it:

[Paste stack trace here]

Please:
1. Explain what caused the error
2. Identify the root cause location
3. Suggest specific fixes
4. Provide code examples
5. Explain how to prevent this in the future
```

## Production Error Investigation

```
Help debug this production error:

Error: [error message]
Frequency: [X times in Y hours]
Affected users: [number]
Environment: [production details]

Investigate:
1. Common patterns in failures
2. Environmental factors
3. Recent deployments
4. Related system changes
5. Temporary workarounds
6. Permanent solutions
```

## Intermittent Bug Analysis

```
Debug this intermittent issue that happens randomly:

Symptoms: [describe behavior]
Frequency: [how often]
Cannot reproduce locally

Help me:
1. Create a reproduction strategy
2. Add strategic logging
3. Identify race conditions
4. Find timing dependencies
5. Build a fix that handles all cases
```

## Memory Leak Detection

```
I suspect a memory leak in this application:

Symptoms:
- Memory usage grows over time
- Eventually crashes with OOM
- Happens after [X hours/days]

Analyze:
1. Potential leak sources
2. Object retention paths
3. Event listener cleanup
4. Circular references
5. Cache management issues

Provide debugging strategy and fixes.
```

## Performance Degradation

```
Debug performance degradation issue:

Normal response time: [X ms]
Current response time: [Y ms]
Started: [date/time]
No code changes deployed

Investigate:
1. Database query performance
2. External service latency
3. Resource exhaustion
4. Lock contention
5. Configuration changes
```

## Async/Promise Errors

```
Fix this unhandled promise rejection:

[Error details]

Analyze:
1. Promise chain flow
2. Missing error handlers
3. Race condition potential
4. Proper error propagation
5. Retry strategies
```

## State Management Bugs

```
Debug this state management issue:

Problem: State updates not reflecting in UI
Framework: [React/Vue/Angular]
State management: [Redux/MobX/Vuex]

Check:
1. State mutation patterns
2. Component subscriptions
3. Async action handling
4. Middleware conflicts
5. DevTools integration
```

## API Integration Errors

```
Troubleshoot this API integration error:

Endpoint: [URL]
Error: [status code and message]
Works in: [Postman/curl]
Fails in: [application]

Debug:
1. Request headers
2. Authentication flow
3. CORS issues
4. Request body format
5. Response parsing
```

## Database Connection Issues

```
Solve this database connection problem:

Error: [connection error]
Database: [type and version]
Happens: [when/frequency]

Investigate:
1. Connection pool settings
2. Timeout configurations
3. Network issues
4. Query deadlocks
5. Resource limits
```

## Build/Compilation Errors

```
Fix this build error:

[Build error output]

Environment: [local/CI]
Last working commit: [hash]

Resolve:
1. Dependency conflicts
2. Version mismatches
3. Missing dependencies
4. Build tool configuration
5. Environment differences
```

## Type Errors (TypeScript)

```
Resolve these TypeScript errors:

[TypeScript error output]

Help me:
1. Understand the type conflict
2. Fix with proper types
3. Avoid using 'any'
4. Improve type safety
5. Add necessary generics
```

## Deployment Failures

```
Debug this deployment failure:

Platform: [AWS/GCP/Azure/Vercel]
Error: [deployment error]
Stage: [build/deploy/post-deploy]

Troubleshoot:
1. Environment variables
2. Build configuration
3. Runtime dependencies
4. Permission issues
5. Resource quotas
```

## Race Condition Debugging

```
Fix this race condition:

Symptom: [describe behavior]
Occurs when: [conditions]
Concurrency: [level]

Analyze:
1. Shared resource access
2. Lock requirements
3. Atomic operations
4. Queue implementation
5. Synchronization fix
```

## Error Monitoring Setup

```
Help me set up comprehensive error monitoring:

Application: [type/framework]
Current issues: [list problems]
Budget: [constraints]

Recommend:
1. Error tracking tools
2. Logging strategy
3. Alert configuration
4. Error grouping
5. Resolution workflow
```