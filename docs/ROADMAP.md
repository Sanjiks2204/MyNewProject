# Mechzo — Roadmap

Target public launch: **late 2026**, Bengaluru, Android-first.

## Phase 0 — Foundations  (Weeks 1–2)

- [x] Tech stack decided
- [x] Brand + design system v1
- [x] Repo + monorepo scaffold
- [ ] Figma design system file (tokens mirrored from `mechzo_design`)
- [ ] AWS account, Terraform baseline (VPC, ECR, secrets)
- [ ] CI/CD: GitHub Actions for API, web, Flutter builds
- [ ] Legal: T&C, Privacy, VIRA agreement, customer agreement (counsel needed)
- [ ] Insurance partner shortlist + first conversations

## Phase 1 — MVP core  (Weeks 3–12)

**Customer app**
- Onboarding + phone OTP auth
- Vehicle profile (make, model, plate, fuel)
- "Get help" flow: location, problem category, photos, description
- Live tracking (provider location, ETA, status)
- In-app chat with provider
- Razorpay payment + receipt
- Rate provider, rate experience

**VIRA app**
- Onboarding + KYC (DigiLocker, skill cert upload, selfie liveness)
- Availability toggle (online / offline)
- Job offer modal (30s decision window)
- Navigation handoff to Google Maps
- "Arrived" → "Started" → "Completed" with required photos
- Earnings ledger + payout history

**Garage app**
- Onboarding (single admin user per garage)
- Capacity & hours configuration
- Queue dashboard, accept/reject
- Dispatch to internal mechanic (sub-users)

**Admin web**
- KYC review queue (approve/reject with reasons)
- Live job map (ops view)
- User search + freeze account
- Basic dashboards (jobs/day, conversion, NPS)

**API**
- All modules from `ARCHITECTURE.md` (auth, users, jobs, vira, garage, payments, notifications, realtime)
- Match worker, payout worker, KYC worker
- Idempotency on payment + job-state transitions

**Goal:** internal closed beta by week 12 in Bengaluru with 10 VIRAs, 5 garages, 50 invited customers.

## Phase 2 — Trust & differentiators  (Weeks 13–18)

- **PartsView** — parts catalog ingestion (start with top 200 SKUs across top 10 vehicle models), OEM vs aftermarket comparison UI
- **LiveFix** — Agora video session, expert pool onboarding, in-app booking + post-call summary
- **Verification v2** — DigiLocker eKYC live, automated background check via vendor (e.g., AuthBridge / IDfy), periodic revalidation cron
- **WhatsApp notifications** (MSG91 WhatsApp Business)
- **In-app chat** with media attachments
- **Insurance** integration (claim assistance flow)

**Goal:** public soft launch in 2 zones of Bengaluru.

## Phase 3 — Intelligence & safety  (Weeks 19–24)

- **Mechzo Predict** — service-history ingestion, baseline model (XGBoost), reminder UX
- **SafeRide** — SOS button, 3 trusted contacts, location share link, optional companion request, integration with state emergency number
- **Loyalty + referrals**

**Goal:** scale to 5+ cities in Karnataka.

## Phase 4 — Scale & ops  (ongoing)

- iOS launch
- Performance pass (cold start < 2s, p95 API < 200ms)
- Multi-language: Kannada, Hindi, Tamil, Telugu
- Fraud detection on jobs + payouts
- Supply-side growth tools (VIRA referral program)

## Risks tracked

| Risk | Mitigation |
|---|---|
| Two-sided cold start | 4-week pre-launch supply push (target 100 VIRAs + 30 garages before customer launch) |
| KYC bottleneck | Auto-verify DigiLocker; manual review only on edge cases; staff 2 ops reviewers |
| VIRA service quality variance | Mandatory rating after every job; auto-suspend below 4.0 over 10 jobs |
| Payment disputes | Razorpay dispute API + admin-side resolution UI |
| Regulatory (motor service) | Counsel review of VIRA agreement + insurance cap before public launch |
