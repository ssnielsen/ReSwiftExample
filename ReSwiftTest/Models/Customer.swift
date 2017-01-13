//
//  Customer.swift
//  ReSwiftTest
//
//  Created by Søren Nielsen on 02/01/2017.
//  Copyright © 2017 e-conomic International A/S. All rights reserved.
//

import Foundation
import RealmSwift

class Customer: Object {
    dynamic var id: String?
    dynamic var name: String?
    dynamic var address: String?
    dynamic var country: String?
    dynamic var regNo: String?
    dynamic var email: String?
    dynamic var phone: String?
    dynamic var favourited: Bool = false
    dynamic var image: Data?

    convenience init(id: String? = nil, name: String? = nil, address: String? = nil, country: String? = nil, regNo: String? = nil, email: String? = nil, phone: String? = nil, favourited: Bool = false, image: Data? = nil) {
        self.init()

        self.id = id
        self.name = name
        self.address = address
        self.country = country
        self.regNo = regNo
        self.email = email
        self.phone = phone
        self.favourited = favourited
        self.image = image
    }

    override static func primaryKey() -> String {
        return "id"
    }

    override static func indexedProperties() -> [String] {
        return ["name"]
    }

    var initials: String? {
        guard let splitted = name?.components(separatedBy: .whitespaces) else {
            return nil
        }

        if splitted.count == 1 {
            let firstName = splitted.first!

            if firstName.characters.count < 2 {
                return nil
            }

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
