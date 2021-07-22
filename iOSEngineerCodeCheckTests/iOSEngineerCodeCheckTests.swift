//
//  iOSEngineerCodeCheckTests.swift
//  iOSEngineerCodeCheckTests
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import XCTest
@testable import iOSEngineerCodeCheck

class iOSEngineerCodeCheckTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testAPI() throws {
        let api = GithubAPI.shared
        
        api.fetchSearchRepositories(text: "Realm") { repos in
            let repo = try? XCTUnwrap(repos.first)
            XCTAssertEqual(repo?.name, "realm-cocoa")
        }
    }
    
    func testCoreData() throws {
       let dataManager = FavoriteRepositoryDataManager.shared
        let testID = 1234567890
        let repo = Repository(id: testID, name: "hello")
        
        dataManager.addItem(repository: repo)
        var cdRepo: CoreDataRepository?
        dataManager.fetchItems(completion: { (repo) in
            XCTAssertNotNil(repo?.last?.id)
            XCTAssertEqual(repo!.last!.id, Int32(testID))
            cdRepo = repo?.last
        })
        
        XCTAssertNotNil(cdRepo)
        dataManager.delete(cdRepo!)
        dataManager.saveContext()
        
        dataManager.fetchItems(completion: { (repo) in
            guard let id = repo?.last?.id else { return }
            XCTAssertNotEqual(id, Int32(testID))
        })
    }

}
