---
name: incident
description: Production incident response templates. Use during active incidents (webhook backlog, payment issues, account takeover, lockout, session leak) or when building incident playbooks.
argument-hint: "[incident-type or symptom]"
---

# Incident Response

## When to Use

- Active production incident
- Building incident response playbooks
- Practicing incident response
- Post-incident review and improvement

## Universal Incident Framework

Every incident follows: **Stop → Verify → Restore**

1. **Stop the bleeding** (2 min): Contain the damage. Feature flag off, revert deploy, pause queue.
2. **Verify truth** (5 min): What actually happened? Check logs, metrics, user reports.
3. **Restore safely** (varies): Fix forward or rollback. Verify fix. Communicate.

---

## Incident Templates

### Webhook Backlog

**Symptom:** Events piling up, processing delayed.

**Stop:**
- Check worker health and error rate
- Check for lock contention or lease issues
- Pause non-critical processing

**Verify:**
- Check provider API availability
- Check for schema changes in incoming events
- Review error logs for pattern (all failing? or specific types?)

**Restore:**
- Fix the root cause (schema, API, lock)
- Increase worker capacity if safe
- Process backlog in order
- Communicate delay to affected users if needed

---

### Double Charge Complaint

**Symptom:** Customer reports being charged twice.

**Stop:**
- Acknowledge the complaint
- Do NOT issue refund until diagnosis is complete

**Verify:**
- Locate all payment attempts for the customer (provider dashboard)
- Check idempotency keys — were duplicates sent?
- Check for timing: same second? minutes apart?
- Verify actual charges vs attempted charges

**Restore:**
- If duplicate: refund one charge via provider
- If not duplicate: explain the two charges to customer
- Add idempotency guard if missing
- Document the root cause

---

### Missing Access Complaint

**Symptom:** Customer paid but can't access features.

**Stop:**
- Verify payment in provider dashboard
- If payment confirmed: grant temporary access via override

**Verify:**
- Check entitlement grant records
- Check decision records for the customer
- Check webhook delivery (was it received? processed?)

**Restore:**
- Fix entitlement sync
- Verify all affected customers
- Add monitoring for payment → access delay

---

### Suspected Account Takeover

**Symptom:** Unusual activity, password changes, unauthorized access.

**Stop:**
- Revoke ALL sessions for the account
- Disable sensitive actions temporarily
- Block high-velocity login attempts from suspicious IPs

**Verify:**
- Audit timeline: login, recovery, passkey changes, role changes
- Look for unfamiliar devices + rapid action sequences
- Check if other accounts are affected

**Restore:**
- Require recovery with stronger verification
- Reset credentials
- Review memberships and roles
- Notify the user with clear next steps

---

### Lockout Storm

**Symptom:** Many users reporting lockout simultaneously.

**Stop:**
- Increase throttling thresholds temporarily
- Add friction (CAPTCHA) to login
- Protect recovery endpoints

**Verify:**
- Measure volume by identifier and IP
- Is this credential stuffing or a system bug?
- Confirm error messages are enumeration-safe

**Restore:**
- If attack: maintain friction, monitor, block IPs
- If bug: fix and unlock affected accounts
- Ensure real users can still recover

---

### Bulk Session Revocation (After Secret Leak)

**Symptom:** Credentials or secrets were exposed.

**Stop:**
- Revoke ALL sessions immediately
- Rotate all exposed secrets and tokens
- Invalidate refresh tokens

**Verify:**
- What secrets leaked? Where were they used?
- Which accounts were potentially impacted?
- Check audit logs for unusual activity during exposure window

**Restore:**
- Deploy new secrets to all services
- Reissue sessions (users must re-auth)
- Review audit trail for compromise indicators
- Post-incident communication to affected users

---

## Building Your Own Templates

For each critical service, create a template with:

1. **Symptom:** How you'll know it's happening
2. **Fast checks** (2 min): 3 things to check immediately
3. **Containment:** First action to stop damage
4. **Diagnosis:** Where to look for root cause
5. **Resolution:** Fix or rollback steps
6. **Verification:** How to confirm it's fixed
7. **Communication:** What to tell users

## Checklist

- [ ] Incident templates exist for critical failure modes
- [ ] Team knows where to find templates during incidents
- [ ] Templates have been practiced at least once
- [ ] Post-incident review completed within 48 hours
- [ ] Action items limited to 2 (more = nothing gets done)

## Low-Energy Mode

During an active incident: follow the Stop → Verify → Restore framework. Document later.
