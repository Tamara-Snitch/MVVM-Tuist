//
// UIComponentsUITests.swift
// UIComponents
//
//  Created by Kirill Prokoptsov on 22.04.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import XCTest

@testable import UIComponents
@testable import UIComponentsTesting

final class UIComponentsUITests: XCTestCase {

	override func setUpWithError() throws {
		continueAfterFailure = false
	}

	override func tearDownWithError() throws { }

	func testExample() throws {
		let app = XCUIApplication()
		app.launch()
	}

	func testLaunchPerformance() throws {
		if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
			measure(metrics: [XCTApplicationLaunchMetric()]) {
				XCUIApplication().launch()
			}
		}
	}
}

