//
//  NewCustomerViewController.swift
//  ReSwiftTest
//
//  Created by Søren Nielsen on 22/12/2016.
//  Copyright © 2016 e-conomic International A/S. All rights reserved.
//

import Foundation
import UIKit
import ReSwift

class NewCustomerViewController: UIViewController {
    private var customer = Customer()


    // MARK: IBOutlets

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var cvrTextFIeld: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!


    // MARK: UIViewController lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        mainStore.subscribe(self) { $0.customerState ?? CustomerState() }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        mainStore.unsubscribe(self)
    }

    
    // MARK: IBActions

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }

    @IBAction func save(_ sender: UIBarButtonItem) {
        customer.name = nameTextField.text
        customer.address = addressTextField.text
        customer.country = countryTextField.text
        customer.regNo = cvrTextFIeld.text
        customer.email = emailTextField.text
        customer.phone = phoneTextField.text

        mainStore.dispatch(addCustomerAction(newCustomer: customer))
    }
}

extension NewCustomerViewController: StoreSubscriber {
    typealias StoreSubscriberStateType = CustomerState

    func newState(state: StoreSubscriberStateType) {
        guard let newCustomer = state.addingCustomer else {
            return
        }

        switch newCustomer {
        case .loading:
            title = "Adding Customer"
        case .done(_):
            dismiss(animated: true)
        case .error(_):
            break
        }
    }
}
