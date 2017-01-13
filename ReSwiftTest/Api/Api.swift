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
