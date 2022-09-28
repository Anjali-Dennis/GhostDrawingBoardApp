//
//  GhostDrawingViewControllerTests.swift
//  GhostDrawingBoardAppTests
//
//  Created by Anjali Dennis on 2022-09-27.
//

import XCTest
@testable import GhostDrawingBoardApp

class GhostDrawingViewControllerTests: XCTestCase {
    
    // MARK: Instance Variables
    
    var ghostDrawingviewController: GhostDrawingViewController!
    
    // MARK: Lifecycle Methods
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        ghostDrawingviewController = (storyboard.instantiateViewController(identifier: "ghostDrawingViewController") as! GhostDrawingViewController)
        
    }

    override func tearDownWithError() throws {
        ghostDrawingviewController = nil
    }

    func testViewLoad() {
        let _ = ghostDrawingviewController.view
        XCTAssertNotNil(ghostDrawingviewController, "View controller not initiated properly")
        XCTAssertNotNil(ghostDrawingviewController.view, "View not initiated properly")
        let subviews = ghostDrawingviewController.view.subviews
        XCTAssertTrue(subviews.contains(ghostDrawingviewController.drawingCanvasView), "View does not have a canvas subview")
        XCTAssertNotNil(ghostDrawingviewController.drawingCanvasView, "PKCanvass not initiated")
        XCTAssertNotNil(ghostDrawingviewController.drawingCanvasView.delegate, "PKCanvas delegate is nil")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}


