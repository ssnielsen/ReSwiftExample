//
//  ViewController.swift
//  ReSwiftTest
//
//  Created by Søren Nielsen on 14/12/2016.
//  Copyright © 2016 e-conomic International A/S. All rights reserved.
//

import UIKit
import ReSwift

class CustomersTableViewController: UITableViewController {
    fileprivate var customers = [Customer]()

    
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
        guard let addCustomerController = R.storyboard.addCustomer.instantiateInitialViewController() else {
            return
        }

        present(addCustomerController, animated: true)
    }
}

extension CustomersTableViewController: StoreSubscriber {
    typealias StoreSubscriberStateType = AppState

    func newState(state: StoreSubscriberStateType) {
        if case .loading? = state.customerState?.updatingCustomer {
            title = "Updating customer"
            return
        } else {
            title = ""
        }

        if case .loading? = state.customerState?.deletingCustomer {
            title = "Deleting customer"
            return
        } else {
            title = ""
        }

        if let customers = state.customerState?.customers {
            switch customers {
            case .loading:
                title = "Refreshing"
            case .done(let customers):
                title = ""
                refreshControl?.endRefreshing()
                self.customers = customers.sorted { $0.0.id ?? "" < $0.1.id ?? "" }
                tableView.reloadData()
            case .error(let error):
                title = ""
                print(error)
            case .idle:
                break
            }
        }
    }
}
