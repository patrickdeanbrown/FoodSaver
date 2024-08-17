//
//  FoodItemTemp.swift
//  FoodSaver
//
//  Created by Patrick Brown on 8/4/24.
//

import Foundation
import SwiftUI

struct FoodItemTemp {
    var name: String
    var picture: Data?
    var bestBeforeDate: Date
    var purchaseDate: Date
    var category: String
    var location: String

    var showImagePicker = false
    var inputImage: UIImage?
    
    init() {
        self.name = ""
        self.picture = nil
        self.bestBeforeDate = Date()
        self.purchaseDate = Date()
        self.category = ""
        self.location = ""
    }

    init(from foodItem: FoodItem) {
        self.name = foodItem.name
        self.picture = foodItem.picture
        self.bestBeforeDate = foodItem.bestBeforeDate
        self.purchaseDate = foodItem.purchaseDate
        self.category = foodItem.category
        self.location = foodItem.location
    }
    

}
