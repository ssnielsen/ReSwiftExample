//
//  ReSwiftTestUITests.swift
//  ReSwiftTestUITests
//
//  Created by Søren Nielsen on 20/12/2016.
//  Copyright © 2016 e-conomic International A/S. All rights reserved.
//

import XCTest
@testable import ReSwiftTest
import ReSwift

class ReSwiftTestUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        let application = XCUIApplication()

        // Let the app know that we run UI tests
        application.launchArguments.append("UI-TESTING")

        // Launch it!
        application.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_addCustomerWillAddCustomerToTable() {
        // Arrange
        let app = XCUIApplication()
        let cells = app.tables.cells
        let cellCountBefore = cells.count
        let hasNewCustomer = NSPredicate(format: "count == \(Int(cellCountBefore + 1))")

        // Act
        XCUIApplication().navigationBars.buttons["Add"].tap()

        // Assert
        expectation(for: hasNewCustomer, evaluatedWith: cells)
        waitForExpectations(timeout: 5)
    }
}
