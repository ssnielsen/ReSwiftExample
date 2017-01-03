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
    @IBOutlet weak var initialsLabel: UILabel!
    @IBOutlet weak var circleView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!

    override func layoutSubviews() {
        super.layoutSubviews()

        circleView.clipsToBounds = true
        circleView.layer.cornerRadius = circleView.frame.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            circleView.backgroundColor = R.color.app.main()
        }
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)

        if highlighted {
            circleView.backgroundColor = R.color.app.main()
        }
    }
}
