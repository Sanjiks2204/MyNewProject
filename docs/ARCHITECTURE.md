# Mechzo — Architecture

## High-level system

```
┌──────────────────┐  ┌──────────────────┐  ┌──────────────────┐  ┌──────────────────┐
│   Customer App   │  │     VIRA App     │  │   Garage App     │  │   Admin Web      │
│    (Flutter)     │  │    (Flutter)     │  │    (Flutter)     │  │   (Next.js)      │
└────────┬─────────┘  └────────┬─────────┘  └────────┬─────────┘  └────────┬─────────┘
         │                     │                     │                     │
         └─────────────────────┴──────── HTTPS ──────┴─────────────────────┘
                                          │
                              ┌───────────▼─────────────┐
                              │    API Gateway (ALB)    │
                              └───────────┬─────────────┘
                                          │
                              ┌───────────▼─────────────┐
                              │  NestJS API (ECS)       │
                              │  REST + Socket.IO       │
                              └─┬─┬─┬─┬─┬─┬─────────────┘
                                │ │ │ │ │ │
              ┌─────────────────┘ │ │ │ │ └──────────────┐
              │                   │ │ │ │                │
       ┌──────▼──────┐  ┌─────────▼─▼─┴─▼─────┐  ┌──────▼─────┐
       │  Postgres   │  │  Redis + BullMQ      │  │ FastAPI ML │
       │  + PostGIS  │  │  (cache, queues,     │  │  (Predict) │
       │   (RDS)     │  │   pub/sub)           │  │  (ECS)     │
       └─────────────┘  └──────────────────────┘  └────────────┘
                                  │
                  ┌───────────────┼─────────────────┐
                  │               │                 │
            ┌─────▼─────┐  ┌──────▼─────┐  ┌────────▼────────┐
            │ Razorpay  │  │   Agora    │  │   MSG91 / FCM   │
            │ (payments)│  │ (LiveFix)  │  │ (OTP/SMS/Push)  │
            └───────────┘  └────────────┘  └─────────────────┘
                  │
            ┌─────▼─────────────┐
            │  Cloudflare R2    │
            │  (KYC docs, photos)│
            └────────────────────┘
```

## Service responsibilities

### `services/api` — NestJS
Authoritative REST + WebSocket API. Modules:
- `auth` — OTP issuance/verification, JWT access+refresh, session revocation.
- `users` — Customer / VIRA / Garage profiles, KYC state machine.
- `jobs` — Service request lifecycle: created → matched → en-route → on-site → completed.
- `vira` — VIRA verification workflow, ratings, availability heartbeat.
- `garage` — Garage onboarding, queue capacity, accept/reject jobs.
- `payments` — Razorpay orders, webhooks, splits, refunds.
- `notifications` — push (FCM), SMS/WhatsApp (MSG91) fanout.
- `realtime` — Socket.IO gateway for live tracking + status.

### `services/ml` — FastAPI
Async-only. Consumes job + vehicle history events from Redis stream. Returns predictions through the API. Out-of-band — never on the customer hot path.

### `apps/customer_app` — Flutter
End-user vehicle owner. Request flow, live tracking, payments, ratings, vehicle profile.

### `apps/vira_app` — Flutter
VIRA assistant. Onboarding + KYC, availability toggle, job acceptance, navigation, completion + photos.

### `apps/garage_app` — Flutter
Garage partner. Queue management, accept/reject, dispatch internal mechanic, service status updates.

### `apps/admin_web` — Next.js
Mechzo internal team. KYC review queue, dispute resolution, analytics, supply ops.

## Data flow — request lifecycle

```
1. Customer taps "Get help"
2. App posts /jobs (location, vehicle, problem, photos)
3. API persists Job (status=created), enqueues "match" job in BullMQ
4. Match worker:
   a. Query PostGIS: garages within 5 km, ranked by load + rating
   b. Offer to garage queue (Socket.IO + push). Wait 30s for accept.
   c. On reject/timeout: query PostGIS for online VIRA within 8 km, ranked by rating + recency
   d. Offer to VIRA. Wait 30s.
   e. Repeat until accepted or no providers — surface graceful fallback to customer
5. Provider accepts → Job status=matched. Customer notified, tracking starts.
6. Provider en route → Socket.IO heartbeat updates location every 5s
7. Provider arrives → status=on_site
8. Service done → status=completed, payment intent created (Razorpay), customer pays
9. Both rate each other → ratings persisted, payouts queued (T+1 settlement)
```

## Auth model

- Phone OTP via MSG91 → access token (15 min) + refresh token (30 d, rotating).
- Tokens are JWT signed with RS256; public key cached on device for offline verify of tile signing.
- Sessions tracked in Redis; revocable per-device.
- Role-based: `customer` | `vira` | `garage_admin` | `garage_mechanic` | `mechzo_admin` | `mechzo_ops`.

## Realtime

- Socket.IO (Redis adapter) for fan-out across API instances.
- Channels: `job:{jobId}`, `user:{userId}`.
- Events: `job.status`, `provider.location`, `chat.message`.

## Geospatial

- Postgres + PostGIS for nearest-provider queries.
- `providers_live_location` table updated via heartbeat; old rows pruned in cron.
- GiST index on `geom` column.

## Queues (BullMQ)

| Queue | Purpose | Concurrency |
|---|---|---|
| `match` | Find + offer to providers | 8 |
| `notifications` | Send push/SMS | 16 |
| `payouts` | Settle VIRA + garage earnings | 4 |
| `kyc` | Run background-check vendor calls | 2 |
| `predict` | Trigger ML inference | 4 |

## Environments

| Env | Purpose |
|---|---|
| `local` | Docker compose: postgres+postgis, redis. API + apps run on host. |
| `dev` | AWS Mumbai, single AZ, smaller instances. Auto-deploy from `main`. |
| `staging` | Production-like, single AZ. Manual deploy from release branches. |
| `prod` | Multi-AZ, RDS Multi-AZ, ElastiCache replica. Tag-based deploys. |

## Security baseline (v1)

- TLS everywhere (ALB + ACM).
- Secrets in AWS Secrets Manager; never in env files.
- DB at-rest encryption (RDS default).
- KYC docs: per-object server-side encryption; signed-URL access; 90-day retention before archival.
- Rate limit: 100 req/min/IP at ALB; 30 req/min/phone for OTP.
- Audit log: all KYC approvals/rejections, payment refunds, role changes.
