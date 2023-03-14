# blogs_web_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

-   [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
-   [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## 실행 전 권한 설정

### android\app\src\main\AndroidManifest.xml:

-   인터넷 권한: <uses-permission android:name="android.permission.INTERNET" />
-   http 사용: android:usesCleartextTraffic="true"

### android\app\build.gradle

-   webview_flutter 사용을 위한 버전 지정

*   compileSdkVersion 32
*   minSdkVersion 19

### ios\Runner\Info.plist

-   http 사용:
    <key>NSAppTransportSecurity</key>
    <dict>
    <key>NSAllowsLocalNetworking</key>
    <true/>
    <key>NSAllowsArbitraryLoadsInWebContent</key>
    <true/>
    </dict>
