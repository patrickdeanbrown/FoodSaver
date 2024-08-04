import SwiftUI
import CoreData

class FoodViewModel: ObservableObject {
    @Published var foodItems: [FoodItem] = []
    @Published var searchText: String = ""
    @Published var selectedCategory: String = "Name"
    @Published var selectedFoodItem: FoodItem?

    var filteredFoodItems: [FoodItem] {
        if searchText.isEmpty {
            return foodItems.sorted { $0.name < $1.name }
        } else {
            let filtered: [FoodItem]
            switch selectedCategory {
            case "Name":
                filtered = foodItems.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
            case "Category":
                filtered = foodItems.filter { $0.category.localizedCaseInsensitiveContains(searchText) }
            case "Location":
                filtered = foodItems.filter { $0.location.localizedCaseInsensitiveContains(searchText) }
            default:
                filtered = foodItems
            }
            return filtered.sorted { $0.name < $1.name }
        }
    }

    init() {
        fetchFoodItems()
    }

    func addNewFoodItem() {
        let context = PersistenceController.shared.container.viewContext
        let newItem = FoodItem(context: context)
        newItem.name = ""
        newItem.purchaseDate = Date()
        newItem.bestBeforeDate = Date()
        newItem.category = ""
        newItem.location = ""
        newItem.status = "Fresh"
        selectedFoodItem = newItem
    }

    func selectFoodItem(_ foodItem: FoodItem) {
        selectedFoodItem = foodItem
    }

    func modifyFoodItem(_ foodItem: FoodItem) {
        selectedFoodItem = foodItem
        fetchFoodItems()  // Refresh the food items
    }

    func deleteFoodItem(_ foodItem: FoodItem) {
        PersistenceController.shared.container.viewContext.delete(foodItem)
        saveContext()
    }

    func saveContext() {
        do {
            try PersistenceController.shared.container.viewContext.save()
            fetchFoodItems()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

    func fetchFoodItems() {
        let request: NSFetchRequest<FoodItem> = FoodItem.fetchRequest()
        do {
            let items = try PersistenceController.shared.container.viewContext.fetch(request)
            DispatchQueue.main.async {
                self.foodItems = items
                self.updateStatuses()
            }
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

    func updateStatuses() {
        let context = PersistenceController.shared.container.viewContext
        for item in foodItems {
            item.status = calculateStatus(for: item)
        }
        DispatchQueue.main.async {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    func calculateStatus(for item: FoodItem) -> String {
        let today = Date()
        let totalDays = Calendar.current.dateComponents([.day], from: item.purchaseDate, to: item.bestBeforeDate).day ?? 0
        let daysPassed = Calendar.current.dateComponents([.day], from: item.purchaseDate, to: today).day ?? 0
        let percentagePassed = Double(daysPassed) / Double(totalDays)
        
        if percentagePassed >= 1.0 {
            return "Expired"
        } else if percentagePassed >= 0.6 {
            return "Expiring"
        } else {
            return "Fresh"
        }
    }
}
