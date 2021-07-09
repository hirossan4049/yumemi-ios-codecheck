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
                
        let textField = XCUIApplication().navigationBars["Search"].searchFields["GitHubのリポジトリを検索できるよー"]
        textField.tap()
        textField.typeText("Realm")
        XCUIApplication()/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards",".buttons[\"search\"]",".buttons[\"Search\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        sleep(3)
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Realm is a mobile database: a replacement for Core Data & SQLite")/*[[".cells.containing(.staticText, identifier:\"realm-cocoa\")",".cells.containing(.staticText, identifier:\"1968\")",".cells.containing(.staticText, identifier:\"14531\")",".cells.containing(.staticText, identifier:\"Realm is a mobile database: a replacement for Core Data & SQLite\")"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["realm"].tap()
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
