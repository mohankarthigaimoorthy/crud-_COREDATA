//
//  DataHelper.swift
//  crudCoreData
//
//  Created by Mohan K on 18/03/23.
//

import Foundation
import CoreData
import UIKit

class DataHelper {
    static let sharedInstance = DataHelper()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func exampleImage(data: Data) {
        let imageInstance = User(context: context)
        imageInstance.img = data
        do {
            try context.save()
            print("Image is Saved")
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchUser() -> [User] {
        var fetchingUser = [User] ()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        do {
            fetchingUser = try
            context.fetch(fetchRequest) as! [User]
        }
        catch {
            print ("Error while fetching the image")

        }
        return fetchingUser
    }
}
