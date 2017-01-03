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
}

struct FilterCustomers: Action {
    var query: String?
}

struct SetCompany: Action {
    var company: FetchState<Company>
}

struct AddCustomer: Action {
    var customerToAdd: FetchState<Customer>
}

struct ResetAddCustomer: Action { }

struct DeleteCustomer: Action {
    var customerToDelete: FetchState<Customer>
}

struct UpdateCustomer: Action {
    var customerToUpdate: FetchState<Customer>
}
