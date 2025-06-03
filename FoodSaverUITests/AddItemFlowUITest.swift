import XCTest

final class AddItemFlowUITest: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testAddNewItemFlow() {
        let app = XCUIApplication()
        app.launch()
        app.buttons["Add New Item"].tap()
        let nameField = app.textFields.firstMatch
        nameField.tap()
        nameField.typeText("Test Item")
        app.buttons["Save"].tap()
        XCTAssertTrue(app.staticTexts["Test Item"].waitForExistence(timeout: 2))
    }
}
