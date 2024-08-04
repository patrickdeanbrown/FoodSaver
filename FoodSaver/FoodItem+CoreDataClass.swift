import Foundation
import CoreData

@objc(FoodItem)
public class FoodItem: NSManagedObject {
    var statusEmoji: String {
        switch status {
        case "Expired":
            return "🔴"
        case "Expiring":
            return "🟡"
        case "Fresh":
            return "🟢"
        default:
            return "🟢"
        }
    }
}
