//
//  User+CoreDataProperties.swift
//  TinderUser
//
//  Created by Rajneesh Kumar on 7/24/20.
//  Copyright © 2020 Rajneesh Kumar. All rights reserved.
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }
    @NSManaged public var userName: String?
    @NSManaged public var userData: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var title: String?
    @NSManaged public var imgUrl: String?

    var personFullName: String {
        get {
            return "\(title ?? "") \(firstName ?? "") \(lastName ?? "")".trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
    func getTheDict() -> [String:Any] {
      return  dictionaryWithValues(forKeys: ["userName","firstName","lastName","title","imgUrl"])
    }
}
