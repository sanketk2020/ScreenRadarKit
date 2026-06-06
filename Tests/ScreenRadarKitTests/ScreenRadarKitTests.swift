//
//  ScreenRadarKitTests.swift
//  ScreenRadarKit
//
//  Created by Sanket Khatri on 05/06/26.
//

import XCTest
@testable import ScreenRadarKit

final class ScreenRadarKitTests: XCTestCase {

    // Note: Full UI-layer tests require a running UIApplication host,
    // so these are structural smoke tests. Integration tests should
    // be done inside a sample app target.

    func testScreenRadarExists() {
        // Verify the public type is accessible
        _ = ScreenRadar.self
    }
}
