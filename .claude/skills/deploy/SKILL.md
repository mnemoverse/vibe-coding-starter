---
name: deploy
description: Deployment & operations workflows. Use when deploying, writing runbooks, creating on-call policies, handling postmortems, or planning rollbacks.
argument-hint: "[service-name or deployment-context]"
---

# Deployment & Operations

## When to Use

- Deploying to staging or production
- Writing deploy playbooks or runbooks
- Planning rollback strategy
- Creating on-call policies
- Writing postmortems after incidents
- Preparing production readiness reviews

## Deploy Playbook

### Pre-Deploy

1. All tests pass (`npm test`)
2. Build succeeds (`npm run build`)
3. Smoke tests defined for post-deploy
4. Rollback plan documented
5. Team notified

### Deploy Sequence

1. **Migrations first** (if any)
   - Run migrations against staging DB
   - Verify data integrity
   - Never deploy code before migrations complete
2. **Deploy to staging**
   - Run smoke tests
   - Verify no regression
3. **Deploy to production**
   - Monitor error rates for 15 minutes
   - Run production smoke tests
   - Declare success or rollback

### Post-Deploy

- [ ] Smoke test: auth flow works
- [ ] Smoke test: core CRUD operations
- [ ] Smoke test: one integration point
- [ ] Error rate normal
- [ ] No new console errors
- [ ] Health endpoint returns 200

## Rollback Plan

Before every deploy, know how to undo it:

1. **Code rollback:** Previous version tag/commit, deploy command
2. **Migration rollback:** Down migration ready and tested
3. **Data rollback:** Backup taken before migration
4. **Communication:** Template message for users if needed

**Rule:** If rollback takes longer than 5 minutes to execute, simplify your deploy.

## Runbook Template

For each critical service, document:

```markdown
## [Service Name] Runbook

### Symptom
[What the alert or user report looks like]

### Fast Checks (2 min)
1. Check health endpoint
2. Check error rate dashboard
3. Check recent deploys

### Containment (5 min)
1. [First action to stop the bleeding]
2. [Second action if first doesn't help]

### Diagnosis (15 min)
1. Check logs for [specific pattern]
2. Check database for [specific query]
3. Check external services for [specific API]

### Fix Forward
[Steps to fix without rollback]

### Rollback
[Steps to revert to last known good state]

### Verification
[How to confirm the fix worked]

### Post-Incident
[What to document, who to notify]
```

## Production Readiness Review

One-page review before major releases:

| Section | Content |
|---------|---------|
| **Changes** | What's new, what changed |
| **Top Risks** | 3 things most likely to go wrong |
| **Evidence** | Test results, staging verification |
| **Rollback** | How to undo, time estimate |
| **Monitoring** | What signals to watch |

## Postmortem Template

After incidents:

```markdown
## Summary
[One paragraph: what happened, impact, duration]

## Timeline
- HH:MM — [Event]
- HH:MM — [Detection]
- HH:MM — [Response]
- HH:MM — [Resolution]

## Root Cause
[Technical explanation]

## What Worked
- [Detection, response, teamwork]

## What Failed
- [Gaps in monitoring, process, knowledge]

## Action Items (max 2)
1. [Prevention measure]
2. [Detection improvement]
```

**Rule:** Blameless. Limit to 2 action items (more = nothing gets done).

## On-Call Policy

For small teams:

| Severity | Example | Response | Quiet Hours |
|----------|---------|----------|-------------|
| **Sev 1** | Service down, data loss | Immediate (15 min) | Wake up |
| **Sev 2** | Degraded, workaround exists | 1 hour | Next morning |
| **Sev 3** | Minor, cosmetic | Next business day | Ignore |

**Quiet hours rule:** Only Sev 1 pages during nights/weekends.

## Rescue Mode

When everything is on fire (10-minute plan):

1. **Contain** (2 min): Stop the bleeding. Disable feature flag, revert deploy, pause processing.
2. **Assess** (3 min): What's broken? Who's affected? What are the top 3 signals?
3. **Act** (3 min): Rollback or fix forward. Pick one.
4. **Communicate** (2 min): Status message to affected users.

## Data Safety Baseline

- [ ] Automated backups configured and tested
- [ ] Restore procedure documented and practiced
- [ ] Migration workflow includes backup step
- [ ] Undo stories for top 3 data risks (accidental delete, corruption, wrong migration)

## Checklist

- [ ] Deploy playbook exists and is tested
- [ ] Rollback plan documented and rehearsed
- [ ] Runbooks exist for critical services
- [ ] On-call policy defined
- [ ] Postmortem template available
- [ ] Data backups verified

## Low-Energy Mode

Write the rollback plan only. One paragraph: what to revert, how, who to notify.
