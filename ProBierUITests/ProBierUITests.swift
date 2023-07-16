//
//  ProBierUITests.swift
//  ProBierUITests
//
//  Created by Hans-Christian Wollert on 13.07.23.
//

import XCTest

final class ProBierUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testStart() throws {
        let app = XCUIApplication()
        app.launch()

        let emptyText = app.staticTexts["Beer everywhere"]
        
        XCTAssert(emptyText.exists)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
