//
//  Router.swift
//  ReSwiftTest
//
//  Created by Søren Nielsen on 14/12/2016.
//  Copyright © 2016 e-conomic International A/S. All rights reserved.
//

import Foundation
import ReSwiftRouter


class RootRoutable: Routable {
    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func changeRouteSegment(_ from: RouteElementIdentifier, to: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) -> Routable {
        <#code#>
    }
}
