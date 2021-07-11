//
//  iOSEngineerCodeCheckUITests.swift
//  iOSEngineerCodeCheckUITests
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import XCTest

class iOSEngineerCodeCheckUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    
    func testRepositoryCellTap() {
        let app = XCUIApplication()
        app.launch()
        
        app.tabBars["Tab Bar"].buttons["Search"].tap()
        
        let textField = XCUIApplication().navigationBars["Search"].searchFields["GitHubのリポジトリを検索できるよー"]
        textField.tap()
        textField.typeText("Realm")
        app.buttons["Search"].tap()
        sleep(3)
        app.tables.cells.firstMatch.press(forDuration: 1)
    }
    
    func testRepositoryFavorite() {
        let app = XCUIApplication()
        app.launch()
        
        app.tabBars["Tab Bar"].buttons["Search"].tap()
        
        let textField = XCUIApplication().navigationBars["Search"].searchFields["GitHubのリポジトリを検索できるよー"]
        textField.tap()
        textField.typeText("Realm")
        app.keyboards.buttons["Search"].tap()
        sleep(3)
        app.tables.cells.firstMatch.press(forDuration: 1)
        
        let deleteFavBtn = app.collectionViews.buttons["Delete favorite"]
        if deleteFavBtn.exists {
            deleteFavBtn.tap()
            app.tables.cells.firstMatch.press(forDuration: 1)
        }
        
        app.collectionViews.buttons["Favorite"].tap()
        
        app.tabBars["Tab Bar"].buttons["Favorite"].tap()
        
        app.tables.staticTexts["realm"].press(forDuration: 1);
        app.collectionViews.buttons["Delete favorite"].tap()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
