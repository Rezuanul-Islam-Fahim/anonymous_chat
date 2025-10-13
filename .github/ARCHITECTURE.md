# Appetize Deployment Workflow Architecture

## 🔄 Workflow Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                     TRIGGER EVENT                                │
│  (Pull Request to master/main branch or Manual workflow dispatch)│
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                    SETUP ENVIRONMENT                             │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐         │
│  │ Checkout     │  │ Setup Java   │  │ Setup Flutter │         │
│  │ Repository   │→ │ JDK 17 (Zulu)│→ │ 3.5.6 Stable │         │
│  └──────────────┘  └──────────────┘  └──────────────┘         │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                    RESTORE CACHES                                │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐         │
│  │ Flutter SDK  │  │ Pub Cache    │  │ Gradle Cache │         │
│  │ Cache        │  │              │  │              │         │
│  └──────────────┘  └──────────────┘  └──────────────┘         │
│                                                                  │
│  Cache Hit?  YES → Fast Build (3-5 min)                        │
│              NO  → Full Build (10-15 min)                       │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                    BUILD PROCESS                                 │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐         │
│  │ flutter      │→ │ flutter pub  │→ │ flutter      │         │
│  │ doctor -v    │  │ get          │  │ analyze      │         │
│  └──────────────┘  └──────────────┘  └──────────────┘         │
│                                              │                   │
│                                              ▼                   │
│                                    ┌──────────────┐             │
│                                    │ flutter build│             │
│                                    │ apk --release│             │
│                                    └──────────────┘             │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                    POST-BUILD ACTIONS                            │
│  ┌──────────────┐  ┌──────────────┐                            │
│  │ Rename APK   │→ │ Upload as    │                            │
│  │ with Version │  │ Artifact     │                            │
│  └──────────────┘  └──────────────┘                            │
│                                                                  │
│  APK Name: anonymous_chat-{VERSION}.apk (from pubspec.yaml)     │
│  Retention: 30 days                                             │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                APPETIZE DEPLOYMENT LOGIC                         │
│                                                                  │
│  Check: Does APPETIZE_PUBLIC_KEY exist?                         │
│                                                                  │
│  ┌───────────────────────┐    ┌──────────────────────┐         │
│  │ NO (First Time)       │    │ YES (Update)         │         │
│  │                       │    │                      │         │
│  │ ┌─────────────────┐   │    │ ┌────────────────┐  │         │
│  │ │ POST /v1/apps   │   │    │ │ POST           │  │         │
│  │ │ (New Upload)    │   │    │ │ /v1/apps/{key} │  │         │
│  │ └────────┬────────┘   │    │ └────────┬───────┘  │         │
│  │          │            │    │          │          │         │
│  │          ▼            │    │          ▼          │         │
│  │ ┌─────────────────┐   │    │ ┌────────────────┐  │         │
│  │ │ Get Public Key  │   │    │ │ Update Existing│  │         │
│  │ │ Display Warning │   │    │ │ App            │  │         │
│  │ └─────────────────┘   │    │ └────────────────┘  │         │
│  └───────────────────────┘    └──────────────────────┘         │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                    GENERATE OUTPUTS                              │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐         │
│  │ Workflow     │  │ PR Comment   │  │ Deployment   │         │
│  │ Summary      │  │ (if PR)      │  │ Info         │         │
│  └──────────────┘  └──────────────┘  └──────────────┘         │
│                                                                  │
│  Contains:                                                       │
│  • Build information                                            │
│  • APK download link                                            │
│  • Public key                                                   │
│  • App URL for testing                                          │
│  • Setup instructions (if first time)                           │
└─────────────────────────────────────────────────────────────────┘
```

## 📦 Caching Strategy

```
┌──────────────────────────────────────────────────────────────┐
│                      CACHE LAYERS                             │
└──────────────────────────────────────────────────────────────┘

Layer 1: Flutter SDK Cache
├── Location: ${{ runner.tool_cache }}/flutter
├── Key: flutter-:os:-:channel:-:version:-:arch:-:hash:
├── Size: ~800 MB
└── Saves: 2-3 minutes per build

Layer 2: Pub Dependencies Cache  
├── Location: ~/.pub-cache, .dart_tool
├── Key: ${{ runner.os }}-pub-${{ hashFiles('**/pubspec.lock') }}
├── Size: ~100-500 MB
└── Saves: 1-2 minutes per build

Layer 3: Gradle Dependencies Cache
├── Location: ~/.gradle/caches, ~/.gradle/wrapper, ~/.android/build-cache
├── Key: ${{ runner.os }}-gradle-${{ hashFiles('**/*.gradle*', 'gradle-wrapper.properties') }}
├── Size: ~500 MB - 1 GB
└── Saves: 3-5 minutes per build

Layer 4: Java Distribution Cache
├── Location: Managed by setup-java action
├── Key: Auto-managed
├── Size: ~200 MB
└── Saves: 30-60 seconds per build

Total Time Saved: 7-11 minutes on subsequent builds!
```

## 🔐 Secret Management

```
┌──────────────────────────────────────────────────────────────┐
│                    GITHUB SECRETS                             │
└──────────────────────────────────────────────────────────────┘

Required Secrets:
┌─────────────────────────┐
│ APPETIZE_API_TOKEN      │  ← Required before first run
│                         │    (Get from Appetize.io)
└─────────────────────────┘

Optional (After First Deployment):
┌─────────────────────────┐
│ APPETIZE_PUBLIC_KEY     │  ← Add after first successful run
│                         │    (Provided in workflow output)
└─────────────────────────┘

Secret Usage Flow:
1. Workflow reads APPETIZE_API_TOKEN for authentication
2. Checks if APPETIZE_PUBLIC_KEY exists
   ├── NO  → Creates new app, returns public key
   └── YES → Updates existing app using public key
```

## 🎯 Decision Tree

```
                    Start Workflow
                         │
                         ▼
         ┌───────────────────────────┐
         │ Is APPETIZE_PUBLIC_KEY    │
         │ defined in secrets?       │
         └──────────┬────────────────┘
                    │
          ┌─────────┴─────────┐
          │                   │
         NO                  YES
          │                   │
          ▼                   ▼
   ┌────────────┐      ┌────────────┐
   │ NEW UPLOAD │      │   UPDATE   │
   └──────┬─────┘      └─────┬──────┘
          │                   │
          ▼                   ▼
   ┌────────────┐      ┌────────────┐
   │ POST       │      │ POST       │
   │ /v1/apps   │      │ /v1/apps/  │
   │            │      │ {key}      │
   └──────┬─────┘      └─────┬──────┘
          │                   │
          ▼                   ▼
   ┌────────────┐      ┌────────────┐
   │ Receive    │      │ Keep same  │
   │ new public │      │ public key │
   │ key        │      │            │
   └──────┬─────┘      └─────┬──────┘
          │                   │
          ▼                   ▼
   ┌────────────┐      ┌────────────┐
   │ Show       │      │ Confirm    │
   │ warning to │      │ successful │
   │ save key   │      │ update     │
   └────────────┘      └────────────┘
```

## 📊 Build Timeline Comparison

```
First Build (No Cache):
┌────────────────────────────────────────────────────────────┐
│ Checkout           ████ 30s                                │
│ Setup Java         ██████████ 60s                          │
│ Setup Flutter      ████████████████████ 120s               │
│ Flutter Doctor     ████ 20s                                │
│ Pub Get            ████████████ 80s                        │
│ Analyze            ████ 30s                                │
│ Gradle Build       ████████████████████████████ 180s       │
│ Flutter Build      ████████████████████████████████ 200s   │
│ Appetize Upload    ████████ 45s                            │
└────────────────────────────────────────────────────────────┘
Total: ~12.5 minutes

Subsequent Build (With Cache):
┌────────────────────────────────────────────────────────────┐
│ Checkout           ████ 30s                                │
│ Setup Java         ██ 15s (cached)                         │
│ Setup Flutter      ████ 25s (cached)                       │
│ Flutter Doctor     ██ 10s                                  │
│ Pub Get            ██ 15s (cached)                         │
│ Analyze            ██ 10s                                  │
│ Gradle Build       ████████ 45s (cached)                   │
│ Flutter Build      ████████████████ 90s                    │
│ Appetize Upload    ████████ 45s                            │
└────────────────────────────────────────────────────────────┘
Total: ~4.5 minutes

⚡ Speed Improvement: ~3x faster!
```

## 🔄 Continuous Deployment Flow

```
Developer                GitHub Actions              Appetize.io
    │                          │                         │
    │  Push Code / Create PR  │                         │
    ├────────────────────────►│                         │
    │                          │                         │
    │                          │  Build APK             │
    │                          ├──────────┐             │
    │                          │          │             │
    │                          │◄─────────┘             │
    │                          │                         │
    │                          │  Upload/Update APK     │
    │                          ├────────────────────────►│
    │                          │                         │
    │                          │  Return Public Key +   │
    │                          │  App URL               │
    │                          │◄────────────────────────┤
    │                          │                         │
    │  Workflow Complete      │                         │
    │  (Summary + Artifact)   │                         │
    │◄────────────────────────┤                         │
    │                          │                         │
    │                                                    │
    │  Test App in Browser                              │
    ├───────────────────────────────────────────────────►│
    │                                                    │
```

## 🏗️ Project Context

### Application Architecture

**Anonymous Chat** is a Flutter-based real-time messaging application using Firebase backend:

- **Frontend:** Flutter with Material Design
- **State Management:** StatefulWidget + setState (no external state management)
- **Authentication:** Firebase Authentication (email/password)
- **Database:** Cloud Firestore (real-time messaging)
- **Storage:** Firebase Storage (image uploads)
- **Platforms:** Android, iOS, Web

### Key Features Tested

The Appetize deployment allows testing of:

- ✅ User registration and login flows
- ✅ Real-time message synchronization
- ✅ Image sharing (Android/iOS only)
- ✅ Password change functionality
- ✅ Session persistence
- ✅ Responsive layouts

### Firebase Integration

The workflow builds an APK that connects to Firebase services:

- **Authentication:** Handles user signup/login/logout
- **Firestore:** Stores user data and messages
- **Storage:** Handles image uploads (mobile only)
- **Security Rules:** Pre-configured for production use

## 📝 Setup Instructions

### Step 1: Get Appetize API Token

1. Go to [Appetize.io](https://appetize.io/)
2. Create an account or sign in
3. Navigate to Account Settings → API Token
4. Copy your API token

### Step 2: Add GitHub Secrets

1. Go to your repository: `Settings → Secrets and variables → Actions`
2. Click **New repository secret**
3. Add the following secret:
   - **Name:** `APPETIZE_API_TOKEN`
   - **Value:** Your Appetize API token

### Step 3: First Workflow Run

1. Create a Pull Request to `master` or `main` branch
2. Or manually trigger the workflow: `Actions → Build Flutter APK and Deploy to Appetize → Run workflow`
3. Wait for the workflow to complete
4. Check the workflow summary for the public key

### Step 4: Save Public Key (First Time Only)

After the first successful run:

1. Copy the public key from the workflow summary
2. Go to `Settings → Secrets and variables → Actions`
3. Click **New repository secret**
4. Add:
   - **Name:** `APPETIZE_PUBLIC_KEY`
   - **Value:** The public key from step 1

### Step 5: Subsequent Runs

For all future runs:

- The workflow will automatically update the existing Appetize app
- No need to update the public key again
- Each build will be available at the same URL

## 🔍 Troubleshooting

### Build Failures

**Issue:** Gradle build fails
- **Solution:** Check `android/app/build.gradle` for correct SDK versions
- **Solution:** Ensure `google-services.json` is present in `android/app/`

**Issue:** Flutter analyze fails
- **Solution:** Run `flutter analyze` locally and fix linting issues
- **Note:** Workflow continues even if analysis fails (`continue-on-error: true`)

**Issue:** APK not found after build
- **Solution:** Verify pubspec.yaml version format: `version: 1.0.0+1`

### Appetize Upload Failures

**Issue:** API token invalid
- **Solution:** Verify `APPETIZE_API_TOKEN` secret is correct
- **Solution:** Check if token has expired (regenerate if needed)

**Issue:** Public key not working
- **Solution:** Verify `APPETIZE_PUBLIC_KEY` secret matches the key from first upload
- **Solution:** Try removing the secret and letting workflow create new app

**Issue:** Upload timeout
- **Solution:** Check network connectivity
- **Solution:** Verify APK size is within Appetize limits (~100 MB)

### Cache Issues

**Issue:** Slow builds despite caching
- **Solution:** Clear GitHub Actions cache: `Settings → Actions → Caches`
- **Solution:** Manually trigger workflow after clearing cache

**Issue:** Outdated dependencies
- **Solution:** Update `pubspec.lock` and push changes
- **Solution:** Cache key will automatically update based on lock file hash

## 🎯 Workflow Optimization Tips

1. **Keep dependencies updated:** Regularly update Flutter and package versions
2. **Minimize APK size:** Use `flutter build apk --split-per-abi` for smaller builds
3. **Optimize images:** Compress assets before committing
4. **Use semantic versioning:** Follow semver in pubspec.yaml for clear version tracking
5. **Test locally first:** Run `flutter build apk --release` before pushing

## 📈 Monitoring and Metrics

### Workflow Metrics to Track

- **Build Duration:** Target < 5 minutes with cache
- **APK Size:** Monitor size growth over time
- **Cache Hit Rate:** Aim for >80% cache hits
- **Failure Rate:** Target <5% build failures

### Where to Find Metrics

- **Build times:** GitHub Actions → Workflow runs → Individual job times
- **APK size:** Build artifacts → Download and check file size
- **Cache performance:** Workflow logs → Cache restore/save steps

## 🔒 Security Considerations

### Firebase Configuration

- **Never commit:** `google-services.json` with production keys
- **Use separate projects:** Development vs. Production Firebase projects
- **Firestore rules:** Review security rules before production deployment
- **API keys:** Restrict Firebase API keys to specific platforms

### Secrets Management

- **Rotate regularly:** Change Appetize API token periodically
- **Limit access:** Only add secrets that are necessary
- **Monitor usage:** Check GitHub Actions logs for unauthorized access attempts

### APK Distribution

- **Appetize apps:** Are publicly accessible if someone has the URL
- **Artifact retention:** 30 days (automatically deleted after)
- **Production builds:** Use separate workflow for Play Store releases

---

**Architecture Version:** 1.0.0  
**Last Updated:** October 2025  
**Flutter Version:** 3.5.6  
**Dart SDK:** ^3.5.0  
**Java Version:** 17 (Zulu Distribution)  
**Target SDK:** Android 34  
**Minimum SDK:** Android 21 (Android 5.0 Lollipop)
