import XCTest
import SwiftData
@testable import FoodSaver

final class AddModifyItemViewModelSaveTests: XCTestCase {
    func testInsertNewItem() throws {
        let container = try ModelContainer(for: FoodItem.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let context = ModelContext(container)
        let vm = AddModifyItemViewModel()
        vm.temporaryFoodItem.name = "Banana"
        vm.temporaryFoodItem.category = "Fresh Produce"
        vm.temporaryFoodItem.location = "Fridge"
        vm.temporaryFoodItem.warningPeriod = 3
        vm.saveChanges(context: context)
        let items = try context.fetch(FetchDescriptor<FoodItem>())
        XCTAssertEqual(items.count, 1)
        XCTAssertEqual(items.first?.name, "Banana")
    }

    func testUpdateExistingItem() throws {
        let container = try ModelContainer(for: FoodItem.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let context = ModelContext(container)
        let existing = FoodItem(name: "Old", bestBeforeDate: Date(), category: "Fresh Produce", location: "Fridge", warningPeriod: 3)
        context.insert(existing)
        try context.save()
        let vm = AddModifyItemViewModel(foodItem: existing)
        vm.temporaryFoodItem.name = "New"
        vm.saveChanges(context: context)
        let items = try context.fetch(FetchDescriptor<FoodItem>())
        XCTAssertEqual(items.first?.name, "New")
    }
}
