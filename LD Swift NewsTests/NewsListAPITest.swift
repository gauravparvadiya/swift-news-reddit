//
//  NewsListAPITest.swift
//  LD Swift NewsTests
//
//  Created by Gaurav Parvadiya on 06/10/19.
//  Copyright © 2019 Gaurav Parvadiya. All rights reserved.
//

import XCTest
@testable import LD_Swift_News

class NewsListAPITest: XCTestCase {
    
    var apiRepo: NewsAPIRepository?
    
    override func setUp() {
        super.setUp()
        let repo = NewsAPIRepository()
        apiRepo = repo
    }
    
    override func tearDown() {
        super.tearDown()
        apiRepo = nil
    }
    
    func testFetchNewsSuccessResponse() {
        let newsExpectation = expectation(description: "news")
        let news: [News] = []
        
        apiRepo?.fetchNews(completion: { news in
            newsExpectation.fulfill()
        }, error: { errorMessage in
            XCTFail("Error: \(errorMessage)")
        })
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(news)
        }
    }
    
    
}
