//
//  Customer.swift
//  ReSwiftTest
//
//  Created by Søren Nielsen on 02/01/2017.
//  Copyright © 2017 e-conomic International A/S. All rights reserved.
//

import Foundation

struct Customer {
    var id: String?
    var name: String?
    var address: String?
    var country: String?
    var regNo: String?
    var email: String?
    var phone: String?
    var favourited: Bool = false

    var initials: String? {
        guard let splitted = name?.components(separatedBy: .whitespaces) else {
            return nil
        }

        if splitted.count == 1 {
            let firstName = splitted.first!
            return firstName.substring(to: firstName.index(firstName.startIndex, offsetBy: 2))
        } else if splitted.count >= 2 {
            let firstName = splitted.first!
            let lastName = splitted.last!
            let firstInitial = firstName.substring(to: firstName.index(firstName.startIndex, offsetBy: 1))
            let lastInitial = lastName.substring(to: firstName.index(firstName.startIndex, offsetBy: 1))
            return firstInitial + lastInitial
        }

        return nil
    }
}
