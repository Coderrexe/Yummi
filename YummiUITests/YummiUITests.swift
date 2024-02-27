//
//  YummiUITests.swift
//  YummiUITests
//
//  Created by Shi, Simba (Coll) on 23/01/2024.
//

import XCTest

final class YummiUITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    func testAddingNewIngredient() throws {
        let app = XCUIApplication()
        
        app.textFields["Name"].tap()
        app.textFields["Name"].typeText("Carrot")
        
        app.textFields["Category"].tap()
        app.textFields["Category"].typeText("Vegetable")
        
        app.steppers.buttons["Increment"].tap()
        
        app.buttons["Add ingredient"].tap()
        
        XCTAssertTrue(app.staticTexts["Carrot"].exists)
    }
    
    func testTogglingThroughIngredients() throws {
        let app = XCUIApplication()
        
        app.buttons["Next Ingredient"].tap()
        XCTAssertTrue(app.staticTexts["Name"].exists)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
