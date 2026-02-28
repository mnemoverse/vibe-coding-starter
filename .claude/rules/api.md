# API Call Patterns

## External API call checklist

Before calling any external API:

1. **Timeout** — Set explicit timeout (default: 5s, max: 30s)
2. **Retry** — Retry on 5xx and network errors, NOT on 4xx
3. **Backoff** — Exponential with jitter (not fixed intervals)
4. **Circuit breaker** — Stop calling after N consecutive failures
5. **Rate limit** — Respect provider limits, add client-side throttle
6. **Logging** — Log request/response (redact secrets)
7. **Error mapping** — Map provider errors to your error codes

## Timeout handling

❌ BAD:
```typescript
const response = await fetch(url)  // no timeout — hangs forever
```

✅ GOOD:
```typescript
const controller = new AbortController()
const timeout = setTimeout(() => controller.abort(), 5000)

try {
  const response = await fetch(url, { signal: controller.signal })
  return await response.json()
} finally {
  clearTimeout(timeout)
}
```

## Retry with backoff

❌ BAD:
```typescript
// Retry immediately — hammers the server
for (let i = 0; i < 3; i++) {
  try { return await callApi() } catch {}
}
```

✅ GOOD:
```typescript
async function withRetry<T>(fn: () => Promise<T>, maxRetries = 3): Promise<T> {
  for (let attempt = 0; attempt <= maxRetries; attempt++) {
    try {
      return await fn()
    } catch (error) {
      if (attempt === maxRetries) throw error
      if (isClientError(error)) throw error  // don't retry 4xx
      const delay = Math.min(1000 * 2 ** attempt, 10000)
      const jitter = delay * (0.5 + Math.random() * 0.5)
      await sleep(jitter)
    }
  }
  throw new Error('Unreachable')
}
```

## Error response handling

❌ BAD:
```typescript
const data = await response.json()  // crashes on non-JSON error responses
```

✅ GOOD:
```typescript
if (!response.ok) {
  const body = await response.text()
  const parsed = tryParseJson(body)
  throw new ApiError(response.status, parsed?.message ?? body)
}
const data = await response.json()
```

## Input validation at boundaries

❌ BAD:
```typescript
app.post('/users', async (req) => {
  await db.insert(req.body)  // trusts client blindly
})
```

✅ GOOD:
```typescript
const CreateUserSchema = z.object({
  name: z.string().min(1).max(100),
  email: z.string().email(),
})

app.post('/users', async (req) => {
  const data = CreateUserSchema.parse(req.body)
  await db.insert(data)
})
```

**Why:** Validate at system boundaries (API input, webhook payload, file upload). Trust internal code.

## Generic error responses

❌ BAD:
```typescript
// Leaks internal details
throw new Error(`User ${userId} not found in table users`)
```

✅ GOOD:
```typescript
// Safe for clients
throw new ApiError(404, 'Resource not found')

// Detailed logging (server-side only)
logger.warn('User not found', { userId, table: 'users' })
```

**Why:** Error messages to clients should be generic. Detailed info goes to logs only.
