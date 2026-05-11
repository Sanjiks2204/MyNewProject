# Mechzo Brand & Design System

> Trusted help, on the way.

## Personality

| We are | We are not |
|---|---|
| Calm, confident, capable | Loud, anxious, alarmist |
| Warm and human | Sterile or robotic |
| Premium and considered | Cheap or utilitarian |
| Fast and decisive | Hesitant or apologetic |

Reference brands for feel: **Razorpay**, **Cred**, **Revolut**, **Linear**. Reference brands we explicitly avoid: typical "service-app" red/yellow utility-feel.

## Voice

- Short sentences. Active voice.
- "Help is on the way." not "Your service request has been processed."
- Numbers are concrete. "Arrives in 6 min" not "arriving soon."
- We never panic. Even in SafeRide emergencies, copy is calm and directive.

## Color palette

| Token | Hex | Use |
|---|---|---|
| `ink.900` | `#0A1628` | Primary text, headlines, primary buttons |
| `ink.700` | `#1F2D45` | Surface (dark mode), strong UI |
| `ink.500` | `#5A6478` | Secondary text |
| `ink.300` | `#A8B0BD` | Tertiary text, disabled |
| `ink.100` | `#E4E8EE` | Borders, dividers |
| `ink.050` | `#F4F6FA` | Subtle background |
| `surface` | `#FFFFFF` | Default card / page surface |
| `coral.500` | `#FF5A4E` | **Primary accent** — CTAs, urgency, brand mark |
| `coral.100` | `#FFE5E2` | Tinted background for coral elements |
| `mint.500` | `#00C896` | Success, "arrived", "completed" |
| `mint.100` | `#D6F7EC` | Success backgrounds |
| `amber.500` | `#FFB02E` | In-progress, warnings |
| `crimson.500` | `#E53935` | Errors, SOS |

**Why this palette:** midnight ink communicates trust + professionalism (banking, fintech feel). Signal coral is warm and assertive without being alarmist red. Mint gives a fresh, modern success state. Together: trustworthy, modern, distinct from the red/yellow sea of service apps.

## Typography

- **Display / headings:** Plus Jakarta Sans, weights 600–800
- **UI / body:** Inter, weights 400–600
- **Numerals:** Inter tabular figures for prices, ETAs, counts

| Style | Size | Weight | Line height | Letter spacing |
|---|---|---|---|---|
| Display L | 40 | 800 | 1.1 | -0.03em |
| Display M | 32 | 700 | 1.15 | -0.02em |
| Heading L | 24 | 700 | 1.25 | -0.01em |
| Heading M | 20 | 700 | 1.3 | -0.01em |
| Title | 16 | 600 | 1.4 | 0 |
| Body | 14 | 400 | 1.5 | 0 |
| Label | 13 | 600 | 1.4 | 0 |
| Caption | 12 | 500 | 1.4 | 0.01em |

## Spacing scale

`2, 4, 8, 12, 16, 20, 24, 32, 40, 56, 80` — use multiples of 4. Never invent in-between values.

## Radii

`4 (xs), 8 (s), 12 (m), 16 (l), 20 (xl), 24 (2xl), 999 (pill)` — default card radius is 16; default button radius is 12.

## Elevation

Soft, multi-layer shadows. Never harsh.

| Level | Shadow |
|---|---|
| `e0` | none — flush UI |
| `e1` | `0 1 2 rgba(10,22,40,0.04), 0 1 1 rgba(10,22,40,0.02)` |
| `e2` | `0 4 12 rgba(10,22,40,0.06), 0 2 4 rgba(10,22,40,0.03)` |
| `e3` | `0 12 28 rgba(10,22,40,0.10), 0 4 8 rgba(10,22,40,0.04)` |
| `e4` | `0 24 48 rgba(10,22,40,0.14), 0 8 16 rgba(10,22,40,0.06)` |

## Motion

| Token | Duration | Curve | Use |
|---|---|---|---|
| `micro` | 120ms | `easeOut` | Hover, press feedback |
| `quick` | 200ms | `easeOutCubic` | Toggles, small reveals |
| `default` | 280ms | `easeOutCubic` | Most transitions |
| `expressive` | 420ms | spring (stiffness 280, damping 24) | Hero, sheet, page transitions |
| `dramatic` | 640ms | spring (stiffness 160, damping 22) | First-load reveals, success states |

**Principles:**
1. **Every motion has meaning.** No animation for animation's sake.
2. **Spring over linear.** UI feels alive, not mechanical.
3. **Stagger lists.** 40ms between items, max 8 items, fade + 8px translate.
4. **Hero on identity.** Vehicle marker, status pill, CTA — these animate across screens.
5. **Reduce motion respected.** Always honor system preference.

## Iconography

- Phosphor Icons (regular + duotone variants)
- Stroke weight: 1.5px at 24px size
- Custom illustrations: Rive (preferred) or layered SVG, flat with one accent gradient

## Imagery

- No stock photos of mechanics in overalls.
- Vehicle silhouettes and breakdown scenarios as **custom illustrations** in our palette.
- Real photos only for VIRA/garage profile photos, captured in good light.

## Dark mode

Every screen has a dark variant. Surfaces shift to `ink.900` with cards on `ink.700`; coral accent unchanged; text inverts to `ink.050`/`ink.100`.

## Accessibility

- Minimum text contrast 4.5:1.
- Touch targets ≥ 44×44 pt.
- All actions reachable without color (icon + label).
- Dynamic type respected up to 200%.
