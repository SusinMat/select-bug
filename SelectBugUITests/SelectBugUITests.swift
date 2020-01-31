//
//  SelectBugUITests.swift
//  SelectBugUITests
//
//  Created by Matheus Martins Susin on 2020-01-29.
//  Copyright © 2020 Matheus Martins Susin. All rights reserved.
//

import XCTest

class SelectBugUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        // UI tests must launch the application that they test.
        app.launch()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app.terminate()
    }

    func testSwitches() {
        var cellSwitch: XCUIElement {
            get {
                app.tables.cells.element(boundBy: 0).switches.element(boundBy: 0)
            }
        }

        XCTAssertFalse(cellSwitch.exists)

        let button = app.buttons.element(boundBy: 0)
        XCTAssertTrue(button.exists)

        button.tap()

        // to make this assertion fail, uncomment 'tableView.allowsMultipleSelectionDuringEditing = true'
        // in the Main View Controller
        XCTAssertTrue(cellSwitch.exists, "First cell contains \(app.tables.cells.element(boundBy: 0).switches.count) switches")

        button.tap()

        XCTAssertFalse(cellSwitch.exists)
    }

    func testSwipe() {
        let firstCell = app.tables.cells.element(boundBy: 0)

        XCTAssertTrue(firstCell.exists)

        firstCell.swipeLeft()

        let swapButton = firstCell.buttons["Swap"]

        XCTAssertTrue(swapButton.exists)

        swapButton.tap()

        let isSelectedPredicate = NSPredicate(format: "isSelected == true")
        self.expectation(for: isSelectedPredicate, evaluatedWith: firstCell)

        // to make this expectation fail, changle the value of 'selectionDelay' in the Main View Controller
        // to 0.8 or lower
        self.waitForExpectations(timeout: 2.0)
    }

}
