//
//  DownloadService.swift
//  FileDownloadHelper
//
//  Created by user on 03/11/17.
//  Copyright © 2017 Arun's Technologies. All rights reserved.
//

import Foundation

public class DownloadService: FileManager, URLSessionDownloadDelegate, URLSessionDelegate, URLSessionTaskDelegate{
    
    static var config:URLSessionConfiguration?
    static var session:URLSession?
    var progressClosure:DownloadProgressClosure?
    var completionClosure:DownloadCompletionClosure?
    
    public func download(FromURL url:URL, withProgress progress:@escaping DownloadProgressClosure, withCompleteion completion:@escaping DownloadCompletionClosure) -> Int {
        progressClosure = progress
        completionClosure = completion
        DownloadService.config = URLSessionConfiguration.background(withIdentifier: "com.arunjose")
        DownloadService.session = URLSession(configuration: DownloadService.config!, delegate: self, delegateQueue: OperationQueue.main)
        let task = DownloadService.session?.downloadTask(with: url)
        task?.resume()
        return (task?.taskIdentifier)!
    }
    
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask,
                           didWriteData bytesWritten: Int64, totalBytesWritten: Int64,
                           totalBytesExpectedToWrite: Int64) {
        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        progressClosure!(progress)
    }
    
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
//        let fileData:Data? = FileManager.default.contents(atPath: String(describing: location))
        if let fileData:NSData = NSData(contentsOf: location) {
            completionClosure!((fileData as Data))
        }
    }
    
    
    public func cancelDownload(FromURL url:URL) {
        
        if  DownloadService.session != nil{
            DownloadService.session?.getTasksWithCompletionHandler { (tasks, uploads, downloads) in
                let bytesReceived = downloads.map{ $0.countOfBytesReceived }.reduce(0, +)
                let bytesExpectedToReceive = downloads.map{ $0.countOfBytesExpectedToReceive }.reduce(0, +)
                let progress = bytesExpectedToReceive > 0 ? Float(bytesReceived) / Float(bytesExpectedToReceive) : 0.0
                for task in downloads {
                    if task.originalRequest?.url == url{
                        task.cancel()
                    }
                }
            }
            
        }else{
            
        }
    }

}
