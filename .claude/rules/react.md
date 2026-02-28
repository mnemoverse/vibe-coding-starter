# React Patterns

## Static objects outside components

❌ BAD:
```tsx
function UserList() {
  const columns = [
    { key: 'name', label: 'Name' },
    { key: 'email', label: 'Email' },
  ]
  return <Table columns={columns} />
}
```

✅ GOOD:
```tsx
const COLUMNS = [
  { key: 'name', label: 'Name' },
  { key: 'email', label: 'Email' },
]

function UserList() {
  return <Table columns={COLUMNS} />
}
```

**Why:** Objects created inside components get new references every render, triggering unnecessary re-renders of children.

## useState in useEffect dependencies

❌ BAD:
```tsx
const [count, setCount] = useState(0)

useEffect(() => {
  const interval = setInterval(() => {
    setCount(count + 1)  // stale closure
  }, 1000)
  return () => clearInterval(interval)
}, [count])  // re-creates interval every tick
```

✅ GOOD:
```tsx
const [count, setCount] = useState(0)

useEffect(() => {
  const interval = setInterval(() => {
    setCount(prev => prev + 1)  // functional update
  }, 1000)
  return () => clearInterval(interval)
}, [])  // runs once
```

**Why:** Functional updates avoid stale closures and unnecessary effect re-runs.

## Event handler cleanup

❌ BAD:
```tsx
useEffect(() => {
  window.addEventListener('resize', handleResize)
}, [])  // memory leak — never removed
```

✅ GOOD:
```tsx
useEffect(() => {
  window.addEventListener('resize', handleResize)
  return () => window.removeEventListener('resize', handleResize)
}, [])
```

**Why:** Missing cleanup = memory leaks and ghost event handlers.

## Conditional rendering

❌ BAD:
```tsx
{items.length && <List items={items} />}  // renders "0" when empty
```

✅ GOOD:
```tsx
{items.length > 0 && <List items={items} />}
```

**Why:** `0` is falsy but React renders it as text. Explicit comparison prevents "0" appearing in UI.

## Key prop on lists

❌ BAD:
```tsx
{items.map((item, index) => <Item key={index} {...item} />)}
```

✅ GOOD:
```tsx
{items.map(item => <Item key={item.id} {...item} />)}
```

**Why:** Index keys cause bugs when list order changes (items unmount/remount incorrectly).

## No inline styles for theming

❌ BAD:
```tsx
<div style={{ color: '#3b82f6' }}>
```

✅ GOOD:
```tsx
<div className="text-primary">  {/* or CSS variable */}
```

**Why:** Hardcoded colors break theming and dark mode. Use CSS variables or utility classes.
