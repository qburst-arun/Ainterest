//
//  FileDownloadHelper.swift
//  FileDownloadHelper
//
//  Created by user on 03/11/17.
//  Copyright © 2017 Arun's Technologies. All rights reserved.
//

import Foundation
public typealias ProgressClosure = (Float) -> ()
public typealias CompletionClosure = (DefaultDownloadResponse) -> ()
public class FileDownloadHelper: NSObject {
    
    public static var sharedUniqueId:Int = 0
    var taskId:Int = 0
    var url:URL?
    var progress:ProgressClosure?
    var completion:CompletionClosure?
    
    public init(withUrl url:URL, Progress progress:@escaping ProgressClosure, Completion completion:@escaping CompletionClosure) {
        FileDownloadHelper.sharedUniqueId += 1
        self.taskId = FileDownloadHelper.sharedUniqueId
        self.url = url
        self.progress = progress
        self.completion = completion
    }
    
    public func startDownload() {
        DownloadTaskController().startDownload(FromURL: url!, withTaskId:taskId, withProgress:progress!, withCompleteion: completion!)
    }
    
    public func cancelDownload(){
       return DownloadTaskController().cancelDownload(WithURL: url!, TaskId:taskId)
    }
    
    
}
