//
//  Reducers.swift
//  ReSwiftTest
//
//  Created by Søren Nielsen on 14/12/2016.
//  Copyright © 2016 e-conomic International A/S. All rights reserved.
//

import Foundation
import ReSwift
import ReSwiftRouter

struct AppReducer: Reducer {
    typealias ReducerStateType = AppState

    func handleAction(action: Action, state: AppState?) -> AppState {
        return AppState(
            company: companyReducer(action: action, state: state),
            customerState: customersReducer(action: action, state: state),
            navigationState: NavigationReducer.handleAction(action, state: state?.navigationState),
            api: state?.api ?? TestApi()
        )
    }

    private func companyReducer(action: Action, state: AppState?) -> FetchState<Company>? {
        switch action {
        case let action as SetCompany:
            return action.company
        default:
            return nil
        }
    }

    private func customersReducer(action: Action, state: AppState?) -> CustomerState? {
        var newState = state?.customerState ?? CustomerState()

        switch action {
        case let action as GetCustomers:
            newState.customers = action.customers
        case let action as AddCustomer:
            guard case let .done(newCustomer) = action.customerToAdd, case let .done(customers)? = newState.customers else {
                newState.addingCustomer = action.customerToAdd
                return newState
            }

            newState.addingCustomer = nil
            newState.customers = .done(data: customers + [newCustomer])
        case let action as UpdateCustomer:
            guard case let .done(updatedCustomer) = action.customerToUpdate, case let .done(customers)? = newState.customers else {
                newState.updatingCustomer = action.customerToUpdate
                return newState
            }

            let withUpdated = customers.filter { $0.id != updatedCustomer.id } + [updatedCustomer]
            newState.updatingCustomer = nil
            newState.customers = .done(data: withUpdated)
        case let action as DeleteCustomer:
            guard case let .done(deletedCustomer) = action.customerToDelete, case let .done(customers)? = newState.customers else {
                newState.deletingCustomer = action.customerToDelete
                return newState
            }

            let withoutDeleted = customers.filter { $0.id != deletedCustomer.id }
            newState.deletingCustomer = nil
            newState.customers = .done(data: withoutDeleted)
        default:
            return newState
        }

        return newState







        /*switch action {
        case let action as SetCustomers:
            return (action.customers, state?.addingCustomer, state?.deletingCustomer, state?.updatingCustomer)
        case let action as AddCustomer:
            guard
                case let .done(newCustomer) = action.customerToAdd,
                case let .done(customers)? = state?.customers
            else {
                return (state?.customers, action.customerToAdd, state?.deletingCustomer, state?.updatingCustomer)
            }

            return (.done(data: customers + [newCustomer]), nil, state?.deletingCustomer, state?.updatingCustomer)
        case let action as DeleteCustomer:
            guard
                case let .done(deletedCustomer) = action.customerToDelete,
                case let .done(customers)? = state?.customers
            else {
                return (state?.customers, state?.addingCustomer, action.customerToDelete, state?.updatingCustomer)
            }

            let customersWithoutDeleted = customers.filter { $0.id != deletedCustomer.id }
            return (.done(data: customersWithoutDeleted), state?.addingCustomer, nil, state?.updatingCustomer)
        case let action as UpdateCustomer:
            guard
                case let .done(updatedCustomer) = action.customerToUpdate,
                case let .done(customers)? = state?.customers
            else {
                return (state?.customers, state?.addingCustomer, state?.deletingCustomer, action.customerToUpdate)
            }

            let updatedCustomers = customers.filter { $0.id != updatedCustomer.id } + [updatedCustomer]
            return (.done(data: updatedCustomers), state?.addingCustomer, state?.deletingCustomer, nil)
        default:
            return (state?.customers, state?.addingCustomer, state?.deletingCustomer, state?.updatingCustomer)
        }*/
    }
}
