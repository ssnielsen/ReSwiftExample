//
//  TestApi.swift
//  ReSwiftTest
//
//  Created by Søren Nielsen on 04/01/2017.
//  Copyright © 2017 e-conomic International A/S. All rights reserved.
//

import Foundation

final class TestApi: ApiService {
    private var delayDuration: DispatchTimeInterval

    init(delayBy duration: DispatchTimeInterval = .milliseconds(500)) {
        self.delayDuration = duration
    }

    private var customers = [
        Customer(id: "1", name: "Anders Høst", address: "Vejlevej 1", country: "Denmark", regNo: "12334534", email: "anders@hqst.com", phone: "045 45345342", favourited: true, image: nil),
        Customer(id: "2", name: "Peter Andersson", address: "H.C. Andersens Boulevard 352", country: "Denmark", regNo: "23495234", email: "peter@peters-shop.com", phone: "23544365", favourited: false, image: nil),
        Customer(id: "3", name: "Sigfried Schweinsteiger", address: "Budapester Straße 432", country: "Germany", regNo: "3534543", email: "info@schweini.com", phone: "3453423", favourited: true, image: nil),
        Customer(id: "4", name: "Alexander Saberdine", address: "Gammalgatan 23", country: "Sweden", regNo: "52343324", email: "info@kompani.se", phone: "11 99 88 77", favourited: true, image: nil),
        Customer(id: "5", name: "Søren Nielsen", address: "Prags Boulevard 50 1 TV", country: "Denmark", regNo: "64553452", email: "ssn@e-conomic.com", phone: "26 55 19 81", favourited: true, image: nil),
        Customer(id: "6", name: "Jostein Johansen", address: "Damstredet 97", country: "Norway", regNo: "7453452", email: "admin@it-sørvis.no", phone: "56 78 55 23", favourited: true, image: nil)
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

    func addCustomer( customer: Customer, completion: @escaping (Response<Customer>) -> Void) {
        var customer = customer
        customer.id = UUID().uuidString
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
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayDuration) {
            operation()
        }
    }
}
