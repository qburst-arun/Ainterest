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
    var progressClosure:ProgressClosure?
    var completionClosure:((Data) -> ())?
    public func download(FromURL url:URL, withProgress progress:@escaping ProgressClosure, withCompleteion completion:@escaping (Data) -> ()) {
        progressClosure = progress
        completionClosure = completion
        DownloadService.config = URLSessionConfiguration.background(withIdentifier: "com.arunjose")
        DownloadService.session = URLSession(configuration: DownloadService.config!, delegate: self, delegateQueue: OperationQueue.main)
        let task = DownloadService.session?.downloadTask(with: url)
        task?.resume()
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
    
    
    public func cancelDownload(FromURL url:URL) {
        
//        if  DownloadService.session != nil{
//            DownloadService.session?.getTasksWithCompletionHandler(( dataTask:[URLSessionDataTask],
//                dataTask1:[URLSessionUploadTask],
//                dataTask2:[URLSessionDownloadTask]) -> Void) {
//            }
//        }else{
//            
//        }
    }

}
