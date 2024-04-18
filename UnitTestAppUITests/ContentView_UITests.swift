//
//  ContentView_UITests.swift
//  UnitTestAppUITests
//
//  Created by Zuber Rehmani on 03/04/24.
//

import XCTest
@testable import UnitTestApp

final class ContentView_UITests: XCTestCase {
    let app = XCUIApplication()
    override func setUpWithError() throws {
        app.launch()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_contentView_signupButton_shouldNotSignIn() {
        
    }

    func test_contentView_signupButton_shouldSignIn() {
        //Given
        let textfield = app.textFields["Add text here..."]
        
        //When
        textfield.tap()
        
        let keyA = app.keys["A"]
        keyA.tap()
        let keya = app.keys["a"]
        keya.tap()
        keya.tap()
        
        let returnButton = app.buttons["return"]
        returnButton.tap()
        
        let signupButton = app.buttons["Signup"]
        signupButton.tap()
        
        let navBar = app.navigationBars["welcome"]
        
        //Then
        XCTAssertTrue(navBar.exists)
    }
}
