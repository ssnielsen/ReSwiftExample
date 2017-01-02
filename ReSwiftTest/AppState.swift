//
//  AppState.swift
//  ReSwiftTest
//
//  Created by Søren Nielsen on 14/12/2016.
//  Copyright © 2016 e-conomic International A/S. All rights reserved.
//

import Foundation
import ReSwift

struct AppState: StateType {
    var company: FetchState<Company>?
    var customerState: CustomerState? = CustomerState()

    var api: ApiService

    init(company: FetchState<Company>? = nil,
         customerState: CustomerState? = nil,
         api: ApiService) {
        self.company = company
        self.customerState = customerState
        self.api = api
    }
}


struct CustomerState {
    var customers: FetchState<[Customer]>?
    var addingCustomer:  FetchState<Customer>?
    var deletingCustomer:  FetchState<Customer>?
    var updatingCustomer:  FetchState<Customer>?
}
