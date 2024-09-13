// MainViewModel.swift
import SwiftUI
import SwiftData
import Combine

@MainActor
class MainViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var selectedCategory: String = "Name"
    @Published var selectedStatus: String = "All"
    @Published var selectedFoodItem: FoodItem?
    @Published var isShowingEditView: Bool = false
    
    // Confetti counter
    @Published var confettiCounter: Int = 0

    private var context: ModelContext?
    @Query private var foodItems: [FoodItem]
    
    init() {
        _foodItems = Query(filter: nil)
    }
    
    var filteredFoodItems: [FoodItem] {
        guard let context = context else { return foodItems }

        var filtered = foodItems
        
        if !searchText.isEmpty {
            switch selectedCategory {
            case "Name":
                filtered = filtered.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
            case "Category":
                filtered = filtered.filter { $0.category.localizedCaseInsensitiveContains(searchText) }
            case "Location":
                filtered = filtered.filter { $0.location.localizedCaseInsensitiveContains(searchText) }
            default:
                break
            }
        }

        if selectedStatus != "All" {
            filtered = filtered.filter { $0.status == selectedStatus }
        }

        return filtered.sorted { $0.name < $1.name }
    }
    
    func addNewItem() {
        guard let context = context else { return }
        let newItem = FoodItem()
        context.insert(newItem)
        selectedFoodItem = newItem
        isShowingEditView = true
        triggerConfetti()
    }
    
    func deleteFoodItem(_ foodItem: FoodItem) {
        guard let context = context else { return }
        context.delete(foodItem)
        saveContext()
    }
    
    func saveContext() {
        do {
            try context?.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
    
    func triggerConfetti() {
        confettiCounter += 1
    }
    
    func setContext(_ context: ModelContext) {
        self.context = context
    }
}
