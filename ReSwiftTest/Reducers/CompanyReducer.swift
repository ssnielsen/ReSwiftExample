//
//  CompanyReducer.swift
//  ReSwiftTest
//
//  Created by Søren Nielsen on 02/01/2017.
//  Copyright © 2017 e-conomic International A/S. All rights reserved.
//

import Foundation
import ReSwift

extension AppReducer {
    func companyReducer(action: Action, state: AppState?) -> FetchState<Company>? {
        switch action {
        case let action as SetCompany:
            return action.company
        default:
            return nil
        }
    }
}
