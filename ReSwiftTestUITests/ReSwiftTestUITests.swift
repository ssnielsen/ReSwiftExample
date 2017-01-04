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

        // Act
        app.navigationBars.buttons["Add"].tap()

        let nameTextField = app.textFields["Name"]
        let name = "Søren"
        nameTextField.tap()
        nameTextField.typeText(name)

        let addressTextField = app.textFields["Address"]
        let address = "Main Rd. 2323"
        addressTextField.tap()
        addressTextField.typeText(address)

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
        let phone = "44 35 99 88"
        phoneTextField.tap()
        phoneTextField.typeText(phone)

        app.navigationBars.buttons["Save"].tap()

        // Assert
        waitFor(element: app.tables.cells.staticTexts[name])
        waitFor(element: app.tables.cells.staticTexts[address])
        waitFor(element: app.tables.cells.staticTexts[phone])
    }

    func test_searchCustomerWillShowCustomers() {
        // Arrange
        let app = XCUIApplication()

        // Act
        XCUIDevice.shared().orientation = .portrait

        app.tables.searchFields["Search"].tap()
        app.searchFields["Search"].typeText("Anders Høst")

        // Assert
        waitFor(element: app.tables.cells.staticTexts["Anders Høst"])
        waitFor(element: app.tables.cells.staticTexts["Vejlevej 1"])
        waitFor(element: app.tables.cells.staticTexts["045 45345342"])
    }

    func test_sortingCustomersWillSortCustomersBySelectedSortKey() {
        // Arrange
        let app = XCUIApplication()

        // Act
        app.navigationBars["Customers"].children(matching: .button).element(boundBy: 0).tap()
        app.tables.staticTexts["Name"].tap()

        // Assert
        XCTAssertTrue(app.tables.cells.staticTexts.matching(identifier: "customerCellNameLabel").allElementsBoundByIndex.map { $0.label }.isSorted(by: <))

        // Act
        app.navigationBars["Customers"].children(matching: .button).element(boundBy: 0).tap()
        app.tables.staticTexts["Phone"].tap()

        // Assert
        XCTAssertTrue(app.tables.cells.staticTexts.matching(identifier: "customerCellPhoneLabel").allElementsBoundByIndex.map { $0.label }.isSorted(by: <))
    }

    private func waitFor(element: XCUIElement, timeout: TimeInterval = 5, file: String = #file, line: UInt = #line) {
        let existsPredicate = NSPredicate(format: "exists == true")

        expectation(for: existsPredicate, evaluatedWith: element)

        waitForExpectations(timeout: timeout) { error in
            if (error != nil) {
                let message = "Failed to find \(element) after \(timeout) seconds."
                self.recordFailure(withDescription: message, inFile: file, atLine: line, expected: true)
            }
        }
    }
}

extension Array {
    func isSorted(by isOrderedBefore: (Element, Element) -> Bool) -> Bool {
        for i in 1..<self.count {
            if !isOrderedBefore(self[i-1], self[i]) {
                return false
            }
        }
        return true
    }
}
