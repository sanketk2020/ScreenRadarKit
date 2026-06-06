# ScreenRadarKit

A lightweight iOS debug overlay that displays the **current UIViewController name** on screen in real time — so you always know exactly which screen you're on while developing.

![Platform](https://img.shields.io/badge/platform-iOS%2013%2B-blue)
![Swift](https://img.shields.io/badge/Swift-5.7%2B-orange)
![SPM](https://img.shields.io/badge/SPM-compatible-brightgreen)

---

## Features

- 📱 **Real-time screen name overlay** — floating label shows the active `UIViewController` class name
- 🔄 **Auto-detection** — uses method swizzling on `viewDidAppear` / `viewDidDisappear`, no manual calls needed
- 👆 **Tap to print hierarchy** — tap the label to dump the full VC hierarchy to the Xcode console
- 🫥 **Passthrough touches** — the overlay never blocks your app's own interactions
- ⚡ **One-line setup** — call `ScreenRadar.enable()` once and you're done
- 🛡️ **Zero production risk** — wrap in `#if DEBUG` and it never ships to users

---

## Requirements

| | Minimum |
|---|---|
| iOS | 13.0+ |
| Swift | 5.7+ |
| Xcode | 14.0+ |

---

## Installation

### Swift Package Manager (Recommended)

1. In Xcode, go to **File → Add Package Dependencies…**
2. Enter the repository URL:
   ```
   https://github.com/sanketk2020/ScreenRadarKit
   ```
3. Select **Up to Next Major Version** starting from `1.0.0`
4. Add to your **app target** (not a framework target)

Or add it manually to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/sanketk2020/ScreenRadarKit", from: "1.0.0")
],
targets: [
    .target(
        name: "YourApp",
        dependencies: ["ScreenRadarKit"]
    )
]
```

---

## Usage

### AppDelegate (UIKit)

```swift
import ScreenRadarKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        #if DEBUG
        ScreenRadar.enable()
        #endif

        return true
    }
}
```

### SceneDelegate (iOS 13+)

```swift
import ScreenRadarKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        #if DEBUG
        ScreenRadar.enable()
        #endif
    }
}
```

### SwiftUI App

```swift
import SwiftUI
import ScreenRadarKit

@main
struct MyApp: App {
    init() {
        #if DEBUG
        ScreenRadar.enable()
        #endif
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

---

## How It Works

| Component | Responsibility |
|---|---|
| `ScreenRadar` | Public entry point (`enable()` / `disable()`) |
| `UIViewController+Swizzling` | Hooks into `viewDidAppear` & `viewDidDisappear` via Objective-C runtime swizzling |
| `ViewControllerTracker` | Resolves the topmost VC from the window hierarchy; prints hierarchy on tap |
| `OverlayWindow` | Creates a `UIWindow` above all other windows with the floating label |
| `PassthroughWindow` | Overrides `hitTest` so touches fall through to the app beneath |

---

## Console Output

When active, ScreenRadar prints to the Xcode console:

```
🚀 ScreenRadar enabled
📱 ScreenRadar → HomeViewController

// After tapping the label:
==========================
📡 ScreenRadar Hierarchy
==========================
↳ UINavigationController
   Navigation Stack:
   • HomeViewController
   • ProfileViewController
   Visible:
      ↳ ProfileViewController
==========================
```

---

## Disabling

```swift
ScreenRadar.disable()
```

---

## License

MIT License. See [LICENSE](LICENSE) for details.
