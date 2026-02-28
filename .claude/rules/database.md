# Database Patterns

## TOCTOU race conditions

❌ BAD:
```typescript
// Check-then-act: another request can sneak in between
const existing = await db.findByEmail(email)
if (existing) throw new Error('Email taken')
await db.create({ email })  // RACE: duplicate possible
```

✅ GOOD:
```typescript
// Unique constraint + try-catch: atomic
try {
  await db.create({ email })
} catch (error) {
  if (isUniqueViolation(error)) {
    throw new ApiError(409, 'Email already registered')
  }
  throw error
}
```

**Why:** Between check and act, another request can create the same record. Database constraints are atomic.

## Atomic counters

❌ BAD:
```typescript
const count = await db.getCount(roomId)
await db.setCount(roomId, count + 1)  // RACE: lost update
```

✅ GOOD:
```sql
UPDATE rooms SET member_count = member_count + 1 WHERE id = $1
```

**Why:** Read-modify-write in application code loses concurrent updates. SQL `+ 1` is atomic.

## Enum validation

❌ BAD:
```typescript
await db.create({ role: userInput })  // any string goes to DB
```

✅ GOOD:
```typescript
const VALID_ROLES = ['viewer', 'editor', 'admin'] as const
type Role = typeof VALID_ROLES[number]

if (!VALID_ROLES.includes(userInput)) {
  throw new ApiError(400, `Invalid role. Must be: ${VALID_ROLES.join(', ')}`)
}
await db.create({ role: userInput as Role })
```

## Transaction boundaries

❌ BAD:
```typescript
await db.createOrder(order)
await db.deductInventory(order.items)  // fails = inconsistent state
await db.chargePayment(order.total)
```

✅ GOOD:
```typescript
await db.transaction(async (tx) => {
  await tx.createOrder(order)
  await tx.deductInventory(order.items)
  await tx.chargePayment(order.total)
})  // all or nothing
```

**Why:** Without transaction, partial failure leaves data in inconsistent state.

## N+1 query prevention

❌ BAD:
```typescript
const rooms = await db.getRooms()
for (const room of rooms) {
  room.members = await db.getMembers(room.id)  // N queries
}
```

✅ GOOD:
```typescript
const rooms = await db.getRooms({
  include: { members: true }  // 1 query with JOIN
})
```

## Migration safety

- Never modify a migration that has been run
- Always add columns as nullable first, backfill, then add NOT NULL
- Test migrations on a copy of production data
- Always have a down migration ready
- Backup before migrating
