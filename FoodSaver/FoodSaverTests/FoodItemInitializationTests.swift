import XCTest
@testable import FoodSaver

final class FoodItemInitializationTests: XCTestCase {
    func testDefaultInitializer() {
        let item = FoodItem()
        XCTAssertEqual(item.name, "")
        XCTAssertNil(item.picture)
        XCTAssertEqual(item.category, "Unspecified")
        XCTAssertEqual(item.location, "Unspecified")
        XCTAssertEqual(item.warningPeriod, 3)
        // Best before defaults to now; ensure it's close
        XCTAssertLessThan(abs(item.bestBeforeDate.timeIntervalSinceNow), 1)
    }
}
