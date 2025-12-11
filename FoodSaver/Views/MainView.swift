import SwiftUI
import SwiftData
import ConfettiSwiftUI
import OSLog

struct MainView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    @FocusState private var isSearchFieldActive: Bool
    @Query private var foodItems: [FoodItem]

    @State private var searchText: String = ""
    @State private var selectedCategory: String = "Name"
    @State private var selectedStatus: String = "All"
    @State private var selectedFoodItem: FoodItem?
    @State private var isShowingEditView: Bool = false

    // Confetti counter
    @State private var confettiCounter: Int = 0
    @State private var showErrorAlert = false
    @State private var errorMessage = ""

    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "FoodSaver", category: "MainView")

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
            filtered = filtered.filter { $0.status.rawValue == selectedStatus }
        }

        return filtered.sorted { $0.name < $1.name }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Theme.background
                    .ignoresSafeArea()

                VStack(spacing: Theme.Spacing.md) {
                    header
                        .padding(.horizontal, Theme.Spacing.md)
                        .padding(.top, Theme.Spacing.md)

                    SearchBar(
                        text: $searchText,
                        selectedCategory: $selectedCategory,
                        isSearchFieldActive: $isSearchFieldActive
                    )
                    .padding(.horizontal, Theme.Spacing.md)

                    Picker("Status", selection: $selectedStatus) {
                        Text("All").tag("All")
                        Text("Fresh").tag("Fresh")
                        Text("Expiring").tag("Expiring")
                        Text("Expired").tag("Expired")
                    }
                    .pickerStyle(.segmented)
                    .tint(Theme.secondaryColor)
                    .padding(.horizontal, Theme.Spacing.md)

                    List {
                        ForEach(filteredFoodItems) { foodItem in
                            NavigationLink(destination: ReadOnlyItemView(foodItem: foodItem)) {
                                FoodItemRow(foodItem: foodItem)
                            }
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets())
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
                                .tint(Theme.primaryColor)
                            }
                        }
                        .listRowBackground(Color.clear)
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                }
            }
            .sheet(isPresented: $isShowingEditView) {
                if let selectedFoodItem = selectedFoodItem {
                    AddModifyItemView(viewModel: AddModifyItemViewModel(foodItem: selectedFoodItem))
                } else {
                    AddModifyItemView(viewModel: AddModifyItemViewModel())
                }
            }
            // Confetti when a new item is added
            .onChange(of: foodItems.count) { _, _ in
                guard !reduceMotion else { return }
                triggerConfetti()
            }
            .confettiCannon(counter: reduceMotion ? .constant(0) : $confettiCounter, num: Constants.confettiCount, radius: Constants.confettiRadius)
            .alert("Unable to Save Changes", isPresented: $showErrorAlert, actions: {
                Button("OK", role: .cancel) { }
            }, message: {
                Text(errorMessage)
            })
            .toolbar(.hidden)
        }
    }

    private var header: some View {
        HStack(alignment: .center, spacing: Theme.Spacing.md) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Food Saver")
                    .font(Theme.displayFont)
                    .foregroundColor(Theme.textPrimary)
                Text("Stay ahead of freshness")
                    .font(Theme.captionFont)
                    .foregroundColor(Theme.textSecondary)
            }

            Spacer()

            Button(action: { addNewItem() }) {
                HStack(spacing: 8) {
                    Image(systemName: "plus")
                        .font(.headline)
                    Text("Add")
                        .font(Theme.bodyFont.weight(.semibold))
                }
                .foregroundColor(.white)
                .padding(.vertical, 10)
                .padding(.horizontal, 14)
                .background(Theme.primaryColor)
                .clipShape(Capsule())
                .shadow(color: Theme.cardShadow.opacity(0.6), radius: 8, x: 0, y: 4)
            }
            .accessibilityLabel("Add new item")
        }
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
            logger.error("Error saving context: \(error.localizedDescription)")
            errorMessage = "We couldn't update your food list. Please try again."
            showErrorAlert = true
        }
    }

    private func triggerConfetti() {
        confettiCounter += 1
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//            .environment(\.modelContext, ModelContainer.preview)
//    }
//}
