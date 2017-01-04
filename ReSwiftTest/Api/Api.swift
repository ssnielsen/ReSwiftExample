//
//  Api.swift
//  ReSwiftTest
//
//  Created by Søren Nielsen on 14/12/2016.
//  Copyright © 2016 e-conomic International A/S. All rights reserved.
//

import Foundation
import ReSwift

protocol ApiService {
    func fetchCompany(completion: @escaping (Response<Company>) -> Void)
    func fetchCustomers(completion: @escaping (Response<[Customer]>) -> Void)
    func addCustomer(customer: Customer, completion: @escaping (Response<Customer>) -> Void)
    func deleteCustomer(customer: Customer, completion: @escaping (Response<Customer>) -> Void)
    func updateCustomer(customer: Customer, completion: @escaping (Response<Customer>) -> Void)
}

enum FetchState<T> {
    case loading
    case done(data: T)
    case error(error: Error)

    init(response: Response<T>) {
        switch response {
        case .success(let data):
            self = .done(data: data)
        case .error(let error):
            self = .error(error: error)
        }
    }
}

enum Response<T> {
    case success(data: T)
    case error(error: Error)
}

func fetchCompanyAction(state: AppState, store: Store<AppState>) -> Action? {
    state.api.fetchCompany { response in
        DispatchQueue.main.async {
            mainStore.dispatch(SetCompany(company: FetchState(response: response)))
        }
    }

    return SetCompany(company: .loading)
}

var fetchCustomersAction: Store<AppState>.ActionCreator = { state, store in
    state.api.fetchCustomers { response in
        DispatchQueue.main.async {
            mainStore.dispatch(GetCustomers(customers: FetchState(response: response)))
        }
    }

    return GetCustomers(customers: .loading)
}

func addCustomerAction(newCustomer: Customer) -> Store<AppState>.ActionCreator {
    return { (state, store) in
        state.api.addCustomer(customer: newCustomer) { response in
            DispatchQueue.main.async {
                mainStore.dispatch(AddCustomer(customerToAdd: FetchState(response: response)))
            }
        }

        return AddCustomer(customerToAdd: .loading)
    }
}

func deleteCustomerAction(customer: Customer) -> Store<AppState>.ActionCreator {
    return { (state, store) in
        state.api.deleteCustomer(customer: customer) { response in
            DispatchQueue.main.async {
                mainStore.dispatch(DeleteCustomer(customerToDelete: FetchState(response: response)))
            }
        }

        return DeleteCustomer(customerToDelete: .loading)
    }
}

func updateCustomerAction(customer: Customer) -> Store<AppState>.ActionCreator {
    return { (state, store) in
        state.api.updateCustomer(customer: customer) { response in
            DispatchQueue.main.async {
                mainStore.dispatch(UpdateCustomer(customerToUpdate: FetchState(response: response)))
            }
        }

        return UpdateCustomer(customerToUpdate: .loading)
    }
}
