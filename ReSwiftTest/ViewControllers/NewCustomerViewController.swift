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
import Contacts
import ContactsUI

enum CustomerViewControllerState {
    case create, edit
}

class NewCustomerViewController: UIViewController {
    var customer = Customer()
    var state = CustomerViewControllerState.create

    // MARK: IBOutlets

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var cvrTextFIeld: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var logoImageView: UIImageView!

    // MARK: UIViewController lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        switch state {
        case .create:
            let cancelBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(NewCustomerViewController.cancel(_:)))
            navigationItem.leftBarButtonItem = cancelBarButtonItem
        case .edit:
            navigationItem.title = customer.name
            updateViews(with: customer)
        }

        navigationController?.navigationBar.barStyle = .black
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        mainStore.subscribe(self) { $0.customerState ?? CustomerState() }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        mainStore.unsubscribe(self)
    }

    deinit {
        switch state {
        case .create:
            mainStore.dispatch(ResetAddCustomer())
        case .edit:
            mainStore.dispatch(ResetUpdateCustomer())
        }
    }

    func exit() {
        switch state {
        case .create:
            dismiss(animated: true)
        case .edit:
            let _ = navigationController?.popViewController(animated: true)
        }
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

        if let image = logoImageView.image {
            customer.image = UIImagePNGRepresentation(image)
        }

        switch state {
        case .create:
            mainStore.dispatch(addCustomerAction(newCustomer: customer))
        case .edit:
            mainStore.dispatch(updateCustomerAction(customer: customer))
        }
    }

    @IBAction func importContact(_ sender: UIButton) {
        let pickerViewController = CNContactPickerViewController()
        pickerViewController.delegate = self
        pickerViewController.displayedPropertyKeys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactMiddleNameKey, CNContactEmailAddressesKey, CNContactPostalAddressesKey, CNContactPhoneNumbersKey, CNContactImageDataAvailableKey, CNContactImageDataKey, CNContactThumbnailImageDataKey]
        present(pickerViewController, animated: true)
    }

    @IBAction func findImage(_ sender: UIButton) {
        guard let name = nameTextField.text else {
            return
        }

        findLogo(for: name) { imageData in
            self.logoImageView.image = UIImage(data: imageData)
        }
    }

    private func findLogo(for company: String, completion: @escaping (_ imageData: Data) -> Void) {
        URLSession(configuration: URLSessionConfiguration.default).dataTask(with: URL(string: "https://logo.clearbit.com/\(company.replacingOccurrences(of: " ", with: "")).dk")!) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            if let data = data {
                completion(data)
            }
        }.resume()
    }

    private func updateViews(with customer: Customer) {
        nameTextField.text = customer.name
        addressTextField.text = customer.address
        countryTextField.text = customer.country
        cvrTextFIeld.text = customer.regNo
        emailTextField.text = customer.email
        phoneTextField.text = customer.phone

        if let imageDate = customer.image {
            logoImageView.image = UIImage(data: imageDate)
        }
    }
}

extension NewCustomerViewController: StoreSubscriber {
    typealias StoreSubscriberStateType = CustomerState

    func newState(state: StoreSubscriberStateType) {
        guard let newCustomer = (self.state == .create ? state.addingCustomer : state.updatingCustomer) else {
            return
        }

        switch newCustomer {
        case .loading:
            title = "Saving customer"
        case .done(_):
            exit()
        default:
            break
        }
    }
}

extension NewCustomerViewController: CNContactPickerDelegate {
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        nameTextField.text = contact.givenName + " " + contact.middleName + " " + contact.familyName
        addressTextField.text = contact.postalAddresses.first?.value.street
        phoneTextField.text = contact.phoneNumbers.first?.value.stringValue
        emailTextField.text = contact.emailAddresses.first?.value as? String

        if contact.imageDataAvailable, let imageData = contact.imageData {
            logoImageView.image = UIImage(data: imageData)
        }
    }
}
