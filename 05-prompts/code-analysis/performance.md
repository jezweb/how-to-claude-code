# Performance Analysis Prompts

## Basic Performance Review

```
Analyze the performance of this code and identify bottlenecks. Focus on:
1. Time complexity of algorithms
2. Memory usage patterns
3. Database query efficiency
4. Network request optimization
5. Caching opportunities

Provide specific recommendations with code examples.
```

## Deep Performance Audit

```
Perform a comprehensive performance audit of this codebase:

1. Profile the code to identify hot paths
2. Analyze algorithmic complexity (Big O)
3. Find N+1 query problems
4. Identify memory leaks or excessive allocations
5. Check for inefficient data structures
6. Review async/await usage and parallelization opportunities
7. Examine caching strategies

For each issue found:
- Explain the performance impact
- Provide a fix with example code
- Estimate performance improvement
- Suggest how to measure the improvement
```

## React/Frontend Performance

```
Analyze this React application for performance issues:

1. Unnecessary re-renders
2. Large bundle sizes
3. Inefficient component structure
4. Missing React.memo or useMemo
5. Expensive operations in render
6. Image optimization opportunities
7. Code splitting potential

Provide:
- Specific components that need optimization
- Before/after code examples
- Expected performance gains
- Tools to measure improvements
```

## API Performance Optimization

```
Review this API for performance improvements:

1. Query optimization (database indexes, joins)
2. Caching strategies (Redis, CDN, browser)
3. Pagination implementation
4. Data serialization efficiency
5. Connection pooling
6. Rate limiting needs
7. Compression opportunities

Output:
- Prioritized list of optimizations
- Implementation examples
- Performance testing approach
- Monitoring recommendations
```

## Database Query Optimization

```
Analyze these database queries for performance:

1. Missing indexes
2. Inefficient joins
3. N+1 query problems
4. Unnecessary data fetching
5. Query plan analysis
6. Connection pool settings

For each query:
- Current execution time
- Optimization suggestion
- Expected improvement
- Index recommendations
```

## Memory Usage Analysis

```
Investigate memory usage in this application:

1. Memory leak detection
2. Large object allocations
3. Circular references
4. Inefficient data structures
5. Cache size management
6. Garbage collection pressure

Provide:
- Memory hotspots
- Leak locations
- Optimization strategies
- Monitoring setup
```

## Async Performance Patterns

```
Review asynchronous code for performance:

1. Sequential vs parallel execution
2. Promise.all() opportunities
3. Unnecessary await chains
4. Blocking operations
5. Worker thread candidates
6. Stream processing potential

Show:
- Current flow diagram
- Optimized flow
- Code refactoring
- Performance gains
```

## Load Testing Preparation

```
Prepare this application for load testing:

1. Identify performance KPIs
2. Find stress points
3. Set up monitoring
4. Create test scenarios
5. Define success criteria
6. Suggest tools

Deliverables:
- Test plan
- Expected bottlenecks
- Monitoring dashboard
- Remediation strategies
```

## Microservices Performance

```
Analyze microservice architecture performance:

1. Inter-service communication overhead
2. Data consistency patterns
3. Service mesh optimization
4. Circuit breaker placement
5. Distributed caching
6. Message queue efficiency

Focus on:
- Latency reduction
- Throughput improvement
- Resource optimization
- Monitoring setup
```

## Real-time Performance

```
Optimize real-time features performance:

1. WebSocket connection management
2. Message batching strategies
3. Client-side buffering
4. Server-side broadcasting
5. Reconnection logic
6. Scale-out architecture

Provide:
- Current limitations
- Scaling strategies
- Code improvements
- Infrastructure needs
```