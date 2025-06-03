import XCTest
@testable import FoodSaver

final class FoodItemStatusTests: XCTestCase {
    func testExpiredStatus() {
        let date = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let item = FoodItem(name: "Milk", bestBeforeDate: date, category: "Dairy", location: "Fridge", warningPeriod: 3)
        XCTAssertEqual(item.status, .expired)
    }

    func testExpiringStatusToday() {
        let date = Date() // expires today
        let item = FoodItem(name: "Bread", bestBeforeDate: date, category: "Bakery", location: "Pantry", warningPeriod: 3)
        XCTAssertEqual(item.status, .expiring)
    }

    func testExpiringStatusWithinWarning() {
        let date = Calendar.current.date(byAdding: .day, value: 2, to: Date())!
        let item = FoodItem(name: "Yogurt", bestBeforeDate: date, category: "Dairy", location: "Fridge", warningPeriod: 3)
        XCTAssertEqual(item.status, .expiring)
    }

    func testFreshStatus() {
        let date = Calendar.current.date(byAdding: .day, value: 5, to: Date())!
        let item = FoodItem(name: "Frozen Peas", bestBeforeDate: date, category: "Frozen", location: "Freezer", warningPeriod: 3)
        XCTAssertEqual(item.status, .fresh)
    }
}
