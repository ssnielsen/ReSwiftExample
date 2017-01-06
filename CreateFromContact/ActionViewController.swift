//
//  ActionViewController.swift
//  CreateFromContact
//
//  Created by Søren Nielsen on 06/01/2017.
//  Copyright © 2017 e-conomic International A/S. All rights reserved.
//

import UIKit
import MobileCoreServices
import Contacts

class ActionViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Get the item[s] we're handling from the extension context.
        
        // For example, look for an image and place it into an image view.
        // Replace this with something appropriate for the type[s] your extension supports.
        var imageFound = false
        let itemTypeString = kUTTypeVCard as String
        for item in self.extensionContext!.inputItems as! [NSExtensionItem] {
            for provider in item.attachments! as! [NSItemProvider] {
                if provider.hasItemConformingToTypeIdentifier(itemTypeString) {
                    provider.loadItem(forTypeIdentifier: itemTypeString, options: nil, completionHandler: { (vCardData, error) in
                        do {
                            if let contact = try CNContactVCardSerialization.contacts(with: vCardData as! Data).first {
                                self.performSegue(withIdentifier: "newCustomerFromExtension", sender: contact)
                            }

                        } catch {
                        }
                    })
                    
                    imageFound = true
                    break
                }
            }
            
            if (imageFound) {
                // We only handle one image, so stop looking for more.
                break
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newCustomerFromExtension" {
            if let navController = segue.destination as? UINavigationController {
                if let addCustomerController = navController.viewControllers.first as? NewCustomerViewController {
                    addCustomerController.contact = sender as! CNContact
                    addCustomerController.state = .fromExtension
                    dismiss(animated: false)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        self.extensionContext!.completeRequest(returningItems: self.extensionContext!.inputItems, completionHandler: nil)
    }

}
