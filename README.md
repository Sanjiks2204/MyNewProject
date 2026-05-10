# Mechzo

> Trusted help, on the way.

Smart, hybrid roadside assistance platform connecting vehicle owners with verified garages, certified mechanics, and Verified Independent Repair Assistants (VIRA).

## Repository layout

```
mechzo/
├── apps/
│   ├── customer_app/        Flutter — vehicle owner mobile app
│   ├── vira_app/            Flutter — VIRA assistant mobile app
│   ├── garage_app/          Flutter — garage partner mobile/tablet app
│   └── admin_web/           Next.js — internal admin dashboard
├── services/
│   ├── api/                 NestJS — primary REST + WebSocket API
│   └── ml/                  FastAPI — Mechzo Predict ML service
├── packages/
│   ├── mechzo_design/       Shared Flutter design system (tokens, theme, components)
│   ├── mechzo_models/       Shared Dart data models
│   └── mechzo_api/          Shared Dart API client (Dio + generated clients)
├── infra/
│   └── docker/              Local dev compose; Terraform later
└── docs/                    Architecture, brand, roadmap, setup
```

## Documentation

- [docs/SETUP.md](docs/SETUP.md) — install Flutter, Node, run locally
- [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) — system design, data flow, services
- [docs/BRAND.md](docs/BRAND.md) — design tokens, motion, voice
- [docs/ROADMAP.md](docs/ROADMAP.md) — phased delivery plan

## Stack at a glance

| Layer | Tech |
|---|---|
| Mobile (3 apps) | Flutter 3.x + Dart, Riverpod, GoRouter |
| Web admin | Next.js 14 + Tailwind + shadcn/ui |
| Backend API | NestJS (TypeScript) + Prisma |
| ML service | FastAPI (Python) + scikit-learn |
| Database | PostgreSQL 16 + PostGIS |
| Cache + queues | Redis + BullMQ |
| Realtime | Socket.IO |
| Storage | Cloudflare R2 (S3-compatible) |
| Auth | Phone OTP via MSG91 + JWT |
| Payments | Razorpay |
| Maps | Google Maps Platform |
| Video (LiveFix) | Agora |
| Hosting | AWS Mumbai (ECS + RDS + ElastiCache) |
| CI/CD | GitHub Actions + Docker + Terraform |

## Status

Phase 0 — foundations. See [docs/ROADMAP.md](docs/ROADMAP.md).
