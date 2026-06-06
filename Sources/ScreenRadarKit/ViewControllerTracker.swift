//
//  ViewControllerTracker.swift
//  ScreenRadarKit
//
//  Created by Sanket Khatri on 05/06/26.
//

import UIKit

@MainActor
final class ViewControllerTracker {

    // MARK: - Singleton

    static let shared = ViewControllerTracker()

    private init() {}

    // MARK: - Public Methods

    /// Refreshes the overlay label with the current top view controller name.
    func refresh() {
        guard let vc = topViewController() else { return }
        let screenName = String(describing: type(of: vc))
        print("📱 ScreenRadar → \(screenName)")
        OverlayWindow.shared.update(text: screenName)
    }

    /// Prints the full view controller hierarchy to the console.
    func printHierarchy() {
        guard let rootVC = rootViewController() else {
            print("""

            ==========================
            📡 ScreenRadar Hierarchy
            ==========================
            No Root View Controller Found
            ==========================

            """)
            return
        }

        print("""

        ==========================
        📡 ScreenRadar Hierarchy
        ==========================

        """)

        printViewController(rootVC, indent: "")

        print("""

        ==========================

        """)
    }

    // MARK: - Private Helpers

    private func printViewController(
        _ viewController: UIViewController,
        indent: String
    ) {
        let name = String(describing: type(of: viewController))
        print("\(indent)↳ \(name)")

        if let tabBar = viewController as? UITabBarController {
            if let selected = tabBar.selectedViewController {
                print("\(indent)   Selected Tab:")
                printViewController(selected, indent: indent + "   ")
            }
            return
        }

        if let navigation = viewController as? UINavigationController {
            print("\(indent)   Navigation Stack:")
            for vc in navigation.viewControllers {
                let vcName = String(describing: type(of: vc))
                print("\(indent)   • \(vcName)")
            }
            if let visible = navigation.visibleViewController {
                print("\(indent)   Visible:")
                printViewController(visible, indent: indent + "   ")
            }
            return
        }

        if let presented = viewController.presentedViewController {
            print("\(indent)   Presented:")
            printViewController(presented, indent: indent + "   ")
        }
    }

    private func rootViewController() -> UIViewController? {
        if #available(iOS 13.0, *) {
            return UIApplication.shared
                .connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first(where: { $0.isKeyWindow })?
                .rootViewController
        }
        return UIApplication.shared.keyWindow?.rootViewController
    }

    private func topViewController(
        from viewController: UIViewController? = nil
    ) -> UIViewController? {
        let vc = viewController ?? rootViewController()

        if let navigation = vc as? UINavigationController {
            return topViewController(from: navigation.visibleViewController)
        }

        if let tabBar = vc as? UITabBarController {
            return topViewController(from: tabBar.selectedViewController)
        }

        if let presented = vc?.presentedViewController {
            return topViewController(from: presented)
        }

        return vc
    }
}
