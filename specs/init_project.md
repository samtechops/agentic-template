# Feature: Health Check Endpoint

## Feature Description
Add a health check endpoint that exposes the current status, uptime, and version of the running service. This endpoint provides a standardized way for load balancers, orchestrators, and monitoring tools to verify that the service is alive and responsive. The endpoint should return a JSON payload with key diagnostic information and respond quickly with minimal overhead.

## User Story
As a DevOps engineer
I want a health check endpoint
So that I can monitor service availability and integrate with orchestration tools like Kubernetes liveness probes

## Problem Statement
There is currently no way to programmatically verify that the service is running and healthy. Without a health check endpoint, load balancers cannot route traffic intelligently, container orchestrators cannot restart unhealthy instances, and monitoring dashboards have no standardized signal to track service availability.

## Solution Statement
Add a `GET /health` endpoint that returns a JSON response containing the service status (`"ok"`), server uptime in seconds, the application version from `package.json`, and a UTC timestamp. The endpoint requires no authentication, responds within milliseconds, and follows industry-standard health check conventions.

## Relevant Files
Use these files to implement the feature:

- `src/server.ts` - Main server entry point where routes are registered. The health route will be added here.
- `src/routes/health.ts` - New route handler for the health check endpoint.
- `src/config.ts` - Application configuration; version and environment values are read from here.
- `package.json` - Contains the application version that the endpoint will report.
- `tests/routes/health.test.ts` - New test file for the health check route.

### New Files
- `src/routes/health.ts` - Route handler that builds and returns the health check response.
- `tests/routes/health.test.ts` - Unit and integration tests for the health check endpoint.

## Implementation Plan
### Phase 1: Foundation
- Review the existing route registration pattern in `src/server.ts` to understand how routes are mounted.
- Confirm the application version is accessible from `src/config.ts` or `package.json`.
- Identify how uptime is tracked (e.g., `process.uptime()` or a custom start-time variable).

### Phase 2: Core Implementation
- Create `src/routes/health.ts` with a handler that returns `{ status: "ok", uptime: <seconds>, version: "<semver>", timestamp: "<ISO 8601>" }`.
- Register the route as `GET /health` in `src/server.ts`.
- Ensure the endpoint returns HTTP 200 with `Content-Type: application/json`.

### Phase 3: Integration
- Verify the endpoint works alongside existing routes without conflicts.
- Confirm no authentication middleware is applied to the health route.
- Test that the endpoint is accessible when the server is running in all configured environments (development, production).

## Step by Step Tasks
IMPORTANT: Execute every step in order, top to bottom.

### Step 1: Review existing route patterns
- Read `src/server.ts` and identify how routes are imported and registered.
- Read `src/config.ts` and confirm how application metadata (version, environment) is exposed.
- Note the project's conventions for response formatting and error handling.

### Step 2: Create the health route handler
- Create `src/routes/health.ts`.
- Export a handler function that builds the health check JSON payload:
  - `status`: hardcoded string `"ok"`.
  - `uptime`: value from `process.uptime()`, rounded to the nearest integer.
  - `version`: read from config or `package.json`.
  - `timestamp`: current time as an ISO 8601 string via `new Date().toISOString()`.
- Return the payload with HTTP status 200.

### Step 3: Register the route
- Import the health handler in `src/server.ts`.
- Register `GET /health` before any authentication middleware so it is publicly accessible.
- Place the route registration near the top of the route list for clarity.

### Step 4: Write unit tests
- Create `tests/routes/health.test.ts`.
- Test that `GET /health` returns HTTP 200.
- Test that the response body contains `status`, `uptime`, `version`, and `timestamp` fields.
- Test that `status` is `"ok"`.
- Test that `uptime` is a non-negative number.
- Test that `version` matches the version in `package.json`.
- Test that `timestamp` is a valid ISO 8601 string.

### Step 5: Write integration tests
- Test the endpoint using a real HTTP request against the running server.
- Verify the `Content-Type` header is `application/json`.
- Verify no authentication is required (no `Authorization` header needed).

### Step 6: Run validation commands
- Execute all validation commands listed below.
- Confirm zero test failures and zero lint errors.

## Testing Strategy
### Unit Tests
- Verify the handler returns the correct JSON structure with all required fields.
- Verify `status` is always `"ok"`.
- Verify `uptime` is a number greater than or equal to zero.
- Verify `version` matches the value from `package.json`.
- Verify `timestamp` is a valid ISO 8601 date string.

### Integration Tests
- Send a `GET /health` request to the running server and assert HTTP 200.
- Assert the `Content-Type` response header is `application/json`.
- Assert the response body parses as valid JSON with the expected schema.
- Assert the endpoint is accessible without authentication headers.

### Edge Cases
- Server just started (uptime near zero) -- verify `uptime` is still a valid non-negative number.
- Multiple rapid requests -- verify the endpoint is idempotent and each response has a unique timestamp.
- Missing or malformed `Accept` header -- verify the endpoint still returns JSON.

## Acceptance Criteria
- `GET /health` returns HTTP 200 with `Content-Type: application/json`.
- Response body contains `status` (`"ok"`), `uptime` (number), `version` (string matching `package.json`), and `timestamp` (ISO 8601 string).
- The endpoint requires no authentication.
- All existing tests continue to pass with zero regressions.
- Lint passes with no new warnings or errors.

## Validation Commands
Execute every command to validate the feature works correctly with zero regressions.

```bash
# Run the full test suite
npm test

# Run only health check tests
npm test -- --grep "health"

# Lint the codebase
npm run lint

# Start the server and manually verify the endpoint
npm run dev &
sleep 2
curl -s http://localhost:3000/health | jq .
kill %1
```

## Notes
- This endpoint is intentionally unauthenticated so that load balancers and orchestrators can reach it without credentials.
- A future iteration could add a `/health/ready` readiness endpoint that checks downstream dependencies (database, cache, external APIs).
- If the project adopts a different framework later, the handler logic is self-contained in `src/routes/health.ts` and easy to port.
- The response schema follows conventions used by Kubernetes liveness probes and AWS ALB health checks.
