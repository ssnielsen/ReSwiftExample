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

    fileprivate let defaultTitle = "Customers"

    fileprivate let searchController = UISearchController(searchResultsController: nil)
    fileprivate var refreshControlHolder: UIRefreshControl?

    // MARK: UIViewController lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barStyle = .black

        navigationItem.title = defaultTitle
        setupSearch()
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let typedSegue = R.segue.customersTableViewController.editCustomer(segue: segue),
            let indexPath = tableView.indexPathForSelectedRow {
            typedSegue.destination.state = .edit
            typedSegue.destination.customer = customers[indexPath.row]
        }
    }


    // MARK: Private functions

    private func setupSearch() {
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.backgroundColor = .white
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        extendedLayoutIncludesOpaqueBars = true
    }


    // MARK: IBActions

    @IBAction func refresh() {
        mainStore.dispatch(fetchCustomersAction)
    }

    @IBAction func changeSorting(_ sender: UIBarButtonItem) {
        let popoverViewController = PopoverViewController()
        popoverViewController.options = [
            (title: "Name", selected: { _ in mainStore.dispatch(ChangeCustomerSorting(sorting: .name))}),
            (title: "Phone", selected: { _ in mainStore.dispatch(ChangeCustomerSorting(sorting: .phone))}),
        ]
        popoverViewController.popoverPresentationController?.delegate = self
        popoverViewController.popoverPresentationController?.barButtonItem = sender

        present(popoverViewController, animated: true)
    }
}

private extension UILabel {
    func highlight(_ string: String?) {
        guard let text = text, let string = string?.lowercased() else {
            return
        }
        let att = NSMutableAttributedString(string: text)
        let r = (text.lowercased() as NSString).range(of: string, range: NSMakeRange(0, text.characters.count))
        if r.length > 0 {
            att.addAttribute(NSForegroundColorAttributeName, value: R.color.app.main(), range: r)
        }
        attributedText = att
    }
}


// MARK: UITableViewDataSource
extension CustomersTableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = R.reuseIdentifier.customerTableViewCell.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CustomerTableViewCell
        let customer = customers[indexPath.row]

        cell.nameLabel.text = customer.name
        cell.phoneLabel.text = customer.phone
        cell.addressLabel.text = customer.address
        cell.initialsLabel.text = customer.initials?.uppercased()
        cell.favouriteLabel.isHidden = !customer.favourited

        if searchController.isActive {
            cell.nameLabel.highlight(searchController.searchBar.text)
        }

        if let imageData = customer.image, let image = UIImage(data: imageData) {
            cell.circleView.image = image
            cell.initialsLabel.isHidden = true
        } else {
            cell.circleView.image = nil
            cell.initialsLabel.isHidden = false
        }

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

        let customer = customers[indexPath.row]
        let favouriteText = customer.favourited ? "Unfavourite" : "Favourite"
        let favouriteAction = UITableViewRowAction(style: .normal, title: favouriteText) { action, indexPath in
            let umanagedCustomer = Customer(value: customer)
            umanagedCustomer.favourited = !umanagedCustomer.favourited
            mainStore.dispatch(updateCustomerAction(customer: umanagedCustomer))
            tableView.isEditing = false
        }
        
        return [deleteAction, favouriteAction]
    }
}


// MARK: StoreSubscriber
extension CustomersTableViewController: StoreSubscriber {
    typealias StoreSubscriberStateType = AppState

    func newState(state: StoreSubscriberStateType) {
        if case .loading? = state.customerState?.updatingCustomer {
            navigationItem.title = "Updating customer"
            return
        } else {
            navigationItem.title = defaultTitle
        }

        if case .loading? = state.customerState?.deletingCustomer {
            navigationItem.title = "Deleting customer"
            return
        } else {
            navigationItem.title = defaultTitle
        }

        if let customers = state.customerState?.filteredCustomers {
            switch customers {
            case .loading:
                navigationItem.title = "Refreshing"
            case .done(let customers):
                navigationItem.title = defaultTitle
                refreshControl?.endRefreshing()
                self.customers = customers
                tableView.reloadData()
            case .error(let error):
                navigationItem.title = defaultTitle
                print(error)
            }
        }
    }
}


// MARK: UISearchResultsUpdating
extension CustomersTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let query = searchController.searchBar.text {
            mainStore.dispatch(FilterCustomers(query: query))
        }
    }
}


// MARK: UISearchControllerDelegate
extension CustomersTableViewController: UISearchControllerDelegate {
    func didDismissSearchController(_ searchController: UISearchController) {
        mainStore.dispatch(FilterCustomers(query: nil))
        tableView.refreshControl = refreshControlHolder
    }

    func willPresentSearchController(_ searchController: UISearchController) {
        refreshControlHolder = tableView.refreshControl
        tableView.refreshControl = nil
    }
}


extension CustomersTableViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
