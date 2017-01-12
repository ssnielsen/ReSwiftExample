//
//  AppState.swift
//  ReSwiftTest
//
//  Created by Søren Nielsen on 14/12/2016.
//  Copyright © 2016 e-conomic International A/S. All rights reserved.
//

import Foundation
import ReSwift

struct AppState: StateType {
    var customerState: CustomerState? = CustomerState()
    var api: ApiService
    var database: DatabaseService

    init(customerState: CustomerState? = nil, api: ApiService, database: DatabaseService) {
        self.customerState = customerState
        self.api = api
        self.database = database
    }
}
