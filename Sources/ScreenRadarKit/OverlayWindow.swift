//
//  OverlayWindow.swift
//  ScreenRadarKit
//
//  Created by Sanket Khatri on 05/06/26.
//

import UIKit

@MainActor
final class OverlayWindow {

    // MARK: - Singleton

    static let shared = OverlayWindow()

    // MARK: - Private Properties

    private var window: PassthroughWindow?
    private let label = UILabel()

    private init() {}

    // MARK: - Public Methods

    func show() {
        guard window == nil else { return }

        let overlayWindow: PassthroughWindow

        if #available(iOS 13.0, *) {
            guard let windowScene = UIApplication.shared
                .connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .first else {
                print("❌ ScreenRadar: No UIWindowScene found")
                return
            }
            overlayWindow = PassthroughWindow(windowScene: windowScene)
        } else {
            overlayWindow = PassthroughWindow(frame: UIScreen.main.bounds)
        }

        overlayWindow.frame = UIScreen.main.bounds
        overlayWindow.backgroundColor = .clear
        overlayWindow.windowLevel = .alert + 1000

        let rootVC = UIViewController()
        rootVC.view.backgroundColor = .clear

        configureLabel()

        rootVC.view.addSubview(label)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(
                equalTo: rootVC.view.safeAreaLayoutGuide.topAnchor,
                constant: 8
            ),
            label.centerXAnchor.constraint(
                equalTo: rootVC.view.centerXAnchor
            ),
            label.heightAnchor.constraint(equalToConstant: 30),
            label.widthAnchor.constraint(greaterThanOrEqualToConstant: 120)
        ])

        overlayWindow.rootViewController = rootVC
        self.window = overlayWindow
        overlayWindow.isHidden = false
    }

    func update(text: String) {
        label.text = "  \(text)  "
    }

    func hide() {
        window?.isHidden = true
        window = nil
    }

    // MARK: - Private Helpers

    private func configureLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ScreenRadar"
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.layer.cornerRadius = 6
        label.clipsToBounds = true
        label.isUserInteractionEnabled = true

        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(labelTapped)
        )
        label.addGestureRecognizer(tapGesture)
    }

    @objc private func labelTapped() {
        ViewControllerTracker.shared.printHierarchy()
    }
}
