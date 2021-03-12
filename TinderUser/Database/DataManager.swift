//
//  DataManager.swift
//  TinderUser
//
//  Created by Rajneesh Kumar on 7/24/20.
//  Copyright © 2020 Rajneesh Kumar. All rights reserved.
//

import Foundation
import CoreData
let coreDataModelName = "UserSample"
class DataManager: NSObject {
    
    static let shareInstance = DataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: coreDataModelName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    //Insert new object
    class func insertNewObject(myClass:AnyClass, context:NSManagedObjectContext) -> AnyObject? {
        let obj = NSEntityDescription.insertNewObject(forEntityName: String(describing: myClass), into: context)
        return obj
    }

    class func getModelObjects (myClass : AnyClass, predicate: NSPredicate?, _ parentContext:NSManagedObjectContext?) -> Array<AnyObject> {
        var allObjects : Array<AnyObject> = Array()
        let context : NSManagedObjectContext = self.shareInstance.persistentContainer.viewContext
        let entity : NSEntityDescription? = NSEntityDescription.entity(forEntityName: String(describing: myClass), in: context)
        if let entity = entity {
            let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName:  entity.name!)
            if let predicate = predicate {
                fetchRequest.predicate = predicate
            }
            do {
                try allObjects = context.fetch(fetchRequest) as [AnyObject]
            } catch let error{
                debugPrint("Error\(error)")
            }
        }
        return allObjects
    }
}
