//
//  Api.swift
//  ReSwiftTest
//
//  Created by Søren Nielsen on 14/12/2016.
//  Copyright © 2016 e-conomic International A/S. All rights reserved.
//

import Foundation
import ReSwift

protocol Api {
    func fetchCompany(completion: @escaping (Response<Company>) -> Void)
    func fetchCustomers(completion: @escaping (Response<[Customer]>) -> Void)
    func addCustomer(customer: Customer, completion: @escaping (Response<Customer>) -> Void)
    func deleteCustomer(customer: Customer, completion: @escaping (Response<Customer>) -> Void)
    func updateCustomer(customer: Customer, completion: @escaping (Response<Customer>) -> Void)
}

struct ApiConfiguration {
    var endpoint: String
    var apiKey: String
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

let testApiConfiguration = ApiConfiguration(endpoint: "htts://testservice.com", apiKey: "ab487c9487f897e8978d987dd")

class TestApi: Api {
    var customers = [
        Customer(id: "1", name: "Anders Høst", address: "Vejlevej 1", country: "Denmark", regNo: "12334534", email: "anders@hqst.com", phone: "045 45345342", favourited: true),
        Customer(id: "2", name: "Peter Andersson", address: "H.C. Andersens Boulevard 352", country: "Denmark", regNo: "23495234", email: "peter@peters-shop.com", phone: "23544365", favourited: false),
        Customer(id: "3", name: "Sigfried Schweinsteiger", address: "Budapester Straße 432", country: "Germany", regNo: "3534543", email: "info@schweini.com", phone: "3453423", favourited: true)
    ]

    func fetchCompany(completion: @escaping (Response<Company>) -> Void) {
        let company = Company(
            name: "EC Sporting ApS",
            address: "Langebrogade 1",
            zip: "2300",
            country: "Denmark",
            bankInformation: BankInformation(),
            email: "ssn@e-conomic.com",
            phone: "+45 26551981")

        delay {
            completion(.success(data: company))
        }
    }

    func fetchCustomers(completion: @escaping (Response<[Customer]>) -> Void) {
        delay {
            completion(.success(data: self.self.customers))
        }
    }

    func addCustomer(customer: Customer, completion: @escaping (Response<Customer>) -> Void) {
        customers.append(customer)
        delay {
            completion(.success(data: customer))
        }
    }

    func deleteCustomer(customer: Customer, completion: @escaping (Response<Customer>) -> Void) {
        customers = customers.filter { $0.id != customer.id }
        delay {
            var deletedCustomer = Customer()
            deletedCustomer.id = customer.id
            completion(.success(data: deletedCustomer))
        }
    }

    func updateCustomer(customer: Customer, completion: @escaping (Response<Customer>) -> Void) {
        customers = customers.filter { $0.id != customer.id }
        customers.append(customer)
        delay {
            completion(.success(data: customer))
        }
    }

    private func delay(operation: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
            operation()
        }
    }
}

func fetchCompanyAction(state: AppState, store: Store<AppState>) -> Action? {
    guard let api = state.api else { return nil }

    api.fetchCompany { response in
        DispatchQueue.main.async {
            mainStore.dispatch(SetCompany(company: FetchState(response: response)))
        }
    }

    return SetCompany(company: .loading)
}

func fetchCustomersAction(state: AppState, store: Store<AppState>) -> Action? {
    guard let api = state.api else { return nil }

    api.fetchCustomers { response in
        DispatchQueue.main.async {
            mainStore.dispatch(SetCustomers(customers: FetchState(response: response)))
        }
    }

    return SetCustomers(customers: .loading)
}

func addCustomerAction(newCustomer: Customer) -> (_ state: AppState, _ store: Store<AppState>) -> Action? {
    return { (state, store) in
        guard let api = state.api else { return nil }

        api.addCustomer(customer: newCustomer) { response in
            DispatchQueue.main.async {
                mainStore.dispatch(AddCustomer(customerToAdd: FetchState(response: response)))
            }
        }

        return AddCustomer(customerToAdd: .loading)
    }
}

func deleteCustomerAction(customer: Customer) -> (_ state: AppState, _ store: Store<AppState>) -> Action? {
    return { (state, store) in
        guard let api = state.api else { return nil }

        api.deleteCustomer(customer: customer) { response in
            DispatchQueue.main.async {
                mainStore.dispatch(DeleteCustomer(customerToDelete: FetchState(response: response)))
            }
        }

        return DeleteCustomer(customerToDelete: .loading)
    }
}

func updateCustomerAction(customer: Customer) -> (_ state: AppState, _ store: Store<AppState>) -> Action? {
    return { (state, store) in
        guard let api = state.api else { return nil }

        api.updateCustomer(customer: customer) { response in
            DispatchQueue.main.async {
                mainStore.dispatch(UpdateCustomer(customerToUpdate: FetchState(response: response)))
            }
        }

        return UpdateCustomer(customerToUpdate: .loading)
    }
}
