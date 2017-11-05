//
//  FileDownloadHelperTests.swift
//  FileDownloadHelperTests
//
//  Created by user on 03/11/17.
//  Copyright © 2017 Arun's Technologies. All rights reserved.
//

import XCTest
@testable import FileDownloadHelper

class FileDownloadHelperTests: XCTestCase {
    
    var downloadTask:FileDownloadHelper?
    var sessionUnderTest: URLSession!
    
    override func setUp() {
        super.setUp()
        sessionUnderTest = URLSession(configuration: URLSessionConfiguration.background(withIdentifier: "com.arunjose"))
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sessionUnderTest = nil
        super.tearDown()
    }
    
    func testSingleDowloadTask() {
       
        let promiseProgerss = expectation(description: "progress reached")
        let promiseCompletion = expectation(description: "download completed")
        downloadTask = FileDownloadHelper(withUrl: URL(string: "https://images.unsplash.com/photo-1464550883968-cec281c19761?ixlib=rb-0.3.5\u{0026}q=80\u{0026}fm=jpg\u{0026}crop=entropy\u{0026}s=4b142941bfd18159e2e4d166abcd0705")!, Progress: {progress in
            if progress == 1{
                promiseProgerss.fulfill()
            }
            
        }, Completion: {response in
            if response.error != nil{
                XCTFail("File Download Failed")
                
            }else{
                promiseCompletion.fulfill()
            }
        })
        downloadTask?.startDownload()
        wait(for: [promiseCompletion,promiseProgerss], timeout: 10)
    }
    
    // Asynchronous test: success fast, failure slow
    func testValidCallToiTunesGetsHTTPStatusCode200() {
        // given
        let url = URL(string: "https://itunes.apple.com/search?media=music&entity=song&term=abba")
        // 1
        let promise = expectation(description: "Status code: 200")
        
        // when
        let dataTask = sessionUnderTest.downloadTask(with: url!) { data, response, error in
            // then
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    // 2
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        // 3
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}
