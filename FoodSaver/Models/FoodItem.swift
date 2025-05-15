import Foundation
import SwiftUICore
import SwiftData
import UIKit

enum FoodStatus: String, Codable {
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
    var warningPeriod: Int // Days before bestBeforeDate to show as "Expiring"

    var status: FoodStatus {
        let now = Date()
        let calendar = Calendar.current

        // Normalize dates to the start of the day to ensure consistent comparisons
        let startOfToday = calendar.startOfDay(for: now)
        let startOfBestBeforeDate = calendar.startOfDay(for: bestBeforeDate)

        let daysToExpiry = calendar.dateComponents([.day], from: startOfToday, to: startOfBestBeforeDate).day ?? 0

        if daysToExpiry < 0 { // Use < 0 for expired, 0 means it expires today
            return .expired
        } else if daysToExpiry <= warningPeriod {
            return .expiring
        } else {
            return .fresh
        }
    }

    // New helper for status emoji
    var statusEmoji: String {
        switch status {
        case .expired:
            return "🔴" // Red circle
        case .expiring:
            return "🟡" // Yellow circle
        case .fresh:
            return "🟢" // Green circle
        }
    }
    
    // New helper for status color (alternative or complementary to background)
    var statusColor: Color {
        switch status {
        case .expired:
            return .red
        case .expiring:
            return .yellow
        case .fresh:
            return .green
        }
    }


    init(name: String, picture: Data? = nil, bestBeforeDate: Date, category: String, location: String, warningPeriod: Int) {
        self.id = UUID() // Ensure ID is initialized
        self.name = name
        self.picture = picture
        self.bestBeforeDate = bestBeforeDate
        self.category = category
        self.location = location
        self.warningPeriod = warningPeriod
    }

    // Default initializer
    init() {
        self.id = UUID()
        self.name = ""
        self.picture = nil
        self.bestBeforeDate = Date()
        self.category = "Unspecified"
        self.location = "Unspecified"
        self.warningPeriod = 3 // Default warning period, e.g., 3 days
    }
}
