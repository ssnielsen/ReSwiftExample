//
//  Actions.swift
//  ReSwiftTest
//
//  Created by Søren Nielsen on 14/12/2016.
//  Copyright © 2016 e-conomic International A/S. All rights reserved.
//

import Foundation
import ReSwift

struct GetCustomers: Action {
    var customers: FetchState<[Customer]>

    init(customers: FetchState<[Customer]>) {
        self.customers = customers
    }
}

struct FilterCustomers: Action {
    var query: String?
}

struct ChangeCustomerSorting: Action {
    var sorting: CustomerSorting
}

struct AddCustomer: Action {
    var customerToAdd: FetchState<Customer>
}

struct ResetAddCustomer: Action { }
struct ResetUpdateCustomer: Action { }

struct DeleteCustomer: Action {
    var customerToDelete: FetchState<Customer>
}

struct UpdateCustomer: Action {
    var customerToUpdate: FetchState<Customer>
}

enum CustomerSorting {
    case name, phone, id

    static let `default` = CustomerSorting.name
}
