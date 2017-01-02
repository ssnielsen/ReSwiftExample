//
//  LogoPlaceholderView.swift
//  ReSwiftTest
//
//  Created by Søren Nielsen on 02/01/2017.
//  Copyright © 2017 e-conomic International A/S. All rights reserved.
//

import Foundation
import UIKit

class LogoPlaceholderView: UIView {
    @IBOutlet weak var initialsLabel: UILabel!
    @IBOutlet weak var circleView: UIView!

    override func layoutSubviews() {
        super.layoutSubviews()

        circleView.layer.borderWidth = frame.width / 2
        circleView.clipsToBounds = true
    }
}
