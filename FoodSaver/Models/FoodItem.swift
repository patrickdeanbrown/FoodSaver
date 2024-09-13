import Foundation
import SwiftData

enum FoodStatus: String {
    case expired = "Expired"
    case expiring = "Expiring"
    case fresh = "Fresh"
}

@Model
final class FoodItem: Identifiable {
    @Attribute var id: UUID = UUID()
    var name: String
    var picture: Data?
    var bestBeforeDate: Date
    var category: String
    var location: String
    var warningPeriod: Int

    var status: FoodStatus {
        let daysToExpiry = Calendar.current.dateComponents([.day], from: Date(), to: bestBeforeDate).day ?? 0
        if daysToExpiry <= 0 {
            return .expired
        } else if daysToExpiry <= warningPeriod {
            return .expiring
        } else {
            return .fresh
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
