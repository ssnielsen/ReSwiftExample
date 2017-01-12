//
//  ActionCreators.swift
//  ReSwiftTest
//
//  Created by Søren Nielsen on 12/01/2017.
//  Copyright © 2017 e-conomic International A/S. All rights reserved.
//

import Foundation
import ReSwift

var fetchCustomersAction: Store<AppState>.ActionCreator = { state, store in
    // Ask API
    state.api.fetchCustomers { response in
        DispatchQueue.main.async {
            if case let .success(customers) = response {
                // Write API data to local storage
                state.database.add(customers)

                // Re-get the local customers (now including API results)
                let localCustomers = state.database.getCustomers()
                mainStore.dispatch(GetCustomers(customers: .done(data: localCustomers)))
            }
        }
    }

    // Get local customers
    let localCustomers = state.database.getCustomers()

    return GetCustomers(customers: .done(data: localCustomers))
}

func addCustomerAction(newCustomer: Customer) -> Store<AppState>.ActionCreator {
    return { (state, store) in
        state.api.addCustomer(customer: newCustomer) { response in
            DispatchQueue.main.async {
                guard case let .success(customer) = response else {
                    return
                }

                state.database.add(customer)
                mainStore.dispatch(AddCustomer(customerToAdd: .done(data: customer)))
            }
        }

        return AddCustomer(customerToAdd: .loading)
    }
}

func deleteCustomerAction(customer: Customer) -> Store<AppState>.ActionCreator {
    return { (state, store) in
        state.api.deleteCustomer(customer: customer) { response in
            DispatchQueue.main.async {
                guard case let .success(deletedCustomer) = response else {
                    return
                }

                state.database.delete(deletedCustomer)
                mainStore.dispatch(DeleteCustomer(customerToDelete: .done(data: deletedCustomer)))
            }
        }

        return DeleteCustomer(customerToDelete: .loading)
    }
}

func updateCustomerAction(customer: Customer) -> Store<AppState>.ActionCreator {
    return { (state, store) in
        state.api.updateCustomer(customer: customer) { response in
            DispatchQueue.main.async {
                guard case let .success(updatedCustomer) = response else {
                    return
                }

                state.database.update(updatedCustomer)
                mainStore.dispatch(UpdateCustomer(customerToUpdate: FetchState(response: response)))
                mainStore.dispatch(ResetUpdateCustomer())
            }
        }

        return UpdateCustomer(customerToUpdate: .loading)
    }
}
