# TypeScript Patterns

## Non-null assertion (`!`)

❌ BAD:
```typescript
const user = getUser()!
```

✅ GOOD:
```typescript
const user = getUser() ?? throwError('User not found')
```

**Why:** `!` silences TypeScript but crashes at runtime. `??` provides a safe fallback.

## Type assertion (`as`)

❌ BAD:
```typescript
const data = response as UserData
```

✅ GOOD:
```typescript
if (!isUserData(response)) throw new Error('Invalid response shape')
const data = response
```

**Why:** `as` lies to the compiler. Runtime validation catches real bugs.

## Import organization

❌ BAD:
```typescript
import type { User } from './types'  // scattered inline
import { useState } from 'react'
import type { Room } from './types'  // duplicate source
```

✅ GOOD:
```typescript
import { useState } from 'react'

import type { Room, User } from './types'
```

**Why:** Grouped imports are easier to scan and maintain.

## Explicit conditionals

❌ BAD:
```typescript
if (user) {  // truthy check — fails on empty string, 0
```

✅ GOOD:
```typescript
if (user !== null && user !== undefined) {
```

**Why:** Truthy checks have surprising edge cases with `0`, `""`, `false`.

## Named constants

❌ BAD:
```typescript
if (status === -1) {
```

✅ GOOD:
```typescript
const NOT_FOUND = -1
if (status === NOT_FOUND) {
```

**Why:** Magic numbers obscure intent. Named constants self-document.

## Empty catch blocks

❌ BAD:
```typescript
try { await save() } catch {}
```

✅ GOOD:
```typescript
try {
  await save()
} catch (error) {
  console.error('Save failed:', error)
  throw error  // or handle explicitly
}
```

**Why:** Silent failures are the hardest bugs to find.

## Nullish coalescing vs OR

❌ BAD:
```typescript
const name = input || 'default'  // empty string treated as falsy
```

✅ GOOD:
```typescript
const name = input ?? 'default'  // only null/undefined
```

**Why:** `||` treats `""`, `0`, `false` as falsy. `??` only handles null/undefined.
