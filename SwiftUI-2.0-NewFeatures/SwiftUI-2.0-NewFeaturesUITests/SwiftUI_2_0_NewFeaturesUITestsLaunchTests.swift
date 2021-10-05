//
//  SwiftUI_2_0_NewFeaturesUITestsLaunchTests.swift
//  SwiftUI-2.0-NewFeaturesUITests
//
//  Created by BKS-GGS on 04/10/21.
//

import XCTest

class SwiftUI_2_0_NewFeaturesUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
