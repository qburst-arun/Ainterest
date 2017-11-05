//
//  CacheControllerTests.swift
//  FileDownloadHeplerTests
//
//  Created by user on 05/11/17.
//  Copyright © 2017 Arun's Technologies. All rights reserved.
//

import XCTest
@testable import FileDownloadHelper

class CacheControllerTests: XCTestCase {
    
    var url:URL?
    var request:RequestDetail?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        url = URL.init(string: "https://images.unsplash.com/photo-1464550883968-cec281c19761?ixlib=rb-0.3.5\u{0026}q=80\u{0026}fm=jpg\u{0026}crop=entropy\u{0026}s=4b142941bfd18159e2e4d166abcd0705")
        request = RequestDetail(requestUrl: url, data: nil, taskHandler: [])
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        url = nil
        request = nil
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testAddandRetriveFromCache() {
        CacheController.sharedInstance.addRequestToCache(withKey: url!, withValue: request!)
        if CacheController.sharedInstance.getRequestFromCache(withKey: url!) != nil{
            XCTAssert(true, "Saved and Retrived Successfully")
        }else{
            XCTFail("Cache opertation failed")
        }
    }
    
    func testDeleteFromCache() {
        CacheController.sharedInstance.addRequestToCache(withKey: url!, withValue: request!)
        CacheController.sharedInstance.removeRequestFromCache(withKey: url!)
        if CacheController.sharedInstance.getRequestFromCache(withKey: url!) != nil{
            XCTFail("Cache opertation failed")
        }else{
            XCTAssert(true, "Deleted Successfully")
        }
    }
}
