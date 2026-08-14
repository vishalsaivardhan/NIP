# Development Setup

## Prerequisites
- Flutter SDK (beta/latest for material 3 and dart 3 features)
- Android Studio / Android SDK (minSdk 24 required for BLE edge features)
- Chrome (for UI testing)

## Running Locally
1. `flutter pub get`
2. Configure environment (Supabase credentials not required for Phase 1 - UI only).
3. `flutter run -d chrome` for UI rendering validation.
4. `flutter run -d <your_android_device>` to run on a physical Android device. (Required for BLE later).

*Warning: Emulators cannot emulate BLE effectively.*
