---
name: test-suite
description: Generate comprehensive test suite for code
---

# Generate Test Suite

Create a comprehensive test suite for the specified code with high coverage and quality.

## Test Requirements

1. **Test Coverage**
   - Unit tests for all public methods
   - Integration tests for component interactions
   - Edge cases and error conditions
   - Happy path and unhappy path scenarios

2. **Test Framework**
   - Use the project's existing test framework
   - If none exists, recommend based on language/framework
   - Follow established patterns in the codebase

3. **Test Structure**
   - Arrange-Act-Assert pattern
   - Descriptive test names
   - Proper setup and teardown
   - Test isolation

## Test Categories

Generate tests for:
- ✅ Functionality tests
- ✅ Edge cases
- ✅ Error handling
- ✅ Boundary conditions
- ✅ Performance tests (where applicable)
- ✅ Security tests (where applicable)

## Mocking Strategy

- Mock external dependencies
- Use realistic test data
- Avoid over-mocking
- Test actual integrations where valuable

## Additional Requirements

$ARGUMENTS

## Deliverables

1. **Test Files**
   - Organized by component/module
   - Clear file naming
   - Proper imports

2. **Test Data**
   - Fixtures or factories
   - Reusable test utilities
   - Sample data sets

3. **Documentation**
   - How to run tests
   - Coverage reports
   - CI/CD integration

4. **Coverage Report**
   - Current coverage
   - Target coverage
   - Gaps identified