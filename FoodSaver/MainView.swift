import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewModel: FoodViewModel
    @State private var showingReadOnlyItem = false
    @State private var selectedStatus: String = "All"
    @State private var showingAddModifyItem = false

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchText, selectedCategory: $viewModel.selectedCategory)
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
                    ForEach(viewModel.filteredFoodItems.filter { item in
                        selectedStatus == "All" || item.status == selectedStatus
                    }) { foodItem in
                        FoodItemRow(foodItem: foodItem)
                            .onTapGesture {
                                viewModel.selectFoodItem(foodItem)
                                showingReadOnlyItem = true
                            }
                            .swipeActions(edge: .trailing) {
                                Button("Delete") {
                                    viewModel.deleteFoodItem(foodItem)
                                }
                                .tint(.red)

                                Button("Modify") {
                                    viewModel.modifyFoodItem(foodItem)
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
                        viewModel.addNewFoodItem()
                        showingAddModifyItem = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.blue)
                    }
                }
            }
            .sheet(isPresented: $showingReadOnlyItem) {
                if let foodItem = viewModel.selectedFoodItem {
                    ReadOnlyItemView(foodItem: foodItem)
                }
            }
            .sheet(isPresented: $showingAddModifyItem) {
                if let foodItem = viewModel.selectedFoodItem {
                    AddModifyItemView(viewModel: viewModel, foodItem: foodItem)
                }
            }
        }
    }
}
