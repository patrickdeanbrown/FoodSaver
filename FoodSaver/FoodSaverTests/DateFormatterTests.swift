import XCTest
@testable import FoodSaver

final class DateFormatterTests: XCTestCase {
    func testFoodItemRowDateFormatter() {
        let formatter = DateFormatter.foodItemRowDate
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.locale = Locale(identifier: "en_US_POSIX")
        let date = Date(timeIntervalSince1970: 0)
        XCTAssertEqual(formatter.string(from: date), "Jan 1, 1970")
    }
}
