//
//  NewsRealmTest.swift
//  LD Swift NewsTests
//
//  Created by Gaurav Parvadiya on 06/10/19.
//  Copyright © 2019 Gaurav Parvadiya. All rights reserved.
//

import XCTest
@testable import LD_Swift_News
import RealmSwift

class NewsRealmTest: XCTestCase {
    
    var realm: Realm?
    
    override func setUp() {
        super.setUp()
        do {
            realm = try Realm()
        } catch let e {
            print(e.localizedDescription)
        }
    }
    
    override func tearDown() {
        super.tearDown()
        realm?.writeTransactionWait {
            self.realm?.deleteAll()
        }
        realm = nil
    }
    
    func testRealmInitialization() {
        XCTAssertNotNil(realm)
    }
    
    func testNewsAddToRealm() {
        let jsonData = "{\"data\": { \"selftext\": \"What Swift-related projects are you currently working on?\",\"title\": \"What’s everyone working on this month? (October 2019)\", \"thumbnail\": \"self\",\"id\": \"ddp5fr\"}}".data(using: .utf8)
        let decoder = JSONDecoder()
        
        do {
            let object = try decoder.decode(News.self, from: jsonData!)
            realm?.writeTransactionWait {
                self.realm?.create(News.self, value: object, update: .modified)
            }
            
            XCTAssertEqual(realm?.objects(News.self).first?.id, "ddp5fr", "News was not properly updated from server.")
        }
        catch {
            XCTFail()
        }
    }
}
