import SwiftUI
import SwiftData

@MainActor
class AddModifyItemViewModel: ObservableObject {
    @Published var temporaryFoodItem: FoodItemTemp
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""

    var originalFoodItem: FoodItem?
    var isNewItem: Bool

    init(foodItem: FoodItem? = nil) {
        if let foodItem = foodItem {
            self.originalFoodItem = foodItem
            self.temporaryFoodItem = FoodItemTemp(from: foodItem)
            self.isNewItem = false
        } else {
            self.temporaryFoodItem = FoodItemTemp()
            self.isNewItem = true
        }
    }

    func loadImage() {
        guard let inputImage = temporaryFoodItem.inputImage else { return }
        temporaryFoodItem.picture = inputImage.jpegData(compressionQuality: 0.8)
    }

    func saveChanges(context: ModelContext) {
        if isNewItem {
            let newItem = FoodItem()
            updateModel(newItem)
            context.insert(newItem)
        } else if let original = originalFoodItem {
            updateModel(original)
        }
        do {
            try context.save()
        } catch {
            showError = true
            errorMessage = error.localizedDescription
            print("Error saving context: \(error)")
        }
    }

    private func updateModel(_ foodItem: FoodItem) {
        foodItem.name = temporaryFoodItem.name
        foodItem.picture = temporaryFoodItem.picture
        foodItem.bestBeforeDate = temporaryFoodItem.bestBeforeDate
        foodItem.category = temporaryFoodItem.category
        foodItem.location = temporaryFoodItem.location
        foodItem.warningPeriod = temporaryFoodItem.warningPeriod
    }
}
