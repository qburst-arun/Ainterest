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
    public var taskHandler:[TaskHandler]?
    
    init(requestUrl:URL?, data:Data?, taskHandler:[TaskHandler]) {
        self.requestUrl = requestUrl
        self.data = data
        self.taskHandler = taskHandler
    }
}

public class TaskHandler: NSObject {
    public var downloadHelperTaskID:Int?
    public var progress:HelperTaskProgress?
    public var completion:HelperTaskCompletion?
    
    
    init(downloadHelperTaskID:Int, progress:@escaping HelperTaskProgress, completion:@escaping HelperTaskCompletion) {
        self.downloadHelperTaskID = downloadHelperTaskID
        self.progress = progress
        self.completion = completion
    }
}
