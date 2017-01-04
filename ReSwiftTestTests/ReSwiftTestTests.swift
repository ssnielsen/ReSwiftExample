//
//  ReSwiftTestTests.swift
//  ReSwiftTestTests
//
//  Created by Søren Nielsen on 19/12/2016.
//  Copyright © 2016 e-conomic International A/S. All rights reserved.
//

import XCTest
@testable import ReSwiftTest

class ReSwiftTestTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_sortingCustomersByName() {
        // Arrange
        let sortByName = ChangeCustomerSorting(sorting: .name)

        // Act
        mainStore.dispatch(sortByName)

        // Assert
        if case let .done(filteredCustomers)? = mainStore.state.customerState?.filteredCustomers {
            XCTAssertTrue(filteredCustomers.map { $0.name }.isSorted(by: <))
        }
    }

    func test_sortingCustomersByPhone() {
        // Arrange
        let sortByPhone = ChangeCustomerSorting(sorting: .phone)

        // Act
        mainStore.dispatch(sortByPhone)

        // Assert
        if case let .done(filteredCustomers)? = mainStore.state.customerState?.filteredCustomers {
            XCTAssertTrue(filteredCustomers.map { $0.phone }.isSorted(by: <))
        }
    }

    func test_filterCustomers() {
        // Arrange
        let query = "Anders"
        let filterAction = FilterCustomers(query: query)

        // Act
        mainStore.dispatch(filterAction)

        // Assert
        if case let .done(filteredCustomers)? = mainStore.state.customerState?.filteredCustomers {
            filteredCustomers.forEach { XCTAssertTrue($0.name?.contains(query) ?? false) }
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
