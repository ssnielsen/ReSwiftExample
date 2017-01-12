//
//  CustomerReducer.swift
//  ReSwiftTest
//
//  Created by Søren Nielsen on 02/01/2017.
//  Copyright © 2017 e-conomic International A/S. All rights reserved.
//

import Foundation
import ReSwift

extension AppReducer {
    func customersReducer(action: Action, state: AppState?) -> CustomerState? {
        let database = state!.database
        var newState = state?.customerState ?? CustomerState()

        switch action {
        case let action as GetCustomers:
            newState.customers = action.customers

        case let action as AddCustomer:
            guard case .done(_) = action.customerToAdd, case .done(_)? = newState.customers else {
                newState.addingCustomer = action.customerToAdd
                return newState
            }

            newState.addingCustomer = action.customerToAdd
            newState.customers = .done(data: database.getCustomers())

        case let action as UpdateCustomer:
            guard case .done(_) = action.customerToUpdate, case .done(_)? = newState.customers else {
                newState.updatingCustomer = action.customerToUpdate
                return newState
            }

            newState.updatingCustomer = action.customerToUpdate
            newState.customers = .done(data: database.getCustomers())

        case let action as DeleteCustomer:
            guard case .done(_) = action.customerToDelete, case .done(_)? = newState.customers else {
                newState.deletingCustomer = action.customerToDelete
                return newState
            }

            newState.deletingCustomer = nil
            newState.customers = .done(data: database.getCustomers())

        case _ as ResetAddCustomer:
            newState.addingCustomer = nil

        case _ as ResetUpdateCustomer:
            newState.updatingCustomer = nil

        case let action as ChangeCustomerSorting:
            newState.sorting = action.sorting

        default:
            break
        }

        if let action = action as? FilterCustomers {
            newState.query = action.query
        }

        if case let .done(customers)? = newState.customers, let query = newState.query, !query.isEmpty {
            let filteredCustomers = customers.filter { $0.name?.lowercased().contains(query.lowercased()) ?? false }
            newState.filteredCustomers = .done(data: filteredCustomers)
        } else {
            newState.filteredCustomers = newState.customers
        }

        if case let .done(customers)? = newState.filteredCustomers {
            let sortedCustomers = customers.sorted { c1, c2 in
                switch newState.sorting {
                case .name:
                    return c1.name < c2.name
                case .id:
                    return c1.id < c2.id
                case .phone:
                    return c1.phone < c2.phone
                }
            }

            newState.filteredCustomers = .done(data: sortedCustomers)
        }

        return newState
    }
}

func < <T: Comparable>(x: T?, y: T?) -> Bool {
    guard let x = x, let y = y else {
        return false
    }

    return x < y
}
