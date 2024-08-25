import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(\.modelContext) private var context
    @Query var foodItems: [FoodItem]

    @State private var searchText: String = ""
    @State private var selectedCategory: String = "Name"
    @State private var selectedFoodItem: FoodItem?
    @State private var isShowingEditView = false
    @State private var selectedStatus: String = "All"
    @FocusState private var isSearchFieldActive: Bool

    var filteredFoodItems: [FoodItem] {
        // Apply filters based on selected criteria
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
        NavigationView {
            VStack {
                // Search bar and category filter
                SearchBar(text: $searchText, selectedCategory: $selectedCategory, isSearchFieldActive: $isSearchFieldActive)
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
                        .swipeActions {
                            Button(role: .destructive) {
                                deleteFoodItem(foodItem)
                            } label: {
                                Text("Delete")
                            }
                            Button("Modify") {
                                selectedFoodItem = foodItem
                                isShowingEditView = true
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
                        let newItem = FoodItem()
                        context.insert(newItem)
                        selectedFoodItem = newItem
                        isShowingEditView = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.blue)
                    }
                }
            }
            .sheet(item: $selectedFoodItem) { foodItem in
                AddModifyItemView(foodItem: foodItem)
            }
        }
    }

    private func deleteFoodItem(_ foodItem: FoodItem) {
        context.delete(foodItem)
        try? context.save()
    }
}
