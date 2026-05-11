# Mechzo — Local setup

## Prerequisites

| Tool | Min version | Install |
|---|---|---|
| Flutter | 3.22+ | https://docs.flutter.dev/get-started/install/windows |
| Node.js | 20+ | https://nodejs.org (you have 24 ✅) |
| Python | 3.11+ | https://www.python.org/downloads/ (you have 3.14 ✅) |
| Docker Desktop | latest | https://www.docker.com/products/docker-desktop/ |
| Android Studio | latest | https://developer.android.com/studio (for Android emulator + SDK) |
| Git | any | already installed ✅ |

### Flutter install (Windows) — ~10 min

1. Download Flutter SDK zip from the official link above and extract to `C:\src\flutter` (avoid spaces in path).
2. Add `C:\src\flutter\bin` to your `PATH`.
3. Open a new PowerShell and run:
   ```powershell
   flutter --version
   flutter doctor
   ```
4. Resolve any red ✗ items `flutter doctor` reports — usually:
   - Install Android Studio + accept licenses (`flutter doctor --android-licenses`).
   - Install the Android SDK command-line tools from inside Android Studio → SDK Manager → SDK Tools.
5. Create an Android emulator:
   - Android Studio → Device Manager → Create Device → Pixel 7 + API 34.

## Repo setup

```powershell
# from c:\Users\Praneeth p\Downloads\mechzo
git init
git add .
git commit -m "chore: scaffold monorepo"
```

## Run the local data layer

```powershell
docker compose -f infra/docker/docker-compose.yml up -d
# brings up: postgres+postgis, redis
```

## Run the API

```powershell
cd services/api
npm install
cp .env.example .env       # fill in secrets
npx prisma migrate dev
npm run start:dev          # http://localhost:3000
```

## Run the customer app

The repo ships with all Dart source. On first run you need to generate the platform folders (Android / iOS / etc.) — Flutter's tooling does this safely without touching the `lib/` source:

```powershell
cd apps/customer_app
flutter create . --project-name mechzo_customer --org com.mechzo --platforms=android,ios
flutter pub get
flutter run                # picks the running emulator
```

Repeat for `apps/vira_app` (project name `mechzo_vira`) and `apps/garage_app` (project name `mechzo_garage`).

(Same command pattern for `vira_app` and `garage_app`.)

## Run the admin web

```powershell
cd apps/admin_web
npm install
npm run dev                # http://localhost:3001
```

## Run the ML service

```powershell
cd services/ml
python -m venv .venv
.venv\Scripts\Activate.ps1
pip install -r requirements.txt
uvicorn app.main:app --reload --port 8001
```

## Environment variables

Each service has a `.env.example` — copy to `.env` and fill. Secrets we'll need:
- `MSG91_AUTH_KEY`, `MSG91_OTP_TEMPLATE_ID`
- `RAZORPAY_KEY_ID`, `RAZORPAY_KEY_SECRET`, `RAZORPAY_WEBHOOK_SECRET`
- `GOOGLE_MAPS_API_KEY` (one for Android, one for iOS, one for backend)
- `AGORA_APP_ID`, `AGORA_APP_CERTIFICATE`
- `R2_ACCOUNT_ID`, `R2_ACCESS_KEY_ID`, `R2_SECRET_ACCESS_KEY`, `R2_BUCKET`
- `JWT_PRIVATE_KEY`, `JWT_PUBLIC_KEY` (RS256 keypair — generate with `openssl genrsa -out jwt.pem 2048`)
- `DATABASE_URL`, `REDIS_URL`
