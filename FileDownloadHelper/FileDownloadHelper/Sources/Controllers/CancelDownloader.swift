//
//  CancelDownloader.swift
//  FileDownloadHelper
//
//  Created by user on 04/11/17.
//  Copyright © 2017 Arun's Technologies. All rights reserved.
//

import Foundation
public class CancelDownloader: NSObject{ // Cancel ongoing downloads
    // Shared instance
    public static let sharedInstance = CancelDownloader()
    
    public func cancelDownload(WithURL url:URL, TaskId taskId:Int) {
        // Load request from cache
        if let requestDetail:RequestDetail = CacheController().getRequestFromCache(withKey:url){// loaded
            
            //Check download is completed or not
            if requestDetail.data == nil{ //not completed
                
                // Create default response with error
                let defaultResponse = DefaultDownloadResponse(requestUrl: url, data: nil, error:DOWNLOAD_CANCEL_ERROR)
                
                // Check URL request contain only one task
                if requestDetail.taskHandler?.count == 1{ // If only have one task do following
                    
                    // * Cancel download task of download service
                    // * Trigger task handlers with error message
                    // * Remove request from cache
                    DownloadService().cancel(WithURL: url)
                    requestDetail.taskHandler![0].progress!(1)
                    requestDetail.taskHandler![0].completion!(defaultResponse)
                    CacheController().removeRequestFromCache(withKey:url)
                }else{ // If more than one tasks for same url
                    
                    // search task to cancel from task handler and remove the task from cachce-request. Also trigger completion with error
                    for taskHandler in requestDetail.taskHandler!{
                        if taskHandler.downloadHelperTaskID == taskId{
                            requestDetail.taskHandler![0].progress!(1)
                            requestDetail.taskHandler![0].completion!(defaultResponse)
                            let index = requestDetail.taskHandler?.index(of: taskHandler)
                            requestDetail.taskHandler?.remove(at: index!)
                        }
                    }
                }
            }
        }
    }
    
}
