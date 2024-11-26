//
//  NotesMainViewTest.swift
//  introspecUITests
//
//  Created by Baba Yaga on 20/11/24.
//

import XCTest

final class NotesMainViewTest: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
    }
    
    func testAddButton() throws {
        let app = XCUIApplication()
        app.launch()
        let addButton = app.buttons["AddNoteButton"]
        XCTAssertTrue(addButton.exists)
        addButton.tap()
        
        let textEditorView = app.otherElements["TextEditorView"]
        XCTAssertTrue(textEditorView.waitForExistence(timeout: 5))
    }
}
