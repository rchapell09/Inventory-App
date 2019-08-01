//
//  itemfunctions.swift
//  classproject
//
//  Created by rchapell on 11/19/18.
//  Copyright © 2018 rchapell. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class itemfunctions{
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func addnewitem(name: String, cat: String){
        let ent = NSEntityDescription.entity(forEntityName: "ItemEntity", in: self.managedObjectContext)
        
        let newItem = ItemEntity(entity: ent!, insertInto: self.managedObjectContext)
        newItem.itemName = name
        newItem.itemQuantity = 0
        newItem.itemCat = cat
        let pic = UIImage(named: "boba.png")
        newItem.itemPic = UIImagePNGRepresentation(pic!)! as NSData
        print(newItem)
        // save the updated context
        do {
            try self.managedObjectContext.save()
        } catch _ {
            print("did not save")
        }
    }
    func deleteitem(item: ItemEntity){
        managedObjectContext.delete(item)
        do {
            // save the updated managed object context
            try managedObjectContext.save()
        } catch {
            
        }
    }
}
