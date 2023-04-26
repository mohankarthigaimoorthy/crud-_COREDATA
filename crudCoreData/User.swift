//
//  User.swift
//  crudCoreData
//
//  Created by Mohan K on 18/03/23.
//

import Foundation
import UIKit
import CoreData

@objc(User)
public class User: NSManagedObject {
    @nonobjc class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }
    @NSManaged public var date: Date?
    @NSManaged public var text: String?
    @NSManaged public var title: String?
    @NSManaged public var priorityColor: UIColor?
    @NSManaged public var img: Data?

}

extension User : Identifiable {

}
