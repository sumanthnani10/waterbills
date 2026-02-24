# Firebase config – standard approach

Use **config files**, not hardcoded values in `main.dart`. The **real** options files are in `.gitignore`; only `.example` templates are committed.

**Setup after clone:** Copy `lib/firebase_options.dart.example` → `lib/firebase_options.dart` and `lib/firebase_options_netadmin.dart.example` → `lib/firebase_options_netadmin.dart`, then fill in from Firebase Console (or run `dart run flutterfire configure` to generate the default one).

---

## Option 1: FlutterFire CLI (recommended)

One command generates and keeps config in sync for all platforms.

### 1. Install and run

```bash
cd /path/to/waterbills
dart run flutterfire configure
```

(Or install globally: `dart pub global activate flutterfire_cli` then run `flutterfire configure`.)

- Sign in to Firebase if asked.
- Pick your **default** Firebase project (e.g. `waterbills-3282e`).
- Choose platforms (Android, iOS, Web, etc.).

This will:

- Create or update `lib/firebase_options.dart` with `DefaultFirebaseOptions`.
- Create or update `android/app/google-services.json` and `ios/Runner/GoogleService-Info.plist` for the default app.

### 2. Use it in code

In `main.dart`:

```dart
import 'firebase_options.dart';

await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```

No API keys or project IDs in `main.dart`; everything comes from `firebase_options.dart` (and native files).

### 3. Second Firebase app ("netadmin")

FlutterFire configures **one** project per run. For your second app (`netadmin` / `sumanthnet-13082020`), use a separate options file:

- Keep `lib/firebase_options_netadmin.dart` with the netadmin `FirebaseOptions` (see existing file in this project).
- In `main.dart`, after initializing the default app, call:

  ```dart
  await Firebase.initializeApp(
    name: 'netadmin',
    options: NetadminFirebaseOptions.options,
  );
  ```

You can regenerate the netadmin options from Firebase Console (Project settings → Your apps → SDK setup) and paste into `firebase_options_netadmin.dart`. Optionally add `firebase_options_netadmin.dart` to `.gitignore` if you don’t want that project’s config in the repo.

---

## Option 2: Native config only (no FlutterFire)

- **Android:** Add `android/app/google-services.json` (download from Firebase Console → Project settings → Your apps).
- **iOS:** Add `ios/Runner/GoogleService-Info.plist` (same place).
- **Web:** Configure Firebase in `web/index.html` (Firebase JS SDK `initializeApp` config).

Then in `main.dart`:

```dart
// Default app – no options; read from native config
await Firebase.initializeApp();

// Second app – options from a Dart config file (e.g. firebase_options_netadmin.dart)
await Firebase.initializeApp(
  name: 'netadmin',
  options: NetadminFirebaseOptions.options,
);
```

On **web**, the default app still needs config (e.g. in `index.html`); native files are used only on Android/iOS.

---

## Security notes

- **Client config** (API key, project ID, app ID in `firebase_options.dart` or native files) is treated as public; security is enforced by **Firebase Security Rules** and **API key restrictions** in Google Cloud Console.
- Restrict API keys by app package name (Android), bundle ID (iOS), and HTTP referrer (web).
- Never commit **server** credentials (e.g. service account JSON) or **secret** keys; use env vars or secret managers for backend/CI.

---

## Summary

| What              | Standard approach                          |
|-------------------|--------------------------------------------|
| Default app       | `flutterfire configure` → `firebase_options.dart` + native files |
| Second app        | Separate `firebase_options_netadmin.dart` (or gitignored)        |
| Values in code    | None; all in config files                 |
| Repo safety       | Optional: gitignore `firebase_options_netadmin.dart` if you don’t want that project in repo |
