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
        app.navigationBars.buttons["Add"].tap()

        let nameTextField = app.textFields["Name"]
        let name = "Søren"
        nameTextField.tap()
        nameTextField.typeText(name)

        let addressTextField = app.textFields["Address"]
        addressTextField.tap()
        addressTextField.typeText("Main Rd.")

        let countryTextField = app.textFields["Country"]
        countryTextField.tap()
        countryTextField.typeText("Denmark")

        let companyRegNoTextField = app.textFields["CVR"]
        companyRegNoTextField.tap()
        companyRegNoTextField.typeText("24 46 57 87")

        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.typeText("soren.sonderby.nielsen@visma.com")

        let phoneTextField = app.textFields["Phone"]
        phoneTextField.tap()
        phoneTextField.typeText("44 35 99 88")

        app.navigationBars.buttons["Save"].tap()

        // Assert
        expectation(for: hasNewCustomer, evaluatedWith: cells)
        waitForExpectations(timeout: 5)

        XCTAssertTrue(app.tables.cells.staticTexts[name].exists)
    }
}
