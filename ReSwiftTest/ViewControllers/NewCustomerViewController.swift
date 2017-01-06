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

class NewCustomerViewController: UIViewController {
    private var customer = Customer()

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

        navigationController?.navigationBar.barStyle = .black

        for item in self.extensionContext?.inputItems as! [NSExtensionItem] {
            dump(item)
        }
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
        mainStore.dispatch(ResetAddCustomer())
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

        mainStore.dispatch(addCustomerAction(newCustomer: customer))
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

    func select(contact: CNContact) {
        nameTextField.text = contact.givenName
        /*nameTextField.text = contact.givenName + " " + contact.middleName + " " + contact.familyName
        addressTextField.text = contact.postalAddresses.first?.value.street
        phoneTextField.text = contact.phoneNumbers.first?.value.stringValue
        emailTextField.text = contact.emailAddresses.first?.value as? String

        if contact.imageDataAvailable, let imageData = contact.imageData {
            logoImageView.image = UIImage(data: imageData)
        }*/
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
            title = "Saving customer"
        case .done(_):
            dismiss(animated: true)
        default:
            break
        }
    }
}

extension NewCustomerViewController: CNContactPickerDelegate {
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        select(contact: contact)
    }
}
