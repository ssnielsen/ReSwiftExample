//
//  Database.swift
//  ReSwiftTest
//
//  Created by Søren Nielsen on 12/01/2017.
//  Copyright © 2017 e-conomic International A/S. All rights reserved.
//

import Foundation
import RealmSwift


protocol DatabaseService {
    func getCustomers() -> [Customer]
    func add(_ customers: [Customer])
    func add(_ customer: Customer)
    func update(_ customer: Customer)
    func delete(_ customer: Customer)
}

class RealmDatabase: DatabaseService {
    private lazy var realm: Realm = {
        return try! Realm()
    }()

    func getCustomers() -> [Customer] {
        return realm.objects(Customer.self).toList()
    }

    func add(_ customers: [Customer]) {
        realm.beginWrite()
        realm.add(customers, update: true)
        try! realm.commitWrite()
    }

    func add(_ customer: Customer) {
        realm.beginWrite()
        realm.add(customer)
        try! realm.commitWrite()
    }

    func update(_ customer: Customer) {
        realm.beginWrite()
        realm.add(customer, update: true)
        try! realm.commitWrite()
    }

    func delete(_ customer: Customer) {
        guard let realmCustomer = realm.object(ofType: Customer.self, forPrimaryKey: customer.id) else {
            return
        }

        realm.beginWrite()
        realm.delete(realmCustomer)
        try! realm.commitWrite()
    }
}

fileprivate extension Results {
    func toList() -> [T] {
        return self.map { $0 }
    }
}
