import XCTest
import SwiftData
@testable import FoodSaver

final class AddModifyItemViewModelErrorTests: XCTestCase {
    class FailingContext: ModelContext {
        override func save() throws {
            struct TestError: Error {}
            throw TestError()
        }
    }

    func testSaveFailureShowsError() throws {
        let container = try ModelContainer(for: FoodItem.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let context = FailingContext(container)
        let vm = AddModifyItemViewModel()
        vm.saveChanges(context: context)
        XCTAssertTrue(vm.showError)
        XCTAssertFalse(vm.errorMessage.isEmpty)
    }
}
