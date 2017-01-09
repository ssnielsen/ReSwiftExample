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

let isUiTesting = ProcessInfo.processInfo.arguments.contains("UI-TESTING")
let useTestApi = ProcessInfo.processInfo.arguments.contains("TEST-API")

let api = useTestApi ? TestApi(delayBy: .milliseconds(0)) : TestApi()

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
        window?.tintColor = R.color.app.main()

        // Remove annyoing 1px line below navigation bar
        UINavigationBar.appearance().setBackgroundImage(
            UIImage(),
            for: .any,
            barMetrics: .default
        )

        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().tintColor = .white


        if isUiTesting {
            UIApplication.shared.keyWindow?.layer.speed = 100
            UIView.setAnimationsEnabled(false)
        }

        return true
    }
}
