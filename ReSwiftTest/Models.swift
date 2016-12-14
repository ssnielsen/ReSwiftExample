//
//  Contact.swift
//  ReSwiftTest
//
//  Created by Søren Nielsen on 14/12/2016.
//  Copyright © 2016 e-conomic International A/S. All rights reserved.
//

import Foundation

struct Company {
    var name: String?
    var address: String?
    var zip: String?
    var country: String?
    var bankInformation: BankInformation?
    var email: String?
    var phone: String?
}

struct BankInformation {
    var name: String?
    var accountHolder: String?
    var swiftCode: String?
    var iban: String?
    var accountNo: String?
}

struct Customer {
    var id: String?
    var name: String?
    var address: String?
    var country: String?
    var regNo: String?
    var email: String?
    var phone: String?
    var favourited: Bool = false
}
