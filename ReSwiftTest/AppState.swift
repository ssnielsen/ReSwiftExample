//
//  AppState.swift
//  ReSwiftTest
//
//  Created by Søren Nielsen on 14/12/2016.
//  Copyright © 2016 e-conomic International A/S. All rights reserved.
//

import Foundation
import ReSwift
import ReSwiftRouter

struct AppState: StateType {
    var company: FetchState<Company>?
    var customers: FetchState<[Customer]>?
    var addingCustomer:  FetchState<Customer>?
    var deletingCustomer:  FetchState<Customer>?
    var updatingCustomer:  FetchState<Customer>?

    var navigationState: NavigationState?

    var api: ApiService

    init(company: FetchState<Company>? = nil,
         customers: FetchState<[Customer]>? = nil,
         addingCustomer:  FetchState<Customer>? = nil,
         deletingCustomer:  FetchState<Customer>? = nil,
         updatingCustomer:  FetchState<Customer>? = nil,
         navigationState: NavigationState? = nil,
         api: ApiService) {
        self.company = company
        self.customers = customers
        self.addingCustomer = addingCustomer
        self.deletingCustomer = deletingCustomer
        self.updatingCustomer = updatingCustomer
        self.navigationState = navigationState
        self.api = api
    }
}
