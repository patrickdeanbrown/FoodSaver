import SwiftUI
import SwiftData

@MainActor
class AddModifyItemViewModel: ObservableObject {
    @Published var temporaryFoodItem: FoodItemTemp
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""

    var originalFoodItem: FoodItem?
    var isNewItem: Bool

    var canSave: Bool {
        validationMessage == nil
    }

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
        if let validationMessage = validationMessage {
            showError = true
            errorMessage = validationMessage
            return
        }

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

    private var validationMessage: String? {
        if temporaryFoodItem.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return "Please enter an item name to continue."
        }

        if temporaryFoodItem.category.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return "Please choose a category to help organize your items."
        }

        if temporaryFoodItem.location.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return "Please choose where the item is stored."
        }

        if temporaryFoodItem.warningPeriod < 0 {
            return "Warning period can't be negative."
        }

        return nil
    }
}
