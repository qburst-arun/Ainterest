//
//  FileDownloadHeplerTests.swift
//  FileDownloadHeplerTests
//
//  Created by user on 05/11/17.
//  Copyright © 2017 Arun's Technologies. All rights reserved.
//

import XCTest
@testable import Ainterest
@testable import FileDownloadHelper

class FileDownloadHeplerTests: XCTestCase {
    
    var taskId1:Int = 0
    var url1:URL?
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        taskId1 = 1
        url1 = URL.init(string: "https://images.unsplash.com/photo-1464550883968-cec281c19761?ixlib=rb-0.3.5\u{0026}q=80\u{0026}fm=jpg\u{0026}crop=entropy\u{0026}s=4b142941bfd18159e2e4d166abcd0705")
        super.tearDown()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testSingleDowloadTask() {
        let promiseProgerss = expectation(description: "progress reached")
        let promiseCompletion = expectation(description: "complletion reached")
        
        StartDownloader.sharedInstance.startDownload(FromURL: url1!, withTaskId: taskId1, withProgress: {progress in
            if progress == 1{
                promiseProgerss.fulfill()
            }
        }, withCompleteion: {response in
            if response.error != nil{
                XCTFail("File Download Failed")
                
            }else{
                promiseCompletion.fulfill()
            }
        })
        wait(for: [promiseProgerss,promiseCompletion], timeout: 10)
    }
}
