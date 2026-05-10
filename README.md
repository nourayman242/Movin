# Movin — AI-Powered Real Estate Mobile App

> **Graduation Project** — A Flutter mobile application for buying, selling, and auctioning real estate properties in Egypt. Movin connects buyers and sellers on a single platform with intelligent features including AI-based property price estimation, live WebSocket auctions, interactive heatmaps, personalized property recommendations, a seller analytics dashboard, and real-time notifications.

---

## Features

###  Buyer Features
- Browse all recent property listings on the home screen
- **AI Price Estimator** — get an instant AI-generated price estimate for any property based on its features (location, area, type, rooms, etc.)
- **Personalized Recommendations** — properties suggested based on each user's favorites and search history
- View full property details with images, location on map, and seller contact
- **Contact the Seller** directly from the property detail screen
- **Favorite** any property and manage a favorites list
- **Join live auctions** and place real-time bids via WebSocket
- **Heatmap with filters** — visualize property density and pricing across locations
- Receive **push notifications** for auction updates, new listings, and messages

###  Seller Features
- Create, edit, and delete property listings with images and location
- **Seller Dashboard** — view total active listings, total views, inquiries, and conversion rate
- **Performance Chart** — line chart showing monthly property views over the last 6 months
- **Top Performing Listings** — see which properties get the most views
- Create an **auction** on any approved property
- Manage auction status (pending / approved / ended)

###  Shared Features
- **Dual role in one account** — switch between Buyer and Seller roles without logging out
- Onboarding flow for first-time users
- JWT authentication with automatic token refresh
- Profile management

---

## Table of Contents

- [Prerequisites and Dependencies](#prerequisites-and-dependencies)
- [Installation Steps](#installation-steps)
- [Build APK Instructions](#build-apk-instructions)
- [Compilation Steps](#compilation-steps)
- [Run Instructions](#run-instructions)
- [Environment Setup & Configuration](#environment-setup--configuration)
- [Project Structure](#project-structure)
- [Architecture Overview](#architecture-overview)

---

## Prerequisites and Dependencies

### System Requirements

| Requirement | Minimum |
|---|---|
| OS | Windows 10, macOS 12+, or Ubuntu 20.04+ |
| RAM | 8 GB (16 GB recommended) |
| Disk Space | At least 5 GB free (for Flutter SDK + dependencies) |
| Internet | Required (backend is hosted remotely) |

### Programming Language

- **Dart** `>=3.8.1 <4.0.0`

### Framework

- **Flutter** `>=3.22.0` (stable channel)

### Required Tools

| Tool | Purpose | Download |
|---|---|---|
| Flutter SDK | Build & run the app | https://docs.flutter.dev/get-started/install |
| Dart SDK | Included with Flutter | — |
| Android Studio or VS Code | IDE + device emulation | https://developer.android.com/studio |
| Xcode (macOS only) | iOS builds | Mac App Store |
| Git | Clone the repository | https://git-scm.com |
| Java JDK 17+ | Android builds | https://adoptium.net |

### Core Dependencies

The full dependency list lives in `pubspec.yaml`. Key packages are:

**State Management & UI**
- `flutter_bloc: ^9.1.1` — BLoC/Cubit state management
- `equatable: ^2.0.5` — Value equality for states
- `provider: ^6.1.5+1` — Lightweight state sharing
- `flutter_screenutil: ^5.9.3` — Responsive UI scaling
- `flutter_native_splash: ^2.4.7` — Splash screen

**Networking**
- `dio: ^5.4.0` — HTTP client with interceptors
- `retrofit: 4.4.1` — Type-safe REST API client
- `socket_io_client: ^3.1.4` — WebSocket for live auctions
- `json_annotation: ^4.8.1` — JSON serialization

**Storage**
- `shared_preferences: ^2.1.0` — Auth token persistence
- `hive: ^2.2.3` + `hive_flutter: ^1.1.0` — Local NoSQL storage

**Dependency Injection**
- `get_it: ^8.0.3` — Service locator
- `injectable: ^2.1.0` — DI code generation

**Maps & Media**
- `google_maps_flutter: ^2.14.2` — Property location maps
- `image_picker: ^1.2.1` — Property image upload
- `fl_chart: 0.68.0` — Seller views analytics chart
- `url_launcher: ^6.3.2` — External links

**Dev Dependencies**
- `build_runner: ^2.4.8`
- `injectable_generator: ^2.1.6`
- `retrofit_generator: 8.1.2`
- `hive_generator: ^2.0.1`
- `json_serializable: ^6.8.0`

### External Services

| Service | Purpose |
|---|---|
| `https://movin-backend-production.up.railway.app` | Main REST API + WebSocket backend |
| `https://movin-app.vercel.app` | Auth flows (forgot password, OTP, reset password) |
| Google Maps API | Property map display |

> **Note:** The backend is already deployed and publicly accessible. You do **not** need to run it locally.

---

## Installation Steps

### 1. Verify Flutter is installed

```bash
flutter --version
```

You should see Flutter `3.22.0` or later. If not, install it from https://docs.flutter.dev/get-started/install.

Also verify Flutter's environment is healthy:

```bash
flutter doctor
```

Fix any issues reported (especially Android SDK or Xcode if targeting those platforms) before continuing.

### 2. Clone the repository

```bash
git clone https://github.com/nourayman242/Movin.git
cd Movin
```

### 3. Install dependencies

```bash
flutter pub get
```

### 4. Run code generation

This project uses `build_runner` to generate DI, JSON serialization, and Retrofit code. You **must** run this before building:

```bash
dart run build_runner build --delete-conflicting-outputs
```

> If you make any changes to files annotated with `@injectable`, `@JsonSerializable`, or Retrofit annotations, re-run this command.

### 5. Add your Google Maps API Key

#### Android

Open `android/app/src/main/AndroidManifest.xml` and find the `<meta-data>` tag for Google Maps. Replace `YOUR_GOOGLE_MAPS_API_KEY` with your actual key:

```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_GOOGLE_MAPS_API_KEY" />
```

#### iOS

Open `ios/Runner/AppDelegate.swift` and add:

```swift
GMSServices.provideAPIKey("YOUR_GOOGLE_MAPS_API_KEY")
```

> To get a Google Maps API key, visit: https://console.cloud.google.com/ → Enable **Maps SDK for Android** and **Maps SDK for iOS**.
---

## Build APK Instructions

This section explains how to produce an installable Android APK from scratch — step by step.

### Prerequisites checklist before building

Make sure you have completed all steps in [Installation Steps](#installation-steps):

```bash
# 1. Confirm Flutter is ready
flutter doctor

# 2. Dependencies installed
flutter pub get

# 3. Code generation done
dart run build_runner build --delete-conflicting-outputs
```

---

### Option A — Debug APK (fastest, for testing on a device)

A debug APK is unsigned and intended for development and testing only. It includes debug symbols and is larger in size.

```bash
flutter build apk --debug
```

**Output file:**
```
build/app/outputs/flutter-apk/app-debug.apk
```

**Install directly on a connected Android device:**
```bash
adb install build/app/outputs/flutter-apk/app-debug.apk
```

Or copy the `.apk` file to your phone and open it (enable *Install from unknown sources* on the device under Settings → Security).

---

### Option B — Release APK (optimized, for sharing or distribution)

A release APK is minified, tree-shaken, and optimized. This is what you share with users or submit for review.

```bash
flutter build apk --release
```

**Output file:**
```
build/app/outputs/flutter-apk/app-release.apk
```

> **Note:** By default, Flutter signs the release APK with a debug keystore automatically so it can be installed. For production/Play Store distribution, configure a proper signing key (see Signing below).

---

### Option C — Split APKs by ABI (smaller file sizes)

Instead of one universal APK, Flutter can generate separate smaller APKs for each CPU architecture:

```bash
flutter build apk --split-per-abi --release
```

**Output files:**
```
build/app/outputs/flutter-apk/
├── app-arm64-v8a-release.apk    ← Most modern Android phones (use this one)
├── app-armeabi-v7a-release.apk  ← Older 32-bit devices
└── app-x86_64-release.apk       ← Android emulators
```

Install the correct variant on a real device:
```bash
adb install build/app/outputs/flutter-apk/app-arm64-v8a-release.apk
```

---

### Option D — App Bundle (for Google Play Store)

An `.aab` file is required for Play Store submission and is not directly installable:

```bash
flutter build appbundle --release
```

**Output file:**
```
build/app/outputs/bundle/release/app-release.aab
```

---

### Signing the Release APK (for Play Store or production)

By default the release APK uses Flutter's debug keystore. To sign it with your own key:

**Step 1 — Generate a keystore (run once):**
```bash
keytool -genkey -v -keystore ~/movin-release.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias movin
```

**Step 2 — Create `android/key.properties`:**
```properties
storePassword=YOUR_STORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=movin
storeFile=/absolute/path/to/movin-release.jks
```

**Step 3 — Reference it in `android/app/build.gradle`** inside the `android { }` block:
```groovy
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }
    buildTypes {
        release {
            signingConfig signingConfigs.release
        }
    }
}
```

**Step 4 — Build the signed APK:**
```bash
flutter build apk --release
```

>  Never commit `key.properties` or the `.jks` keystore file to version control. Add them to `.gitignore`.

---

### Quick Reference — All Build Commands

| Goal | Command | Output path |
|---|---|---|
| Debug APK | `flutter build apk --debug` | `build/app/outputs/flutter-apk/app-debug.apk` |
| Release APK | `flutter build apk --release` | `build/app/outputs/flutter-apk/app-release.apk` |
| Split APKs (smaller) | `flutter build apk --split-per-abi --release` | `build/app/outputs/flutter-apk/app-*-release.apk` |
| App Bundle | `flutter build appbundle --release` | `build/app/outputs/bundle/release/app-release.aab` |
| iOS (macOS only) | `flutter build ios --release --no-codesign` | Xcode → Product → Archive |


---

## Compilation Steps

### Android (APK for testing)

```bash
flutter build apk --debug
```

The output APK is at:
```
build/app/outputs/flutter-apk/app-debug.apk
```

### Android (Release APK)

```bash
flutter build apk --release
```

### Android (App Bundle for Play Store)

```bash
flutter build appbundle --release
```

### iOS (macOS only)

```bash
flutter build ios --release --no-codesign
```

> For a signed iOS build, open `ios/Runner.xcworkspace` in Xcode, configure your signing team, then archive from Xcode.

---

## Run Instructions

### Run on a connected device or emulator

First, confirm available devices:

```bash
flutter devices
```

Then run the app:

```bash
flutter run
```

To target a specific device:

```bash
flutter run -d <device-id>
```

### Run in debug mode (with hot reload)

```bash
flutter run --debug
```

### Run in release mode (best performance)

```bash
flutter run --release
```

### Install the pre-built APK directly on Android

```bash
adb install build/app/outputs/flutter-apk/app-debug.apk
```

---

## Environment Setup & Configuration

### Backend API

The app communicates with two hosted backends. Both are already live — no local server setup is needed.

| Variable | Value |
|---|---|
| Main API base URL | `https://movin-backend-production.up.railway.app` |
| Auth API base URL | `https://movin-app.vercel.app` |

These are hardcoded in `lib/data/api_services/client/network_module.dart`. If the backend URLs ever change, update them there.

### Authentication

The app uses **JWT tokens** stored via `SharedPreferences`. Tokens are automatically attached to every request by `AuthInterceptor` and refreshed when expired. No manual configuration is needed.

### Hive (Local Storage)

Hive is initialized automatically on app start in `main.dart`. The `PropertyModel` adapter is registered before the app runs. No manual database setup is required.

### Google Maps API Key

See the [Installation Steps → Add your Google Maps API Key](#5-add-your-google-maps-api-key) section above.

There is **no `.env` file** in this project. The only external configuration required is the Google Maps API key placed directly in the platform-specific manifest files as described above.

### Assets

All image assets are bundled in the `assets/` folder and declared in `pubspec.yaml`:

```
assets/
├── images/
│   ├── placeholder.webp
│   ├── building1.jpeg
│   ├── building2.jpeg
│   └── onboarding/
```

No additional asset setup is needed after cloning.

---

## Project Structure

```
lib/
├── main.dart                        # App entry point, BLoC providers, routing
├── app_theme.dart                   # Colors, spacing, theme constants
├── data/
│   ├── api_services/                # Dio services & interceptors
│   │   └── client/
│   │       ├── auth_interceptor.dart
│   │       └── network_module.dart  # Injectable DI module
│   ├── data_source/local/           # SharedPreferences & Hive helpers
│   ├── models/                      # JSON-serializable data models
│   └── repositories/               # Repository implementations
├── domain/
│   ├── entities/                    # Pure business objects
│   ├── repositories/               # Abstract repository interfaces
│   └── use_cases/                  # (if applicable)
├── presentation/
│   ├── home/                        # Buyer home screen
│   ├── seller_properties/           # Seller dashboard, listings, chart
│   ├── auction/                     # Live auction screens
│   ├── login/                       # Auth screens & cubits
│   ├── register/                    # Registration & email verification
│   ├── profile/                     # User profile
│   ├── fav_screen/                  # Favorites
│   ├── notifications/               # Push notifications
│   ├── settings/                    # App settings
│   └── onboarding/                  # Onboarding screens
└── data_injection/
    └── getIt/
        └── service_locator.dart     # get_it configuration
```

---

## Architecture Overview

Movin follows **Clean Architecture** with an **MVVM** presentation layer:

```
Presentation (Cubit/BLoC + Screens)
        ↕
Domain (Entities + Repository Interfaces)
        ↕
Data (Repository Implementations + API Services + Local Storage)
```

- **State management:** `flutter_bloc` (Cubits for most features, BLoCs for complex event-driven flows like notifications and favorites)
- **Dependency injection:** `get_it` + `injectable` with code generation
- **Networking:** `dio` with automatic JWT attachment and token refresh via `AuthInterceptor`
- **Real-time:** `socket_io_client` for live bidding in auctions
- **Code generation:** Run `build_runner` after any model or DI changes
