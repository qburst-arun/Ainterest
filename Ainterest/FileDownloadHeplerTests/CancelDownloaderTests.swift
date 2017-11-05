//
//  CancelDownloaderTests.swift
//  FileDownloadHeplerTests
//
//  Created by user on 05/11/17.
//  Copyright © 2017 Arun's Technologies. All rights reserved.
//

import XCTest
@testable import FileDownloadHelper

class CancelDownloaderTests: XCTestCase {
    
    var downloadTask1:FileDownloadHelper?
    var downloadTask2:FileDownloadHelper?
    var url:URL?
    var url2:URL?
    var url1:URL?
    override func setUp() {
        super.setUp()
        // Put setup code here.
        url = URL(string: "https://images.unsplash.com/photo-1464550883968-cec281c19761?ixlib=rb-0.3.5\u{0026}q=80\u{0026}fm=jpg\u{0026}crop=entropy\u{0026}s=4b142941bfd18159e2e4d166abcd0705")
        
        url1 = URL(string: "https://images.unsplash.com/photo-1464550580740-b3f73fd373cb?ixlib=rb-0.3.5\u{0026}q=80\u{0026}fm=jpg\u{0026}crop=entropy\u{0026}s=aff4510c05325ad3c7b07ed7062b10c5")
        
        url2 = URL(string: "http://www.otc.umd.edu/sites/default/files/documents/sample-license.pdf")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        downloadTask1 = nil
        downloadTask2 = nil
        url = nil
        url2 = nil
    }
    
    func testCancelSingleDownload() {
        let promiseCanceled = expectation(description: "Download canceled")
        
        downloadTask1 = FileDownloadHelper(withUrl: url!, Progress: {progress in
           
        }, Completion: {response in
            if response.error != nil && (response.error! as NSError).code == -999{
                promiseCanceled.fulfill()
                
            }else{
                XCTFail("Cancel operation failed")
            }
        })
        
        
        downloadTask1?.startDownload()
        downloadTask1?.cancelDownload()
        
        wait(for: [promiseCanceled], timeout: 10)
    }
    
    
    func testCancelDownloadWithoutEffectingSameURLs() {
        let promiseTask1Canceled = expectation(description: "Download canceled")
        let promiseTask2Complete = expectation(description: "Download completed")
        
        downloadTask1 = FileDownloadHelper(withUrl: url!, Progress: {progress in
            
        }, Completion: {response in
            if response.error != nil && (response.error! as NSError).code == -999{
                promiseTask1Canceled.fulfill()
                
            }else{
                XCTFail("Cancel operation failed")
            }
        })
        
        downloadTask2 = FileDownloadHelper(withUrl: url!, Progress: {progress in
            
        }, Completion: {response in
            if response.error != nil && (response.error! as NSError).code == -999{
               
                XCTFail("Cancel operation failed")
            }else{
                promiseTask2Complete.fulfill()
            }
        })
        
        downloadTask1?.startDownload()// starts task1
        downloadTask2?.startDownload()// starts task2
        
        downloadTask1?.cancelDownload()// cacncel task1
        
        wait(for: [promiseTask2Complete,promiseTask1Canceled], timeout: 10)
    }
    
}
