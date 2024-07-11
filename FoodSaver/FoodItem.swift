import SwiftUI
import CoreData

@objc(FoodItem)
class FoodItem: NSManagedObject, Identifiable {
    @NSManaged var id: UUID
    @NSManaged var name: String
    @NSManaged var picture: Data
    @NSManaged var bestBeforeDate: Date
    @NSManaged var purchaseDate: Date
    @NSManaged var category: String
    @NSManaged var location: String
    var status: FoodStatus {
        let now = Date()
        let totalDuration = bestBeforeDate.timeIntervalSince(purchaseDate)
        let elapsedDuration = now.timeIntervalSince(purchaseDate)
        
        if now >= bestBeforeDate {
            return .expired
        } else if elapsedDuration / totalDuration >= 0.6 {
            return .expiring
        } else {
            return .fresh
        }
    }
}

enum FoodStatus: String {
    case expired = "Expired"
    case expiring = "Expiring"
    case fresh = "Fresh"
}
