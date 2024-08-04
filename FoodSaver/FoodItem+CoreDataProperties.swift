import Foundation
import CoreData

extension FoodItem: Identifiable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodItem> {
        return NSFetchRequest<FoodItem>(entityName: "FoodItem")
    }

    @NSManaged public var name: String
    @NSManaged public var picture: Data?
    @NSManaged public var bestBeforeDate: Date
    @NSManaged public var purchaseDate: Date
    @NSManaged public var category: String
    @NSManaged public var location: String
    @NSManaged public var status: String

    public var id: NSManagedObjectID {
        return objectID
    }
}
