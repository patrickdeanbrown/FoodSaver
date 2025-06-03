import XCTest

final class EditAndDeleteFlowUITest: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testEditAndDeleteFlow() {
        let app = XCUIApplication()
        app.launch()
        // Assumes there is at least one item to edit
        let firstCell = app.cells.firstMatch
        if firstCell.waitForExistence(timeout: 2) {
            firstCell.swipeLeft()
            app.buttons["Modify"].tap()
            let nameField = app.textFields.firstMatch
            nameField.tap()
            nameField.typeText(" Updated")
            app.buttons["Save"].tap()
            XCTAssertTrue(firstCell.staticTexts.contains { $0.label.contains("Updated") })
            firstCell.swipeLeft()
            app.buttons["Delete"].tap()
            XCTAssertFalse(firstCell.exists)
        }
    }
}
