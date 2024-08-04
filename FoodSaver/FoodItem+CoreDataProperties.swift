//
//  FoodItem+CoreDataProperties.swift
//  FoodSaver
//
//  Created by Patrick Brown on 7/11/24.
//
//

import Foundation
import CoreData


extension FoodItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodItem> {
        return NSFetchRequest<FoodItem>(entityName: "FoodItem")
    }

    @NSManaged public var name: String?
    @NSManaged public var picture: Data?
    @NSManaged public var bestBeforeDate: Date?
    @NSManaged public var purchaseDate: Date?
    @NSManaged public var category: String?
    @NSManaged public var location: String?
    @NSManaged public var status: String?

}

extension FoodItem : Identifiable {

}
