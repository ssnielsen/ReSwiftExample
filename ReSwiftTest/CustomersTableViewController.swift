//
//  ViewController.swift
//  ReSwiftTest
//
//  Created by Søren Nielsen on 14/12/2016.
//  Copyright © 2016 e-conomic International A/S. All rights reserved.
//

import UIKit
import ReSwift

class CustomersTableViewController: UITableViewController, StoreSubscriber {
    private var customers = [Customer]()

    
    // MARK: UIViewController lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        refresh()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        mainStore.subscribe(self)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        mainStore.unsubscribe(self)
    }


    // MARK: StoreSubscriber

    typealias StoreSubscriberStateType = AppState

    func newState(state: StoreSubscriberStateType) {
        if let addingCustomer = state.addingCustomer {
            switch addingCustomer {
            case .loading:
                title = "Loading add customer"
            default:
                title = ""
            }

            return
        }

        if let deletingCustomer = state.deletingCustomer {
            switch deletingCustomer {
            case .loading:
                title = "Deleting customer"
            default:
                title = ""
            }

            return
        }

        if let updatingCustomer = state.updatingCustomer {
            switch updatingCustomer {
            case .loading:
                title = "Updating customer"
            default:
                title = ""
            }

            return
        }

        if let customers = state.customers {
            switch customers {
            case .loading:
                title = "Loading"
            case .done(let customers):
                title = ""
                refreshControl?.endRefreshing()
                self.customers = customers.sorted { $0.0.id ?? "" < $0.1.id ?? "" }
                tableView.reloadData()
            case .error(let error):
                title = ""
                print(error)
            }
        }
    }


    // MARK: UITableViewDataSource

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = R.reuseIdentifier.customerTableViewCell.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) ?? UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: identifier)

        let customer = customers[indexPath.row]

        cell.textLabel?.text = customer.name
        cell.detailTextLabel?.text = customer.id
        cell.accessoryType = customer.favourited ? .checkmark : .none

        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customers.count
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { action, indexPath in
            let customer = self.customers[indexPath.row]
            mainStore.dispatch(deleteCustomerAction(customer: customer))

            tableView.beginUpdates()
            self.customers.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }

        var customer = customers[indexPath.row]
        let favouriteText = customer.favourited ? "Unfavourite" : "Favorurite"
        let favouriteAction = UITableViewRowAction(style: .normal, title: favouriteText) { action, indexPath in
            customer.favourited = !customer.favourited
            mainStore.dispatch(updateCustomerAction(customer: customer))
            tableView.isEditing = false
        }

        return [deleteAction, favouriteAction]
    }


    // MARK: IBActions

    @IBAction func refresh() {
        mainStore.dispatch(fetchCustomersAction)
    }

    @IBAction func addCustomer() {
//        let timestamp = Date().timeIntervalSince1970
//        let id = String(timestamp).replacingOccurrences(of: ".", with: "")
//        let customer = Customer(id: id, name: "New Customer \(id)", address: nil, country: nil, regNo: nil, email: nil, phone: nil, favourited: false)
//        mainStore.dispatch(addCustomerAction(newCustomer: customer))

        guard let addCustomerController = R.storyboard.addCustomer.instantiateInitialViewController() else {
            return
        }

        present(addCustomerController, animated: true)
    }
}
