# ai_docs

## What are ai_docs?

ai_docs are documentation written for AI coding agents, not humans. Every time an agent starts a session, it begins with zero context about your project's libraries, APIs, and conventions. ai_docs solve this by providing the specific library and API context agents need to write correct code immediately.

Place documentation files in this directory for any library, framework, or API your project depends on.

## Why they matter

Without ai_docs, agents will:

- Guess at API usage and get function signatures wrong.
- Use outdated patterns from their training data instead of current best practices.
- Waste tokens searching through source code and installed packages trying to figure out how a library works.
- Produce code that compiles but misuses the library in subtle ways.

With ai_docs, agents get the equivalent of a senior developer's knowledge of each library, available instantly at the start of every session.

## How to add them

1. Identify the key libraries and APIs your project uses.
2. For each one, create a markdown file in this directory (e.g., `stripe.md`, `react-query.md`, `your-internal-api.md`).
3. Populate each file with:
   - Quickstart or getting-started patterns relevant to your project.
   - API references for the functions and classes you actually use.
   - Code examples showing correct usage in your codebase's style.
   - Any gotchas, version-specific notes, or non-obvious configuration.

Sources for content: official docs, quickstart guides, README files, API references, and working code from your own project.

## What makes good ai_docs

**Include:**
- Function and method signatures with parameter types and return types.
- Short, working code examples (the more realistic, the better).
- Common patterns and idioms for your specific use case.
- Configuration and setup that your project requires.
- Version numbers so the agent knows which API surface to target.

**Avoid:**
- Long narrative explanations or history of the library.
- Exhaustive API coverage for parts you do not use.
- Content longer than ~500 lines per file -- agents work better with focused docs.

## Example

Here is what an ai_doc file might look like for a hypothetical HTTP client library:

```markdown
# httpclient v3.2

## Installation
Already installed. Import from `httpclient`.

## Basic Usage

### GET request
    from httpclient import Client

    client = Client(base_url="https://api.example.com", timeout=30)
    response = client.get("/users", params={"active": True})
    users = response.json()  # returns parsed JSON as dict

### POST request with JSON body
    client.post("/users", json={"name": "Alice", "role": "admin"})

### Error handling
    from httpclient import HttpError, TimeoutError

    try:
        response = client.get("/users/123")
        response.raise_for_status()
    except HttpError as e:
        print(f"HTTP {e.status_code}: {e.message}")
    except TimeoutError:
        print("Request timed out")

## Auth
This project uses bearer token auth. The token is loaded from
the environment variable API_TOKEN. See config.py for setup.

## Gotchas
- Always call `response.raise_for_status()` -- failed requests
  return 200-like response objects by default.
- `client.get()` returns a Response, not raw JSON. Call `.json()`.
```

This gives an agent everything it needs: how to import, how to make requests, how errors work, and project-specific configuration -- all in under 40 lines.
