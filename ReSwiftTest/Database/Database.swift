//
//  Database.swift
//  ReSwiftTest
//
//  Created by Søren Nielsen on 12/01/2017.
//  Copyright © 2017 e-conomic International A/S. All rights reserved.
//

import Foundation

protocol DatabaseService {
    func getCustomers() -> [Customer]
    func add(_ customers: [Customer])
    func add(_ customer: Customer)
    func update(_ customer: Customer)
    func delete(_ customer: Customer)
    func clear()
}
