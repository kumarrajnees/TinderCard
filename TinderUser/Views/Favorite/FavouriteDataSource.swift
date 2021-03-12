//
//  FavouriteDataSource.swift
//  TinderUser
//
//  Created by Rajneesh Kumar on 7/26/20.
//  Copyright © 2020 Rajneesh Kumar. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class FavouriteDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
       
        var tableView: UITableView?
        private var managedObjectContext =  DataManager.shareInstance.persistentContainer.viewContext
        lazy var fetchedResultsController: NSFetchedResultsController<User>  =  {
            let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
            // Add Sort Descriptors
             let sortDescriptor = NSSortDescriptor(key: "firstName", ascending: true)
             fetchRequest.sortDescriptors = [sortDescriptor]
             // Initialize Fetched Results Controller
             let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
             // Configure Fetched Results Controller
             controller.delegate = self
             return controller
        }()
    
        func loadData() {
            do {
                try fetchedResultsController.performFetch()
                tableView?.reloadData()
            } catch {
                print("Fetch failed")
            }
        }
        //MARK:- TableView Delegates and DataSource
        func numberOfSections(in tableView: UITableView) -> Int { fetchedResultsController.sections?.count ?? 0
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            guard let sections = fetchedResultsController.sections else {
                return 0
            }
            return sections[section].numberOfObjects
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let sections = fetchedResultsController.sections, let items = sections[indexPath.section].objects?[indexPath.row] as? User else {
                return UITableViewCell()
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: FavTableCell.className) as? FavTableCell
            var dict =  items.getTheDict()
            dict["personName"] = items.personFullName
            cell?.userData = dict
            return cell ?? UITableViewCell()
        }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }
}

extension FavouriteDataSource: NSFetchedResultsControllerDelegate {
    
}
