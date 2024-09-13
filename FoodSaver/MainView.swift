import SwiftUI
import SwiftData
import ConfettiSwiftUI

struct MainView: View {
    @Environment(\.modelContext) private var context
    
    @FocusState private var isSearchFieldActive: Bool
    @Query private var foodItems: [FoodItem]
    
    @State private var searchText: String = ""
    @State private var selectedCategory: String = "Name"
    @State private var selectedStatus: String = "All"
    @State private var selectedFoodItem: FoodItem?
    @State private var isShowingEditView: Bool = false
    
    // Confetti counter
    @State private var confettiCounter: Int = 0

    var filteredFoodItems: [FoodItem] {
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
    
    var body: some View {
        VStack {
            // Search bar and category filter
            SearchBar(
                text: $searchText,
                selectedCategory: $selectedCategory,
                isSearchFieldActive: $isSearchFieldActive
            )
            .padding(.horizontal)
            
            // Status filter
            Picker("Status", selection: $selectedStatus) {
                Text("All").tag("All")
                Text("Fresh").tag("Fresh")
                Text("Expiring").tag("Expiring")
                Text("Expired").tag("Expired")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            
            // List of food items
            List {
                ForEach(filteredFoodItems) { foodItem in
                    NavigationLink(destination: ReadOnlyItemView(foodItem: foodItem)) {
                        FoodItemRow(foodItem: foodItem)
                    }
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            deleteFoodItem(foodItem)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        Button {
                            selectedFoodItem = foodItem
                            isShowingEditView = true
                        } label: {
                            Label("Modify", systemImage: "pencil")
                        }
                        .tint(.blue)
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
        .navigationTitle("Food Saver")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    addNewItem()
                }) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.blue)
                }
            }
        }
        .sheet(isPresented: $isShowingEditView) {
            AddModifyItemView(foodItem: selectedFoodItem)
        }
        // Confetti when a new item is added
        .onChange(of: foodItems.count) { _ in
            triggerConfetti()
        }
        .confettiCannon(counter: $confettiCounter, num: 50, radius: 300.0)
    }
    
    private func addNewItem() {
        selectedFoodItem = nil // Pass nil to AddModifyItemView to create a new item
        isShowingEditView = true
    }
    
    private func deleteFoodItem(_ foodItem: FoodItem) {
        context.delete(foodItem)
        saveContext()
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
    
    private func triggerConfetti() {
        confettiCounter += 1
    }
}
