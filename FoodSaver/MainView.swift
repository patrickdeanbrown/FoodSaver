import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(\.modelContext) private var context
    @Query var foodItems: [FoodItem]

    @State private var searchText: String = ""
    @State private var selectedCategory: String = "Name"
    @State private var selectedFoodItem: FoodItem?
    @State private var selectedStatus: String = "All"
    @State private var showingReadOnlyItem = false
    @State private var showingAddModifyItem = false
    @FocusState private var isSearchFieldActive: Bool

    var filteredFoodItems: [FoodItem] {
        // Initial array of items
        var filtered: [FoodItem] = foodItems
        
        // Filter by search text if it is not empty
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

        // Filter by status if a specific status is selected
        if selectedStatus != "All" {
            filtered = filtered.filter { $0.status == selectedStatus }
        }

        // Sort the filtered results by name
        return filtered.sorted { $0.name < $1.name }
    }

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText, selectedCategory: $selectedCategory, isSearchFieldActive: $isSearchFieldActive)
                    .padding(.horizontal)

                Picker("Status", selection: $selectedStatus) {
                    Text("All").tag("All")
                    Text("Fresh").tag("Fresh")
                    Text("Expiring").tag("Expiring")
                    Text("Expired").tag("Expired")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)

                List {
                    ForEach(filteredFoodItems) { foodItem in
                        FoodItemRow(foodItem: foodItem)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                if isSearchFieldActive {
                                    isSearchFieldActive = false
                                }
                                else {
                                    selectedFoodItem = foodItem
                                    showingReadOnlyItem = true
                                }
                            }
                            .swipeActions(edge: .trailing) {
                                Button("Delete") {
                                    context.delete(foodItem)
                                    try? context.save()
                                }
                                .tint(.red)

                                Button("Modify") {
                                    showingAddModifyItem = true
                                }
                                .tint(.blue)
                            }
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationBarTitle("Food Saver", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        let newItem = FoodItem()
                        context.insert(newItem)
                        selectedFoodItem = newItem
                        showingAddModifyItem = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.blue)
                    }
                }
            }
            .sheet(isPresented: $showingReadOnlyItem) {
                if let foodItem = selectedFoodItem {
                    ReadOnlyItemView(foodItem: foodItem)
                }
            }
            .sheet(isPresented: $showingAddModifyItem) {
                if let foodItem = selectedFoodItem {
                    AddModifyItemView(foodItem: foodItem)
                }
            }
        }
    }
}
