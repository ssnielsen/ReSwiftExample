//
//  Reducers.swift
//  ReSwiftTest
//
//  Created by Søren Nielsen on 14/12/2016.
//  Copyright © 2016 e-conomic International A/S. All rights reserved.
//

import Foundation
import ReSwift

struct AppReducer: Reducer {
    typealias ReducerStateType = AppState

    func handleAction(action: Action, state: AppState?) -> AppState {
        return AppState(
            company: companyReducer(action: action, state: state),
            customerState: customersReducer(action: action, state: state),
            api: state?.api ?? TestApi()
        )
    }
}
