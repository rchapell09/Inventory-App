//
//  ItemEntity+CoreDataProperties.swift
//  classproject
//
//  Created by rchapell on 11/13/18.
//  Copyright © 2018 rchapell. All rights reserved.
//
//

import Foundation
import CoreData


extension ItemEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemEntity> {
        return NSFetchRequest<ItemEntity>(entityName: "ItemEntity")
    }

    @NSManaged public var itemCat: String?
    @NSManaged public var itemName: String?
    @NSManaged public var itemQuantity: Int16
    @NSManaged public var itemPic: NSData?

}
