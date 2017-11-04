//
//  RequestDetail.swift
//  FileDownloadHelper
//
//  Created by user on 04/11/17.
//  Copyright © 2017 Arun's Technologies. All rights reserved.
//

import Foundation
public class RequestDetail: NSObject {
    public var requestUrl:URL?
    public var data:Data?
    public var urlSessionTaskID:Int?
    public var responseHandler:[ResponseHandler]?
    
    init(requestUrl:URL?, data:Data?, urlSessionTaskID:Int, responseHandler:[ResponseHandler]) {
        self.requestUrl = requestUrl
        self.data = data
        self.urlSessionTaskID = urlSessionTaskID
        self.responseHandler = responseHandler
    }
}

public class ResponseHandler: NSObject {
    public var downloadHelperTaskID:Int?
    public var progress:ProgressClosure?
    public var completion:CompletionClosure?
    
    
    init(downloadHelperTaskID:Int, progress:@escaping ProgressClosure, completion:@escaping CompletionClosure) {
        self.downloadHelperTaskID = downloadHelperTaskID
        self.progress = progress
        self.completion = completion
    }
    
//    required public init(coder decoder: NSCoder) {
//
//        self.downloadHelperTaskID = decoder.decodeInteger(forKey: "downloadHelperTaskID")
//        self.progress = decoder.decodeObject(forKey: "progress") as? ProgressClosure
//        self.completion = decoder.decodeObject(forKey:"completion") as? CompletionClosure
//
//    }
//
//    public func encode(with coder: NSCoder) {
//        coder.encode(downloadHelperTaskID, forKey: "downloadHelperTaskID")
//        coder.encode(progress, forKey: "progress")
//        coder.encode(completion, forKey: "completion")
//
//    }
}
