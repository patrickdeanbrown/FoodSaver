import Foundation
import SwiftUI

struct FoodItemTemp {
    var name: String
    var picture: Data?
    var bestBeforeDate: Date
    var category: String
    var location: String
    var warningPeriod: Int

    var showImagePicker = false
    var inputImage: UIImage?

    init() {
        self.name = ""
        self.picture = nil
        self.bestBeforeDate = Date()
        self.category = ""
        self.location = ""
        self.warningPeriod = 0
    }

    init(from foodItem: FoodItem) {
        self.name = foodItem.name
        self.picture = foodItem.picture
        self.bestBeforeDate = foodItem.bestBeforeDate
        self.category = foodItem.category
        self.location = foodItem.location
        self.warningPeriod = foodItem.warningPeriod
    }
}
