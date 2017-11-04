//
//  StartDownloader.swift
//  FileDownloadHelper
//
//  Created by user on 04/11/17.
//  Copyright © 2017 Arun's Technologies. All rights reserved.
//

import Foundation
public class StartDownloader: NSObject{ //Intiate download and save request to cache
    // Shared instance
    public static let sharedInstance = StartDownloader()
    
    public func startDownload(FromURL url:URL, withTaskId taskId:Int, withProgress progress:@escaping HelperTaskProgress, withCompleteion completion:@escaping HelperTaskCompletion) {
        // Check for the URL is already requested for download
        if let requestDetail:RequestDetail = CacheController().getRequestFromCache(withKey:url){ //If it is requested
            
            // Check for URL download was completed or not
            if requestDetail.data != nil { // If downloaded return cached data
                let defaultResponse:DefaultDownloadResponse = DefaultDownloadResponse(requestUrl: requestDetail.requestUrl, data: requestDetail.data, error: nil)
                progress(1)
                completion(defaultResponse)
            }else{ // If not downloaded, update cache request by adding this task to taskHandler
                let taskHandler:TaskHandler = TaskHandler(downloadHelperTaskID: taskId, progress: progress, completion: completion)
                requestDetail.taskHandler?.append(taskHandler)
            }
            
        }else{ // If URL is not requested before
            // Create a new request object and cache it
            let taskHandler:TaskHandler = TaskHandler(downloadHelperTaskID: taskId, progress: progress, completion: completion)
            let requestDetail:RequestDetail = RequestDetail(requestUrl: url, data: nil, taskHandler: [taskHandler])
            CacheController().addRequestToCache(withKey: url, withValue: requestDetail)
            
            // intiate download by calling download service
            DownloadService().download(FromURL: url, withProgress:{progress in // it will trigger with a float, value between 0.00 to 1.00
                
                //load request from cache and trigger progress of all tasks
                let requestDetail:RequestDetail = CacheController().getRequestFromCache(withKey:url)!
                for handler in requestDetail.taskHandler!{
                    handler.progress!(progress)
                }
                
            }, withCompleteion:{fileData in //it will trigger with full downloaded data when download completes
                
                //load request from cache and do the following
                    // * Save FileData to coressponding request
                    // * Trigger completion of all tasks
                    // * Remove completed tasks from taskHandler
                let requestDetail:RequestDetail = CacheController().getRequestFromCache(withKey:url)!
                requestDetail.data = fileData
                let defaultResponse:DefaultDownloadResponse = DefaultDownloadResponse(requestUrl: requestDetail.requestUrl, data: requestDetail.data, error: nil)
                for handler in requestDetail.taskHandler!{
                    handler.completion!(defaultResponse)
                }
                requestDetail.taskHandler = []
                
                
            })
            
        }
    }
}
