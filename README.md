# Anonymous Chat 💬

<div align="center">

A modern, feature-rich real-time chatting application built with Flutter and Firebase, supporting Android, iOS, and Web platforms.

<img width="80%" src="screenshots/banner.png">

[![GitHub stars](https://img.shields.io/github/stars/rezuanul-islam-fahim/anonymous_chat?style=social)](https://github.com/Rezuanul-Islam-Fahim/anonymous_chat/stargazers) 
[![GitHub forks](https://img.shields.io/github/forks/rezuanul-islam-fahim/anonymous_chat?style=social)](https://github.com/Rezuanul-Islam-Fahim/anonymous_chat/network/members) 
[![GitHub watchers](https://img.shields.io/github/watchers/rezuanul-islam-fahim/anonymous_chat?style=social)](https://github.com/Rezuanul-Islam-Fahim/anonymous_chat/watchers) 
[![License](https://img.shields.io/github/license/rezuanul-islam-fahim/anonymous_chat)](https://github.com/Rezuanul-Islam-Fahim/anonymous_chat/blob/stable/LICENSE)
[![Build and Deploy](https://github.com/Rezuanul-Islam-Fahim/anonymous_chat/actions/workflows/build-and-deploy-appetize.yml/badge.svg)](https://github.com/Rezuanul-Islam-Fahim/anonymous_chat/actions/workflows/build-and-deploy-appetize.yml)

[Live preview](https://appetize.io/app/b_lcp4koyt2ysaugukg3eszodyfm) • [Report Bug](https://github.com/Rezuanul-Islam-Fahim/anonymous_chat/issues) • [Request Feature](https://github.com/Rezuanul-Islam-Fahim/anonymous_chat/issues)

</div>

---

## 📋 Table of Contents

- [Features](#-features)
- [Screenshots](#-screenshots)
- [Tech Stack](#-tech-stack)
- [Architecture](#-architecture)
- [Getting Started](#-getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Firebase Setup](#firebase-setup)
- [Usage](#-usage)
- [Building for Production](#-building-for-production)
- [CI/CD Pipeline](#-cicd-pipeline)
- [Project Structure](#-project-structure)
- [Contributing](#-contributing)
- [Roadmap](#-roadmap)
- [Known Issues](#-known-issues)
- [License](#-license)
- [Contact](#-contact)
- [Acknowledgments](#-acknowledgments)

---

## ✨ Features

### Core Functionality
- 🔐 **User Authentication** - Secure email/password authentication via Firebase Auth
- 💬 **Real-time Messaging** - Instant message delivery using Cloud Firestore
- 📷 **Image Sharing** - Send and receive images in conversations (Android/iOS)
- 🔒 **Password Management** - Change password functionality with validation
- 💾 **Persistent Sessions** - Stay logged in across app restarts
- 🖼️ **Full-Screen Image Viewer** - Tap images to view in full screen

### User Experience
- 🎨 **Beautiful UI/UX** - Clean, modern, and intuitive interface
- 📱 **Responsive Design** - Optimized layouts for all screen sizes
- 🔄 **Smooth Animations** - Loading indicators and transitions
- ⚡ **High Performance** - Optimized scrolling and rendering
- 🌐 **Cross-Platform** - Single codebase for Android, iOS, and Web
- 🔔 **Real-time Updates** - Messages appear instantly
- 📐 **Landscape Support** - Works in both portrait and landscape modes

### Technical Features
- ✅ **Form Validation** - Client-side validation for all inputs
- 🚨 **Error Handling** - User-friendly error messages via Flushbar
- 🎭 **Splash Screen** - Custom splash screen on app launch
- 🖼️ **Cached Images** - Efficient image caching for better performance
- 📊 **Firebase Backend** - Scalable cloud infrastructure

> **Note:** Image sending is currently not supported in the web version.



---

## 📸 Screenshots

### Mobile App Features

<div align="center">

<img height="490px" src="screenshots/screenshot1.gif"> <img height="490px" src="screenshots/screenshot2.gif"> <img height="490px" src="screenshots/screenshot3.gif"> <img height="490px" src="screenshots/screenshot4.gif"> <img height="490px" src="screenshots/screenshot5.gif"> <img height="490px" src="screenshots/screenshot6.gif">

</div>

### Real-time Messaging

<div align="center">

<img height="490px" src="screenshots/screenshot7.gif"> <img height="490px" src="screenshots/screenshot8.gif">

</div>

### Web Application

<div align="center">

<img src="screenshots/web-app.png">

</div>

---

## 🛠️ Tech Stack

### Frontend
- **Framework:** [Flutter](https://flutter.dev/) (Dart SDK ^3.9.0)
- **State Management:** StatefulWidget with setState
- **UI Components:** Material Design

### Backend & Services
- **Authentication:** [Firebase Authentication](https://firebase.google.com/products/auth)
- **Database:** [Cloud Firestore](https://firebase.google.com/products/firestore)
- **Storage:** [Firebase Storage](https://firebase.google.com/products/storage)
- **Local Storage:** [Shared Preferences](https://pub.dev/packages/shared_preferences)

### Key Dependencies
| Package | Version | Purpose |
|---------|---------|---------|
| firebase_core | ^4.2.0 | Firebase SDK initialization |
| firebase_auth | ^6.1.1 | User authentication |
| cloud_firestore | ^6.0.3 | Real-time database |
| firebase_storage | ^13.0.3 | Image storage |
| image_picker | ^1.1.2 | Camera/gallery access |
| cached_network_image | ^3.4.1 | Image caching |
| email_validator | ^3.0.0 | Email validation |
| another_flushbar | ^1.12.30 | Toast messages |
| shared_preferences | ^2.3.2 | Local data persistence |

---

## 🏗️ Architecture

```
lib/
├── main.dart                 # App entry point
├── theme.dart                # App-wide theme configuration
├── common.dart               # Common utilities
├── components/               # Reusable UI components
│   ├── circular_loader.dart
│   ├── flush_message.dart
│   ├── general_button.dart
│   └── login_register_header.dart
├── models/                   # Data models
│   ├── message.dart
│   └── user.dart
├── screens/                  # App screens
│   ├── login/
│   ├── register/
│   ├── chat/
│   ├── settings/
│   ├── change_password/
│   └── full_sized_image.dart
└── services/                 # Business logic & Firebase services
    ├── auth/
    ├── database.dart
    └── responsive.dart
```

---

## 🚀 Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (3.35.6 or higher)
- [Dart SDK](https://dart.dev/get-dart) (^3.9.0)
- [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/)
- [Git](https://git-scm.com/)
- A Firebase account ([Create one here](https://firebase.google.com/))

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Rezuanul-Islam-Fahim/anonymous_chat.git
   cd anonymous_chat
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Verify Flutter installation**
   ```bash
   flutter doctor
   ```

### Firebase Setup

1. **Create a Firebase Project**
   - Go to [Firebase Console](https://console.firebase.google.com/)
   - Click "Add Project" and follow the setup wizard
   - Enable Google Analytics (optional)

2. **Add Firebase to your Flutter app**

   **For Android:**
   - Download `google-services.json` from Firebase Console
   - Place it in `android/app/`
   - Update `android/build.gradle` with Firebase dependencies (already configured)

   **For iOS:**
   - Download `GoogleService-Info.plist` from Firebase Console
   - Add it to `ios/Runner/` in Xcode

   **For Web:**
   - Copy your Firebase configuration
   - Update `web/index.html` with Firebase SDK initialization

3. **Enable Firebase Services**
   
   In Firebase Console, enable:
   - **Authentication** → Email/Password sign-in method
   - **Firestore Database** → Create database in test mode
   - **Storage** → Set up Firebase Storage with appropriate rules

4. **Configure Firestore Security Rules**

   ```javascript
   rules_version = '2';
   service cloud.firestore {
     match /databases/{database}/documents {
       match /messages/{message} {
         allow read, write: if request.auth != null;
       }
       match /users/{user} {
         allow read: if request.auth != null;
         allow write: if request.auth != null && request.auth.uid == user;
       }
     }
   }
   ```

5. **Configure Storage Security Rules**

   ```javascript
   rules_version = '2';
   service firebase.storage {
     match /b/{bucket}/o {
       match /chat_images/{imageId} {
         allow read: if request.auth != null;
         allow write: if request.auth != null 
                      && request.resource.size < 5 * 1024 * 1024
                      && request.resource.contentType.matches('image/.*');
       }
     }
   }
   ```

---

## 💻 Usage

### Running the App

**Debug Mode:**
```bash
# Run on connected device/emulator
flutter run

# Run on specific device
flutter devices
flutter run -d <device_id>

# Run on Chrome (Web)
flutter run -d chrome
```

**Development:**
```bash
# Hot reload - Press 'r' in terminal
# Hot restart - Press 'R' in terminal
# Quit - Press 'q' in terminal
```

### User Flow

1. **Registration**
   - Open the app
   - Click "Create Account"
   - Enter email, username, and password
   - Submit to create account

2. **Login**
   - Enter registered email and password
   - Click "Login"
   - Access the chat screen

3. **Chatting**
   - View all messages in real-time
   - Type message in input field
   - Tap camera icon to send images (mobile only)
   - Tap image to view full-screen

4. **Settings**
   - Access settings from chat screen
   - Change password
   - Logout

---

## 📦 Building for Production

### Android (APK/App Bundle)

```bash
# Build APK
flutter build apk --release

# Build App Bundle (for Play Store)
flutter build appbundle --release

# Split APKs by ABI
flutter build apk --split-per-abi --release
```

Output location: `build/app/outputs/flutter-apk/`

### iOS (App Store)

```bash
# Build for iOS
flutter build ios --release

# Build IPA
flutter build ipa --release
```

### Web

```bash
# Build for web
flutter build web --release
```

Output location: `build/web/`

### Build Configuration

**Update version:**
Edit `pubspec.yaml`:
```yaml
version: 1.0.0+1  # version_name+build_number
```

**Generate launcher icons:**
```bash
flutter pub run flutter_launcher_icons:main
```

**Generate splash screen:**
```bash
flutter pub run flutter_native_splash:create
```

---

## � CI/CD Pipeline

This project includes an automated CI/CD pipeline using GitHub Actions that builds and deploys the APK to Appetize.io for easy testing.

### Workflow Features

- ✅ **Automated Builds** - Triggered on pull requests to master/main or manual dispatch
- 🚀 **Appetize Deployment** - Automatic deployment to Appetize.io for browser testing
- 📦 **APK Artifacts** - Download ready-to-install APKs (30-day retention)
- ⚡ **Smart Caching** - Flutter SDK, pub dependencies, and Gradle caching (3x faster builds)
- 🔍 **Code Analysis** - Runs `flutter analyze` on every build
- 📊 **Build Summary** - Detailed workflow summaries with download links

### Build Timeline

| Build Type | Duration | Notes |
|------------|----------|-------|
| First Build | ~12-15 min | Full dependency download |
| Cached Build | ~4-5 min | With cache hits (3x faster) |

### Setup Instructions

1. **Get Appetize API Token**
   - Sign up at [Appetize.io](https://appetize.io/)
   - Navigate to Account Settings → API Token
   - Copy your API token

2. **Add GitHub Secrets**
   - Go to `Settings → Secrets and variables → Actions`
   - Add secret: `APPETIZE_API_TOKEN` (required)
   - After first run, add: `APPETIZE_PUBLIC_KEY` (for updates)

3. **Trigger Workflow**
   - Create a Pull Request to master/main branch
   - Or manually: `Actions → Build Flutter APK and Deploy to Appetize → Run workflow`

4. **Access Your Build**
   - Check workflow summary for APK download link
   - Test app in browser via Appetize URL
   - Download APK artifact for local testing

### Workflow Architecture

See [`.github/ARCHITECTURE.md`](.github/ARCHITECTURE.md) for detailed workflow architecture, caching strategy, and troubleshooting guide.

### Monitoring

- **Workflow Status:** Check the build badge at the top of this README
- **Build History:** `Actions` tab → `Build Flutter APK and Deploy to Appetize`
- **APK Artifacts:** Available in workflow run summaries for 30 days

---

## �📁 Project Structure

```
anonymous_chat/
├── .github/                  # GitHub configuration
│   ├── workflows/           # GitHub Actions workflows
│   │   └── build-and-deploy-appetize.yml
│   ├── ARCHITECTURE.md      # CI/CD workflow architecture
│   └── copilot-instructions.md
├── android/                  # Android native code
├── ios/                      # iOS native code
├── web/                      # Web-specific files
├── lib/                      # Flutter application code
│   ├── components/           # Reusable widgets
│   ├── models/              # Data models
│   ├── screens/             # UI screens
│   │   ├── chat/            # Chat screen
│   │   ├── login/           # Login screen
│   │   ├── register/        # Registration screen
│   │   ├── settings/        # Settings screen
│   │   └── change_password/ # Password change screen
│   ├── services/            # Backend services
│   │   ├── auth/           # Authentication logic
│   │   ├── database.dart   # Firestore operations
│   │   └── responsive.dart # Responsive utilities
│   ├── main.dart           # Entry point
│   ├── theme.dart          # App theme
│   └── common.dart         # Common utilities
├── assets/                  # Images and assets
├── test/                    # Unit and widget tests
├── pubspec.yaml            # Dependencies
├── analysis_options.yaml   # Linting rules
├── firebase.json           # Firebase configuration
└── README.md              # This file
```

---

## 🤝 Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

### How to Contribute

1. **Fork the Project**
2. **Create your Feature Branch**
   ```bash
   git checkout -b feature/AmazingFeature
   ```
3. **Commit your Changes**
   ```bash
   git commit -m 'Add some AmazingFeature'
   ```
4. **Push to the Branch**
   ```bash
   git push origin feature/AmazingFeature
   ```
5. **Open a Pull Request**

### Coding Standards

- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Run `flutter analyze` before committing
- Format code with `flutter format .`
- Add comments for complex logic
- Update documentation for new features

### Reporting Issues

- Use the [issue tracker](https://github.com/Rezuanul-Islam-Fahim/anonymous_chat/issues)
- Check if the issue already exists
- Provide detailed reproduction steps
- Include screenshots/logs if applicable

---

## 🗺️ Roadmap

- [ ] Push notifications for new messages
- [ ] Online/offline user status indicators
- [ ] Read receipts and message status
- [ ] Group chat functionality
- [ ] Voice message support
- [ ] Video call integration
- [ ] Message reactions (emoji)
- [ ] Search messages functionality
- [ ] Dark mode theme
- [ ] Multi-language support (i18n)
- [ ] Message encryption (E2E)
- [ ] User profile customization
- [ ] Image sending support for web
- [ ] File sharing capability
- [ ] Message editing and deletion

See the [open issues](https://github.com/Rezuanul-Islam-Fahim/anonymous_chat/issues) for a full list of proposed features and known issues.

---

## 🐛 Known Issues

- **Web Platform**: Image sending is not currently supported due to platform limitations
- **Performance**: Large images may take time to upload on slower connections
- **Compatibility**: Some older Android devices may experience performance issues

For a complete list, visit the [Issues page](https://github.com/Rezuanul-Islam-Fahim/anonymous_chat/issues).

---

## 📄 License

Distributed under the MIT License. See `LICENSE` file for more information.

```
MIT License

Copyright (c) 2021 Rezuanul Islam Fahim

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## 📞 Contact

**Rezuanul Islam Fahim**

- GitHub: [@Rezuanul-Islam-Fahim](https://github.com/Rezuanul-Islam-Fahim)
- Project Link: [https://github.com/Rezuanul-Islam-Fahim/anonymous_chat](https://github.com/Rezuanul-Islam-Fahim/anonymous_chat)

---

## 🙏 Acknowledgments

- [Flutter Team](https://flutter.dev/) - For the amazing framework
- [Firebase](https://firebase.google.com/) - For backend infrastructure
- [Material Design](https://material.io/) - For design guidelines
- All contributors and users of this project

---

## 🌟 Support This Project

If you find this project useful, please consider:

- ⭐ Starring the repository
- 🍴 Forking and contributing
- 🐛 Reporting bugs
- 💡 Suggesting new features
- 📢 Sharing with others

---

<div align="center">

Made with ❤️ and Flutter

**[⬆ Back to Top](#anonymous-chat-)**

</div>