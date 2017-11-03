//
//  DownloadService.swift
//  FileDownloadHelper
//
//  Created by user on 03/11/17.
//  Copyright © 2017 Arun's Technologies. All rights reserved.
//

import Foundation

public class DownloadService: FileManager, URLSessionDownloadDelegate, URLSessionDelegate, URLSessionTaskDelegate{
    
    var progressClosure:ProgressClosure?
    var completionClosure:((Data) -> ())?
    public func download(FromURL url:URL, withProgress progress:@escaping ProgressClosure, withCompleteion completion:@escaping (Data) -> ()) {
        progressClosure = progress
        completionClosure = completion
        let config = URLSessionConfiguration.background(withIdentifier: "com.arunjose")
        let session = URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue.main)
        let task = session.downloadTask(with: url)
        task.resume()
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
            completionClosure!(fileData as Data)
        }
    }
}
