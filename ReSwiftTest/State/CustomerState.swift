//
//  CustomerState.swift
//  ReSwiftTest
//
//  Created by Søren Nielsen on 02/01/2017.
//  Copyright © 2017 e-conomic International A/S. All rights reserved.
//

import Foundation

struct CustomerState {
    var customers: FetchState<[Customer]>?
    var addingCustomer:  FetchState<Customer>?
    var deletingCustomer:  FetchState<Customer>?
    var updatingCustomer:  FetchState<Customer>?
}