//
//  FoodItem.swift
//  FoodSaver
//
//  Created by Patrick Brown on 8/3/24.
//

import Foundation
import SwiftData

@Model
final class FoodItem: Identifiable {
    @Attribute var id: UUID = UUID()
    var name: String
    var picture: Data?
    var bestBeforeDate: Date
    var purchaseDate: Date
    var category: String
    var location: String
    var status: String = "Fresh"
    
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
    
    init(name: String, picture: Data? = nil, bestBeforeDate: Date, purchaseDate: Date, category: String, location: String, status: String) {
        self.name = name
        self.picture = picture
        self.bestBeforeDate = bestBeforeDate
        self.purchaseDate = purchaseDate
        self.category = category
        self.location = location
        self.status = status
    }
    
    init()
    {
        self.name = ""
        self.picture = nil
        self.bestBeforeDate = Date()
        self.purchaseDate = Date()
        self.category = ""
        self.location = ""
    }
    

}
