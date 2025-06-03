import XCTest

final class SearchUITest: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testSearchFiltering() {
        let app = XCUIApplication()
        app.launch()
        let searchField = app.searchFields.firstMatch
        searchField.tap()
        searchField.typeText("App")
        XCTAssertTrue(app.staticTexts["Apple"].waitForExistence(timeout: 2))
    }
}
