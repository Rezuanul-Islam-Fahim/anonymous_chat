# Flutter Project Upgrade Notes

This document outlines all the changes made to upgrade this Flutter project from an old version to be compatible with the latest Flutter SDK.

## Summary of Changes

### 1. Dart SDK & Dependencies (pubspec.yaml)

#### Dart SDK
- **Old**: `sdk: ">=2.7.0 <3.0.0"`
- **New**: `sdk: ^3.5.0`

#### Major Dependency Updates
- `cupertino_icons`: ^0.1.2 → ^1.0.8
- `firebase_core`: ^0.5.3 → ^4.1.1
- `firebase_auth`: ^0.18.4+1 → ^6.1.0
- `cloud_firestore`: ^0.14.4 → ^6.0.2
- `firebase_storage`: ^4.0.1 → ^13.0.2
- `shared_preferences`: ^0.5.12+4 → ^2.3.2
- `image_picker`: ^0.6.7+17 → ^1.1.2
- `email_validator`: ^1.0.5 → ^3.0.0
- `flushbar`: ^1.10.4 → `another_flushbar`: ^1.12.30 (package replacement)
- `cached_network_image`: ^2.4.1 → ^3.4.1
- `flutter_lints`: ^6.0.0 (added)

### 2. Android Configuration Updates

#### android/build.gradle
- Kotlin version: 1.3.50 → 2.0.21
- Gradle plugin: 3.5.0 → 8.7.2
- Replaced deprecated `jcenter()` with `mavenCentral()`
- Updated Firebase dependencies to latest versions
- google-services: 4.3.4 → 4.4.2
- firebase-crashlytics-gradle: 2.3.0 → 3.0.2
- firebase-perf-plugin: 1.3.4 → 1.4.2

#### android/app/build.gradle
- Added `namespace` declaration (required for AGP 8.0+)
- compileSdkVersion: 28 → compileSdk: 35
- minSdkVersion: 16 → minSdk: 23
- targetSdkVersion: 28 → targetSdk: 35
- Updated Firebase BOM: 26.1.1 → 33.5.1
- Replaced deprecated `compile` with `implementation`
- Updated multidex: com.android.support:multidex:1.0.3 → androidx.multidex:multidex:2.0.1

#### android/gradle/wrapper/gradle-wrapper.properties
- Gradle version: 5.6.2 → 8.10

#### android/settings.gradle
- Completely rewritten to use new plugin management syntax
- Added Flutter plugin loader configuration

#### android/gradle.properties
- Increased JVM memory: 1536M → 4096M
- Added Kotlin daemon options
- Removed deprecated `android.enableR8`
- Added `android.nonTransitiveRClass=true`
- Added `android.defaults.buildfeatures.buildconfig=true`
- Added `android.nonFinalResIds=false`

### 3. Dart Code Migration to Null Safety

#### Key Changes Across All Files:
- Replaced `@required` annotations with `required` keyword
- Added null safety operators (`?`, `!`, `??`)
- Updated function signatures for null safety
- Fixed deprecated API usages

#### Specific File Updates:

**lib/models/user.dart & message.dart**
- All constructor parameters now use `required` keyword

**lib/services/auth/auth.dart**
- Removed unused `flutter/foundation.dart` import
- Updated all `@required` to `required`
- Added null checks for `User?` type
- Fixed `SharedPreferences` getString null safety

**lib/services/database.dart**
- Made `uid` and `collectionRef` nullable
- Added `id` parameter to `UserM` constructor

**lib/components/flush_message.dart**
- Updated import: `flushbar` → `another_flushbar`
- Made `title` nullable
- Fixed `BorderRadius.circular()` usage
- Removed deprecated cascade operator usage

**lib/components/general_button.dart**
- Replaced deprecated `RaisedButton` with `ElevatedButton`
- Updated styling to use `ElevatedButton.styleFrom()`

**lib/screens/chat/chat.dart**
- Made `userData` nullable (`UserM?`)
- Updated image picker: `getImage()` → `pickImage()`
- Fixed Firebase Storage API:
  - `StorageReference` → `Reference`
  - `StorageUploadTask` → `UploadTask`
  - `StorageTaskSnapshot` → `TaskSnapshot`
  - Simplified async/await pattern for upload
- Added null checks throughout

**lib/screens/settings/components/alert_dialogue.dart**
- Replaced deprecated `FlatButton` with `TextButton`
- Updated button styling

**lib/common.dart**
- Updated validator signatures: `(String value)` → `(String? value)`
- Added null checks in validators

**All input field components**
- Updated validators to handle nullable strings

**All form components**
- Added null assertion operator for `formKey.currentState!.validate()`

**lib/screens/chat/components/send_area.dart & message_input_field.dart**
- Changed `Function` types to proper `VoidCallback` types

**lib/screens/settings/components/link.dart**
- Changed `Function` to `VoidCallback`

**lib/services/auth/auth_navigation.dart**
- Added `required` to all constructor parameters

**lib/theme.dart**
- Fixed deprecated theme properties
- Updated `AppBarTheme` to use new properties
- Replaced `.withOpacity()` with `.withValues(alpha:)`

**lib/components/circular_loader.dart**
- Updated `.withOpacity()` to `.withValues(alpha:)`

### 4. Additional Files Created

**analysis_options.yaml**
- Added Flutter lints configuration
- Disabled certain strict rules for existing codebase compatibility

**UPGRADE_NOTES.md**
- This documentation file

## Breaking Changes to Be Aware Of

1. **Minimum Android SDK**: Now requires Android 6.0 (API 23) or higher
2. **Null Safety**: All code must handle null values explicitly
3. **Firebase**: Major version updates may require Firebase project configuration updates
4. **Image Picker**: API changed significantly, now returns `XFile?` instead of `PickedFile`
5. **Material Widgets**: Several deprecated widgets replaced (RaisedButton, FlatButton, etc.)

## Next Steps

1. **Test thoroughly**: Run the app and test all features
2. **Update Firebase configuration**: Ensure your Firebase project is up to date
3. **Check iOS configuration**: May need similar updates for iOS platform
4. **Review deprecated warnings**: Run `flutter analyze` to check for any remaining issues
5. **Update documentation**: Update README.md if needed

## Running the App

```bash
# Get dependencies
flutter pub get

# Run on device/emulator
flutter run

# Build for release
flutter build apk # For Android
flutter build ios # For iOS
```

## Potential Issues to Watch For

1. Firebase authentication flows may behave slightly differently
2. Image upload functionality should be tested thoroughly
3. Check app permissions in AndroidManifest.xml
4. Verify all async operations handle errors properly

## Useful Commands

```bash
# Clean build
flutter clean
flutter pub get

# Analyze code
flutter analyze

# Format code
dart format .

# Run tests (if any)
flutter test
```
