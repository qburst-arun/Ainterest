//
//  FileDownloadHelper.swift
//  FileDownloadHelper
//
//  Created by user on 03/11/17.
//  Copyright © 2017 Arun's Technologies. All rights reserved.
//

import Foundation

public class FileDownloadHelper: NSObject {
    
    public static var sharedUniqueId:Int = 0
    var taskId:Int = 0 // Task Identifier
    var url:URL?
    var progress:HelperTaskProgress?
    var completion:HelperTaskCompletion?
    
    public init(withUrl url:URL, Progress progress:@escaping HelperTaskProgress, Completion completion:@escaping HelperTaskCompletion) {
        FileDownloadHelper.sharedUniqueId += 1 // create unique task identifier
        self.taskId = FileDownloadHelper.sharedUniqueId
        self.url = url
        self.progress = progress
        self.completion = completion
    }
    
    public func startDownload() {
       StartDownloader.sharedInstance.startDownload(FromURL: url!, withTaskId:taskId, withProgress:progress!, withCompleteion: completion!)
    }
    
    public func cancelDownload(){
        CancelDownloader.sharedInstance.cancelDownload(WithURL: url!, TaskId:taskId)
    }
    
    static public func setCacheLimit(limit:Int){
        CacheController.sharedInstance.setCacheLimit(withMaxObjects: limit)
    }
    
}
