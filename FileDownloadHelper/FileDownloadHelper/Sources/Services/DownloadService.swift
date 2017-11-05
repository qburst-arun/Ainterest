//
//  DownloadService.swift
//  FileDownloadHelper
//
//  Created by user on 03/11/17.
//  Copyright © 2017 Arun's Technologies. All rights reserved.
//

import Foundation

public class DownloadService: FileManager, URLSessionDownloadDelegate, URLSessionDelegate, URLSessionTaskDelegate{
    
    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }()
    
    var progressClosure:SessionTaskProgress?
    var completionClosure:SessionTaskCompletion?
    
    
    // MARK: - Download Service
    
    public func download(FromURL url:URL, withProgress progress:@escaping SessionTaskProgress, withCompleteion completion:@escaping SessionTaskCompletion) {
        progressClosure = progress
        completionClosure = completion
//        DownloadService.session = URLSession(configuration: URLSessionConfiguration.background(withIdentifier: "backgroundsessions"), delegate: self, delegateQueue: OperationQueue.main)
        let task = session.downloadTask(with: url)
        task.resume()
    }
    
    // MARK: - Cancel Download Service
    public func cancel(WithURL url:URL) {
        
//        if  DownloadService.session != nil{
            session.getTasksWithCompletionHandler { (tasks, uploads, downloads) in
                
                for task in downloads {
                    if task.originalRequest?.url == url{
                        task.cancel()
                    }
                }
            }
            
//        }
    }
    // MARK: - URLSession download delegates
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask,
                           didWriteData bytesWritten: Int64, totalBytesWritten: Int64,
                           totalBytesExpectedToWrite: Int64) {
        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        progressClosure!(progress)
    }
    
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        if let fileData:NSData = NSData(contentsOf: location) {
            completionClosure!((fileData as Data), nil)
        }
    }
    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if error != nil{
            print("Failed Download")
            progressClosure!(1)
            completionClosure!(nil, error)
        }
    }
    
}
