# Changelog

All notable changes to ScreenRadarKit will be documented in this file.

This project follows semantic versioning.

## [1.0.0] - 2026-07-05

### Added

- Added the initial UIKit debug overlay for displaying the active `UIViewController` name.
- Added automatic screen detection through method swizzling on `viewDidAppear` and `viewDidDisappear`.
- Added a passthrough overlay window so normal app interactions continue to work beneath the overlay.
- Added optional draggable overlay support with edge snapping and persisted position.
- Added dark and light mode appearance support for the overlay.
- Added tap support on the overlay to print the current view controller hierarchy to the Xcode console.
- Added navigation trail tracking for current and previous app sessions.
- Added a bottom sheet for viewing the current session trail and previous session trail.
- Added reverse chronological display in the bottom sheet so the current screen appears first.
- Added current screen highlighting in the trail view.
- Added optional screen duration tracking through `ScreenRadar.enable(showTimeOnTrail: true)`.
- Added current and previous session export support through the share sheet.
- Added project name and session metadata to exported trail reports.
- Added separate clear actions for current and previous session trails.
- Added Objective-C usage support through the generated Objective-C selector.
- Added filtering for ScreenRadar internal controllers and Apple framework controllers.

### Changed

- Updated the overlay label to handle long screen names with bounded width, two-line display, and safe horizontal padding.
- Updated trail numbering to use two-digit formatting for better alignment.
- Updated sub-second timing display to show `<1s`.
- Updated documentation to clarify that ScreenRadar must be wrapped in `#if DEBUG` by the host app.

### Notes

- ScreenRadarKit is intended for debug builds. The package does not automatically prevent release usage; apps should guard calls to `ScreenRadar.enable()` with `#if DEBUG`.
- Native SwiftUI screen-name tracking is not supported in this release. SwiftUI apps may surface wrapper controllers such as `UIHostingController`.
