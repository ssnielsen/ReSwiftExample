//
//  PopoverViewController.swift
//  ReSwiftTest
//
//  Created by Søren Nielsen on 04/01/2017.
//  Copyright © 2017 e-conomic International A/S. All rights reserved.
//

import Foundation
import UIKit


class PopoverViewController: UITableViewController {
    typealias Option = (title: String, selected: (_ indexPath : IndexPath) -> Void)

    var options = [Option]()

    override var modalPresentationStyle: UIModalPresentationStyle {
        get { return .popover }
        set { }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        preferredContentSize = tableView.rect(forSection: 0).size
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "popoverCellIdentifier"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) ?? UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
        let option = options[indexPath.row]
        cell.textLabel?.text = option.title
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        options[indexPath.row].selected(indexPath)
        dismiss(animated: true)
    }
}
