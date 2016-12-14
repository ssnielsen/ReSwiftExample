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

    var navigationState: NavigationState

    var api: Api?
}
