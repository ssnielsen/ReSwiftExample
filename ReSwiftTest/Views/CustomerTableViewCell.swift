//
//  CustomerTableViewCell.swift
//  ReSwiftTest
//
//  Created by Søren Nielsen on 02/01/2017.
//  Copyright © 2017 e-conomic International A/S. All rights reserved.
//

import Foundation
import UIKit

class CustomerTableViewCell: UITableViewCell {
    @IBOutlet weak var logoPlaceholderView: LogoPlaceholderView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        customInit()
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        customInit()
    }

    private func customInit() {
        logoPlaceholderView = R.nib.logoPlaceholderView.firstView(owner: self)
    }
}
