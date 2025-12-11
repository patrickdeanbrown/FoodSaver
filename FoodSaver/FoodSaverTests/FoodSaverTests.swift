import XCTest
import SwiftData
@testable import FoodSaver

@MainActor
final class FoodSaverTests: XCTestCase {

    func testFoodItemStatusFreshExpiringExpired() {
        let calendar = Calendar.current

        let freshDate = calendar.date(byAdding: .day, value: 5, to: Date())!
        let expiringDate = calendar.date(byAdding: .day, value: 1, to: Date())!
        let expiredDate = calendar.date(byAdding: .day, value: -1, to: Date())!

        XCTAssertEqual(FoodItem(name: "Fresh", bestBeforeDate: freshDate, category: "Produce", location: "Fridge", warningPeriod: 2).status, .fresh)
        XCTAssertEqual(FoodItem(name: "Almost Done", bestBeforeDate: expiringDate, category: "Dairy", location: "Fridge", warningPeriod: 3).status, .expiring)
        XCTAssertEqual(FoodItem(name: "Old", bestBeforeDate: expiredDate, category: "Pantry", location: "Cupboard", warningPeriod: 3).status, .expired)
    }

    func testViewModelBlocksInvalidSaves() throws {
        let container = try ModelContainer(for: FoodItem.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let viewModel = AddModifyItemViewModel()

        viewModel.saveChanges(context: container.mainContext)

        XCTAssertTrue(viewModel.showError)
        XCTAssertFalse(viewModel.errorMessage.isEmpty)
    }

    func testViewModelAllowsValidSave() throws {
        let container = try ModelContainer(for: FoodItem.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let viewModel = AddModifyItemViewModel()

        viewModel.temporaryFoodItem.name = "Carrots"
        viewModel.temporaryFoodItem.category = "Fresh Produce"
        viewModel.temporaryFoodItem.location = "Fridge"
        viewModel.temporaryFoodItem.warningPeriod = 3

        XCTAssertTrue(viewModel.canSave)

        viewModel.saveChanges(context: container.mainContext)

        XCTAssertFalse(viewModel.showError)
    }
}
