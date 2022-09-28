//
//  GhostDrawingBoardAppUITests.swift
//  GhostDrawingBoardAppUITests
//
//  Created by Anjali Dennis on 2022-09-27.
//

import XCTest

class GhostDrawingBoardAppUITests: XCTestCase {
    
    // MARK: Lifecycle Methods
    
    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    func testScreens() {
        
        let app = XCUIApplication()
        XCTAssertTrue(app.navigationBars["Ghost Drawing"].exists,"Navigation Bar title is missing")
        XCTAssertTrue(app.buttons["Pixel"].exists,"Pixel Eraser is missing")
        XCTAssertTrue(app.buttons["Object"].exists,"Object Eraser is missing")
        XCTAssertTrue(app.staticTexts["Pencil"].exists,"Pencil drawing tool is missing")
        XCTAssertTrue(app.staticTexts["Eraser"].exists,"Eraser tool is missing")
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 14.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
