//
//  AppDelegate.swift
//  ReSwiftTest
//
//  Created by Søren Nielsen on 14/12/2016.
//  Copyright © 2016 e-conomic International A/S. All rights reserved.
//

import UIKit
import ReSwift

let loggingMiddleware: Middleware = { dispatch, state in
    return { next in
        return { action in
            dump(action)
            return next(action)
        }
    }
}

let api = ProcessInfo.processInfo.arguments.contains("UI-TESTING") ? TestApi() : TestApi()

let state = AppState(api: api)

let mainStore = Store<AppState>(
    reducer: AppReducer(),
    state: state,
    middleware: [loggingMiddleware]
)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
    }
}
