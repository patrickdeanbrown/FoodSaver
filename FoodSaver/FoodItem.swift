import Foundation
import SwiftData

@Model
final class FoodItem: Identifiable {
    @Attribute var id: UUID = UUID()
    var name: String
    var picture: Data?
    var bestBeforeDate: Date
    var category: String
    var location: String
    var warningPeriod: Int

    var status: String {
        let daysToExpiry = Calendar.current.dateComponents([.day], from: Date(), to: bestBeforeDate).day ?? 0
        if daysToExpiry <= 0 {
            return "Expired"
        } else if daysToExpiry <= warningPeriod {
            return "Expiring"
        } else {
            return "Fresh"
        }
    }
    
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
    
    init(name: String, picture: Data? = nil, bestBeforeDate: Date, category: String, location: String, warningPeriod: Int) {
        self.name = name
        self.picture = picture
        self.bestBeforeDate = bestBeforeDate
        self.category = category
        self.location = location
        self.warningPeriod = warningPeriod
    }
    
    init() {
        self.name = ""
        self.picture = nil
        self.bestBeforeDate = Date()
        self.category = "Unspecified"
        self.location = "Unspecified"
        self.warningPeriod = 0
    }
}
