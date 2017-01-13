//
//  KIFTests.swift
//  ReSwiftTest
//
//  Created by Søren Nielsen on 13/01/2017.
//  Copyright © 2017 e-conomic International A/S. All rights reserved.
//

import Foundation
import KIF
import Fakery
@testable import ReSwiftTest

class KIFTests: KIFTestCase {

    private let SORT_BAR_BUTTON = "sortBarButton"
    private let CUSTOMER_SORT_TABLE_VIEW = "customerSortTableView"
    private let CUSTOMER_TABLE_VIEW = "customerTableView"
    private let FAVOURITE_CUSTOMER_ROW_ACTION = "favouriteCustomerRowAction"
    private let ADD_CUSTOMER_BAR_BUTTON = "addCustomerBarButton"
    private let NAME_TEXT_FIELD = "nameTextField"
    private let ADDRESS_TEXT_FIELD = "addressTextField"
    private let COUNTRY_TEXT_FIELD = "countryTextField"
    private let CVR_TEXT_FIELD = "cvrTextField"
    private let EMAIL_TEXT_FIELD = "emailTextField"
    private let PHONE_TEXT_FIELD = "phoneTextField"
    private let SAVE_BAR_BUTTON = "saveBarButton"
    private let CUSTOMER_SEARCH_BAR = "customerSearchBar"

    private let faker = Faker()

    override func setUp() {
        super.setUp()

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }

    func test_addCustomerWillAddCustomerToTable() {
        // Arrange
        let name = faker.name.name()
        let fakerAddress = faker.address
        let address = fakerAddress.streetAddress()
        let country = fakerAddress.country()
        let cvr = faker.phoneNumber.cellPhone()
        let email = faker.internet.email()
        let phone = faker.phoneNumber.phoneNumber()

        // Act
        tester.tapView(withAccessibilityLabel: ADD_CUSTOMER_BAR_BUTTON)
        tester.enterText(name, intoViewWithAccessibilityLabel: NAME_TEXT_FIELD)
        tester.enterText(address, intoViewWithAccessibilityLabel: ADDRESS_TEXT_FIELD)
        tester.enterText(country, intoViewWithAccessibilityLabel: COUNTRY_TEXT_FIELD)
        tester.enterText(cvr, intoViewWithAccessibilityLabel: CVR_TEXT_FIELD)
        tester.enterText(email, intoViewWithAccessibilityLabel: EMAIL_TEXT_FIELD)
        tester.enterText(phone, intoViewWithAccessibilityLabel: PHONE_TEXT_FIELD)
        tester.tapView(withAccessibilityLabel: SAVE_BAR_BUTTON)

        // Assert
        XCTAssertTrue(
            customerCells.contains {
                $0.nameLabel.text == name
                && $0.addressLabel.text == address
                && $0.phoneLabel.text == phone
            }
        )
    }

    func test_searchCustomerWillShowCustomers() {
        // Arrange
        let name = "Anders"

        // Act
        tester.enterText(name, intoViewWithAccessibilityLabel: CUSTOMER_SEARCH_BAR)

        // Assert
        let cells = customerCells
        cells.forEach {
            XCTAssertTrue($0.nameLabel.text!.contains(name))
        }

        tester.tapView(withAccessibilityLabel: "Cancel")
    }


    func test_sortingCustomersByName() {
        // Act
        tester.tapView(withAccessibilityLabel: SORT_BAR_BUTTON)
        let sortTableView = tester.waitForView(withAccessibilityLabel: CUSTOMER_SORT_TABLE_VIEW) as! UITableView
        let sortCells = sortTableView.visibleCells()
        let nameCell = sortCells.first { $0.textLabel?.text == "Name" }
        nameCell!.tap()

        // Assert
        let names = customerCells.map { $0.nameLabel.text }
        XCTAssertTrue(names.isSorted(by: <))
    }

    func test_sortingCustomersByPhone() {
        // Act
        tester.tapView(withAccessibilityLabel: SORT_BAR_BUTTON)
        let sortTableView = tester.waitForView(withAccessibilityLabel: CUSTOMER_SORT_TABLE_VIEW) as! UITableView
        let sortCells = sortTableView.visibleCells()
        let nameCell = sortCells.first { $0.textLabel?.text == "Phone" }
        nameCell!.tap()

        // Assert
        let names = customerCells.map { $0.phoneLabel.text }
        XCTAssertTrue(names.isSorted(by: <))
    }

    func test_unfavouriteCustomerWillRemoveStar() {
        // Arrange
        let favouritedCells = { self.customerCells.filter { !$0.favouriteLabel.isHidden } }
        let favouritedBefore = favouritedCells()
        let favouritedCell = favouritedBefore.first!
        let favouritedCellIndexPath = customerTableView.indexPath(for: favouritedCell)

        // Act
        tester.swipeRow(at: favouritedCellIndexPath, in: customerTableView, in: .left)
        tester.waitForView(withAccessibilityLabel: FAVOURITE_CUSTOMER_ROW_ACTION).tap()

        // Assert
        let favouritedAfter = favouritedCells()
        XCTAssertEqual(favouritedAfter.count, favouritedBefore.count - 1)
        XCTAssertTrue(favouritedCell.favouriteLabel.isHidden)
    }

    func test_favouriteCustomerWillAddStar() {
        // Arrange
        let favouritedCells = { self.customerCells.filter { !$0.favouriteLabel.isHidden } }
        let unfavouritedCells = { self.customerCells.filter { $0.favouriteLabel.isHidden } }
        let favouritedBefore = favouritedCells()
        let unfavouritedBefore = unfavouritedCells()
        let unfavouritedCell = unfavouritedBefore.first!
        let unfavouritedCellIndexPath = customerTableView.indexPath(for: unfavouritedCell)

        // Act
        tester.swipeRow(at: unfavouritedCellIndexPath, in: customerTableView, in: .left)
        tester.waitForView(withAccessibilityLabel: FAVOURITE_CUSTOMER_ROW_ACTION).tap()

        // Assert
        let favouritedAfter = favouritedCells()
        XCTAssertEqual(favouritedAfter.count, favouritedBefore.count + 1)
        XCTAssertFalse(unfavouritedCell.favouriteLabel.isHidden)
    }

    func test_editCustomer() {
        // Arrange
        let row = faker.number.randomInt(min: 0, max: customerCells.count - 1)
        let cell = customerCells[row]
        let name = cell.nameLabel.text
        let lastName = faker.name.lastName()
        let newAddress = faker.address.streetAddress()
        let newPhoneNumber = faker.phoneNumber.cellPhone()

        // Act
        cell.tap()
        tester.enterText(" \(lastName)", intoViewWithAccessibilityLabel: NAME_TEXT_FIELD)
        tester.clearText(fromAndThenEnterText: newAddress, intoViewWithAccessibilityLabel: ADDRESS_TEXT_FIELD)
        tester.clearText(fromAndThenEnterText: newPhoneNumber, intoViewWithAccessibilityLabel: PHONE_TEXT_FIELD)
        tester.tapView(withAccessibilityLabel: SAVE_BAR_BUTTON)

        // Assert
        XCTAssertTrue(cell.nameLabel.text == "\(name) \(lastName)")
        XCTAssertTrue(cell.addressLabel.text == newAddress)
        XCTAssertTrue(cell.phoneLabel.text == newPhoneNumber)
    }

    private var customerCells: [CustomerTableViewCell] {
        return customerTableView.visibleCells()
    }

    private var customerTableView: UITableView {
        return tester.waitForView(withAccessibilityLabel: CUSTOMER_TABLE_VIEW) as! UITableView
    }

    private var sortTableView: UITableView {
        return tester.waitForView(withAccessibilityLabel: CUSTOMER_SORT_TABLE_VIEW) as! UITableView
    }
}


extension XCTestCase {
    var tester: KIFUITestActor { return tester() }
    var system: KIFSystemTestActor { return system() }

    func tester(file : String = #file, _ line : Int = #line) -> KIFUITestActor {
        return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }

    func system(file : String = #file, _ line : Int = #line) -> KIFSystemTestActor {
        return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }
}

extension KIFTestActor {
    func tester(file : String = #file, _ line : Int = #line) -> KIFUITestActor {
        return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }

    func system(file : String = #file, _ line : Int = #line) -> KIFSystemTestActor {
        return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }
}

extension UITableView {
    func visibleCells<T: UITableViewCell>() -> [T] {
        var cells = [T]()
        for section in 0..<numberOfSections {
            for row in 0..<numberOfRows(inSection: section) {
                (cellForRow(at: IndexPath(row: row, section: section)) as? T).flatMap { cells.append($0) }
            }
        }
        return cells
    }
}
