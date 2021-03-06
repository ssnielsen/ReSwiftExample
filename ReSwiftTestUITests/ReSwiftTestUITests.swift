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
        application.launchArguments.append("TEST-API")

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
        XCTAssertTrue(app.tables.cells.staticTexts.matching(identifier: "customerCellNameLabel").allElementsBoundByIndex.map { $0.label }.isSorted(by: <=))

        // Act
        app.navigationBars["Customers"].children(matching: .button).element(boundBy: 0).tap()
        app.tables.staticTexts["Phone"].tap()

        // Assert
        XCTAssertTrue(app.tables.cells.staticTexts.matching(identifier: "customerCellPhoneLabel").allElementsBoundByIndex.map { $0.label }.isSorted(by: <=))
    }

    func test_unfavouriteCustomerWillRemoveStar() {
        // Arrange
        let app = XCUIApplication()
        let favouritedCells = { return app.tables.cells.allElementsBoundByIndex.filter { $0.label.contains("★") } }
        let favouritedBefore = favouritedCells()
        let favouritedCustomerCell = favouritedBefore.first!

        // Act
        favouritedCustomerCell.swipeLeft()
        favouritedCustomerCell.buttons["Unfavourite"].tap()

        // Assert
        let favouritedAfter = favouritedCells()
        XCTAssertEqual(favouritedAfter.count, favouritedBefore.count - 1)
        XCTAssertFalse(favouritedCustomerCell.staticTexts["★"].exists)
    }

    func test_favouriteCustomerWillAddStar() {
        // Arrange
        let app = XCUIApplication()
        let favouritedCells = { return app.tables.cells.allElementsBoundByIndex.filter { $0.label.contains("★") } }
        let unfavouritedCells = { return app.tables.cells.allElementsBoundByIndex.filter { !$0.label.contains("★") } }
        let favouritedBefore = favouritedCells()
        let unfavouritedBefore = unfavouritedCells()
        let unfavouritedCustomerCell = unfavouritedBefore.first!

        // Act
        unfavouritedCustomerCell.swipeLeft()
        unfavouritedCustomerCell.buttons["Favourite"].tap()

        // Assert
        let favouritedAfter = favouritedCells()
        XCTAssertEqual(favouritedAfter.count, favouritedBefore.count + 1)
        XCTAssertTrue(unfavouritedCustomerCell.staticTexts["★"].exists)
    }

    func test_editCustomer() {
        // Arrange
        let app = XCUIApplication()
        let name = "Alexander Saberdine"
        let lastName = "Petersson"
        let newAddress = "Lövvänget 42"
        let newPhoneNumber = "11 22 33 44"

        // Act
        app.tables.staticTexts[name].tap()

        let nameTextField = app.textFields["Name"]
        nameTextField.tap()
        nameTextField.typeText(" \(lastName)")

        let addressTextField = app.textFields["Address"]
        addressTextField.doubleTap()
        app.menuItems["Select All"].tap()
        addressTextField.typeText(newAddress)

        let phoneTextField = app.textFields["Phone"]
        phoneTextField.doubleTap()
        app.menuItems["Select All"].tap()
        phoneTextField.typeText(newPhoneNumber)

        app.navigationBars[name].buttons["Save"].tap()

        // Assert
        XCTAssertTrue(app.tables.staticTexts["\(name) \(lastName)"].exists)
        XCTAssertTrue(app.tables.staticTexts[newAddress].exists)
        XCTAssertTrue(app.tables.staticTexts[newPhoneNumber].exists)
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
