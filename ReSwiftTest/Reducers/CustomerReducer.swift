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
        var newState = state?.customerState ?? CustomerState()

        switch action {
        case let action as GetCustomers:
            newState.customers = action.customers
        case let action as AddCustomer:
            guard case let .done(newCustomer) = action.customerToAdd, case let .done(customers)? = newState.customers else {
                newState.addingCustomer = action.customerToAdd
                return newState
            }

            newState.addingCustomer = action.customerToAdd
            newState.customers = .done(data: customers + [newCustomer])

        case let action as UpdateCustomer:
            guard case let .done(updatedCustomer) = action.customerToUpdate, case let .done(customers)? = newState.customers else {
                newState.updatingCustomer = action.customerToUpdate
                return newState
            }

            newState.updatingCustomer = action.customerToUpdate
            let withUpdated = customers.filter { $0.id != updatedCustomer.id } + [updatedCustomer]
            newState.customers = .done(data: withUpdated)

        case let action as DeleteCustomer:
            guard case let .done(deletedCustomer) = action.customerToDelete, case let .done(customers)? = newState.customers else {
                newState.deletingCustomer = action.customerToDelete
                return newState
            }

            let withoutDeleted = customers.filter { $0.id != deletedCustomer.id }
            newState.deletingCustomer = nil
            newState.customers = .done(data: withoutDeleted)

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
