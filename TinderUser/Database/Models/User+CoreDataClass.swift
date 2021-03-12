//
//  User+CoreDataClass.swift
//  TinderUser
//
//  Created by Rajneesh Kumar on 7/24/20.
//  Copyright © 2020 Rajneesh Kumar. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import SwiftyJSON
@objc(User)
public class User: NSManagedObject {

    class func getDataFromServer(completion : @escaping (responsHandler)) {
        APIService.getUserData { (result) in
            completion(result)
        }
    }
    class func saveUserData(personJson:JSON?) {
        guard let json = personJson else { return }
        let container = DataManager.shareInstance.persistentContainer
        container.performBackgroundTask { (privatecontext) in
                privatecontext.performAndWait { () -> Void in
                    let userid = json["login"]["username"].stringValue
                    let userobj = DataManager.insertNewObject(myClass: self, context: privatecontext) as? User
                    userobj?.userName = userid
                    userobj?.userData = json.rawString()
                    userobj?.title = json["name"]["title"].stringValue
                    userobj?.firstName = json["name"]["first"].stringValue
                    userobj?.lastName = json["name"]["last"].stringValue
                    userobj?.imgUrl = json["picture"]["medium"].stringValue
                    do {
                        try privatecontext.save()
                        DataManager.shareInstance.saveContext()
                    } catch {
                    }

            }
        }
    }
    
    class func getAllUsers() {
       let list = DataManager.getModelObjects(myClass: self, predicate: nil, DataManager.shareInstance.persistentContainer.viewContext) as? [User]
        print(list?.count)
    }
    
}
