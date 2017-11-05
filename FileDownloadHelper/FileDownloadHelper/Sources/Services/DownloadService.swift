//
//  DownloadService.swift
//  FileDownloadHelper
//
//  Created by user on 03/11/17.
//  Copyright © 2017 Arun's Technologies. All rights reserved.
//

import Foundation

public class DownloadService: FileManager, URLSessionDownloadDelegate, URLSessionDelegate, URLSessionTaskDelegate{
    
    static var session: URLSession?
    static var backgroundTaskID:Int = 0
    var progressClosure:SessionTaskProgress?
    var completionClosure:SessionTaskCompletion?
    
    override init(){
        DownloadService.backgroundTaskID += 1
    }
    
    // MARK: - Download Service
    public func download(FromURL url:URL, withProgress progress:@escaping SessionTaskProgress, withCompleteion completion:@escaping SessionTaskCompletion) {
        progressClosure = progress
        completionClosure = completion
        let backgroudTaskId = String(Bundle.main.bundleIdentifier!) + "_" + String(DownloadService.backgroundTaskID)
        DownloadService.session = URLSession(configuration: URLSessionConfiguration.background(withIdentifier:backgroudTaskId), delegate: self, delegateQueue: OperationQueue.main)
        let task = DownloadService.session?.downloadTask(with: url)
        task?.resume()
    }
    
    // MARK: - Cancel Download Service
    public func cancel(WithURL url:URL) {
        if  DownloadService.session != nil{
        DownloadService.session?.getTasksWithCompletionHandler { (tasks, uploads, downloads) in
                
                for task in downloads {
                    if task.originalRequest?.url == url{
                        task.cancel()
                    }
                }
            }
            
        }
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
