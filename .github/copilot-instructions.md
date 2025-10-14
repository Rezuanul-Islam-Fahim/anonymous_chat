# Anonymous Chat - AI Coding Agent Instructions

## Project Overview
Flutter-based real-time chat application using Firebase (Auth, Firestore, Storage) targeting Android, iOS, and Web. Built with **Material Design** using **StatefulWidget + setState** (no state management library). Firebase handles backend while SharedPreferences stores local session data.

## Architecture & Critical Patterns

### Service Layer Architecture
Business logic lives in `lib/services/`, organized by concern:
- **`services/auth/auth.dart`**: All authentication operations (login, register, changePassword, logout)
- **`services/auth/auth_exception.dart`**: Firebase error code → user-friendly messages + `AuthResultStatus` enum
- **`services/auth/auth_navigation.dart`**: Post-auth navigation logic with success/error toasts via FlushMessage
- **`services/database.dart`**: Firestore CRUD operations via constructors: `DatabaseService.userId(uid)` for user ops, `.toCollection(name)` for message ops
- **`services/responsive.dart`**: Screen size utilities for responsive layouts (web support via max-width constraints)

**Key Pattern**: Services use static methods or named constructors, not dependency injection. Example:
```dart
// Auth check
AuthService.isLoggedIn // Static getter
AuthService.login(email: ..., password: ...) // Static method returning Future<AuthResultStatus>

// Database ops
DatabaseService.userId(uid).getUserData() // Named constructor for user context
DatabaseService.toCollection('messages').storeMessage(...) // Named constructor for collection
```

### State Management Convention
**No BLoC, Provider, or Riverpod** - exclusively `StatefulWidget` with `setState()`:
- Loading states: `bool isLoading` flag + conditional `Loader` widget overlay
- Data fetching: `Future<void>` methods called in `initState()` or button handlers
- Real-time data: `StreamBuilder` directly wrapping Firestore `.snapshots()`
- Forms: `TextEditingController` + `GlobalKey<FormState>` for validation

### Authentication Flow Pattern
**Three-step pattern** used across login/register/changePassword:
1. Set loading state: `setState(() => isLoading = true)`
2. Call service: `AuthService.{operation}(...)`
3. Navigate with status: `AuthNavigation(...).navigate(context)` handles both success/error cases

Example from `screens/login/login.dart`:
```dart
Future<void> login(BuildContext context) async {
  setState(() => isLoading = true);
  AuthNavigation(
    status: await AuthService.login(email: ..., password: ...),
    successMessage: 'Successfully Logged In',
    errorMessageTitle: 'Login Failed',
    navigationScreen: ChatScreen(),
  ).navigate(context);
  setState(() => isLoading = false);
}
```

### Data Models
Simple immutable classes in `lib/models/`:
- **`UserM`** (not `User` - avoids Firebase Auth conflict): `id`, `name`, `email`
- **`Message`**: `text`, `fromName`, `fromEmail`, `timendate` (ISO8601 string), `isImage` (bool)

**No JSON serialization** - direct Firestore field mapping via `.get('fieldName')`

### Component Architecture
Reusable widgets in `lib/components/`:
- **`FlushMessage`**: Error/success toasts using `another_flushbar` - preferred over SnackBar
- **`Loader`**: Fullscreen semi-transparent overlay with `CircularProgressIndicator`
- **`inputField()`** in `common.dart`: Standardized `InputDecoration` with rounded borders
- **`emailField()`** in `common.dart`: Pre-configured email `TextFormField` with `email_validator`

### Screen Structure Pattern
Each screen folder contains:
```
screens/{feature}/
  {feature}.dart          # Main StatefulWidget with business logic
  components/             # Feature-specific widgets
    form.dart             # Form with validation
    {other}_widgets.dart  # UI components
```

**Navigation Pattern**: 
- Login/Register → `Navigator.pushAndRemoveUntil` (clear stack)
- Image viewer → `Navigator.push` (standard)
- Logout → Clear SharedPreferences + `FirebaseAuth.signOut()` + Navigate to login

## Firebase Integration

### Firestore Schema
Collections:
- **`users`**: `{id, name, email}` - created on registration via `DatabaseService.storeUser()`
- **`messages`**: `{text, fromName, fromEmail, timendate, isImage}` - ordered by `timendate`

**Message Loading**: `MessageStream` uses Firestore `.orderBy('timendate', descending: true).limit(msgLimit)` with scroll-triggered pagination (`msgLimit += 25`)

### Storage Pattern
Images uploaded to Firebase Storage `chat_images/{timestamp}_{filename}`:
```dart
// Upload flow in screens/chat/chat.dart
1. Pick image: ImagePicker().pickImage(source: ImageSource.gallery)
2. Upload: FirebaseStorage.instance.ref('chat_images/$filename').putFile(file)
3. Get URL: uploadTask.snapshot.ref.getDownloadURL()
4. Store in Firestore: DatabaseService.storeMessage(Message(..., text: downloadUrl, isImage: true))
```

**Web Limitation**: Image sending disabled on web (no `dart:io` File support) - check with `kIsWeb` when implementing features.

### Authentication Persistence
**SharedPreferences** stores: `name`, `email`, `password` (for re-auth during password change)
- Set on login/register success
- Cleared on logout
- Read in `ChatScreen.loadUserData()` to reconstruct `UserM`

## Development Workflows

### Running the App
```powershell
# Development
flutter run              # Default device
flutter run -d chrome    # Web browser
flutter run -d windows   # Windows desktop

# Hot reload: Press 'r' in terminal
# Hot restart: Press 'R' in terminal
```

### Building for Production
```powershell
# Android
flutter build apk --release                    # Single APK
flutter build apk --split-per-abi --release   # Smaller APKs per architecture
flutter build appbundle --release              # Play Store upload

# Web
flutter build web --release
# Output: build/web/ (deploy via Firebase Hosting: firebase deploy)

# iOS (requires macOS)
flutter build ios --release
flutter build ipa --release
```

### Code Quality
```powershell
flutter analyze        # Linting
flutter format .       # Auto-format
flutter pub get        # Install dependencies
```

**Linter Configuration** (`analysis_options.yaml`): Disables strict const enforcement, allows `use_build_context_synchronously`, keeps `avoid_print`. This is intentional for development speed.

## Project-Specific Conventions

### Import Organization
Flutter → External packages → Project files:
```dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:anonymous_chat/models/user.dart';
```

### Error Handling
**Never throw exceptions** - return `AuthResultStatus` enum, then convert to user messages via `AuthExceptionHandler.generateErrorMessage()`. Display with `FlushMessage`.

### Theme System
Single app-wide theme in `theme.dart`:
- Primary color: `Colors.blueGrey`
- Text styles: `displayLarge` (21px), `displayMedium` (18px), `displaySmall` (17px), `headlineMedium` (15px)
- Input fields: Rounded 30px borders, grey fill, icon prefixes

**No dark mode** - light theme only.

### Responsive Design
Use `Responsive` service for web:
```dart
Responsive(mediaQuery).width(400) // Caps at 400px on web, full width on mobile
Responsive(mediaQuery).marginByPortion(leftPortion: 0.1, ...) // Proportional margins
```

### Image Handling
- Display: `CachedNetworkImage` with `CircularProgressIndicator` placeholder
- Full-screen viewer: Tap → Navigate to `FullImageScreen` with `Hero` animation potential

## Common Pitfalls

1. **Don't use `User` class name** - conflicts with Firebase Auth's User. Use `UserM` (M = Model)
2. **Await Firebase.initializeApp()** in `main()` before `runApp()` - critical for app startup
3. **Check `userData != null`** before Firestore operations in ChatScreen
4. **Use ISO8601 strings for timestamps** - `DateTime.now().toIso8601String()`, not `.millisecondsSinceEpoch`
5. **Image sending on web** - Always check platform before showing image picker
6. **Password storage in SharedPreferences** - Required for Firebase re-auth during password change (acceptable for this app scope)

## Testing & Debugging
**No test suite exists** - test manually via:
- Register new user → Logout → Login with same credentials
- Send text messages (should appear for all users instantly)
- Upload image (mobile only) → Verify Firebase Storage upload
- Change password → Logout → Login with new password
- Test landscape orientation (especially chat screen scrolling)

Firebase debugging:
- Console: https://console.firebase.google.com/
- Check Firestore rules if writes fail
- Monitor Storage usage/rules for image uploads

## Dependencies of Note
- `firebase_*`: Core v4.2.0, Auth v6.1.1, Firestore v6.0.3, Storage v13.0.3
- `image_picker` v1.1.2: Gallery/camera access
- `cached_network_image` v3.4.1: Image caching
- `another_flushbar` v1.12.30: Toast notifications (not Snackbar!)
- `shared_preferences` v2.3.2: Local storage
- `email_validator` v3.0.0: Client-side email validation

## When Making Changes
1. **Preserve StatefulWidget pattern** - don't introduce state management libraries
2. **Keep services static/constructor-based** - don't refactor to dependency injection
3. **Use existing FlushMessage** for toasts - consistent UX
4. **Follow auth navigation pattern** for new auth flows
5. **Test cross-platform** - especially web vs mobile differences
6. **Update Firebase rules** if adding new collections/storage paths
