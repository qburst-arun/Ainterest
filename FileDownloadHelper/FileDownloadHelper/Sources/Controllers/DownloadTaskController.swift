//
//  DownloadTaskController.swift
//  FileDownloadHelper
//
//  Created by user on 03/11/17.
//  Copyright © 2017 Arun's Technologies. All rights reserved.
//

import Foundation

public class DownloadTaskController: NSObject{
    
    public func startDownload(FromURL url:URL, withTaskId taskId:Int, withProgress progress:@escaping HelperTaskProgress, withCompleteion completion:@escaping HelperTaskCompletion) {
        
        if let requestDetail:RequestDetail = CacheController().getRequestFromCache(withKey:url){
            if requestDetail.data != nil {
                let defaultResponse:DefaultDownloadResponse = DefaultDownloadResponse(requestUrl: requestDetail.requestUrl, data: requestDetail.data, error: nil)
                progress(1)
                completion(defaultResponse)
            }else{
                let responseHandler:TaskHandler = TaskHandler(downloadHelperTaskID: taskId, progress: progress, completion: completion)
                requestDetail.taskHandler?.append(responseHandler)
                CacheController().addRequestToCache(withKey: url, withValue: requestDetail)
            }
        }else{
            DownloadService().download(FromURL: url, withProgress:{progress in
                let requestDetail:RequestDetail = CacheController().getRequestFromCache(withKey:url)!
                for handler in requestDetail.taskHandler!{
                    handler.progress!(progress)
                }
                
            }, withCompleteion:{fileData in
                let requestDetail:RequestDetail = CacheController().getRequestFromCache(withKey:url)!
                requestDetail.data = fileData
                let defaultResponse:DefaultDownloadResponse = DefaultDownloadResponse(requestUrl: requestDetail.requestUrl, data: requestDetail.data, error: nil)
                for handler in requestDetail.taskHandler!{
                    handler.completion!(defaultResponse)
                }
                requestDetail.taskHandler = []
                
                
            })
            
            let responseHandler:TaskHandler = TaskHandler(downloadHelperTaskID: taskId, progress: progress, completion: completion)
            let requestDetail:RequestDetail = RequestDetail(requestUrl: url, data: nil, taskHandler: [responseHandler])
            CacheController().addRequestToCache(withKey: url, withValue: requestDetail)        }
    }
    
        public func cancelDownload(WithURL url:URL, TaskId taskId:Int) {
    
            if let requestDetail:RequestDetail = CacheController().getRequestFromCache(withKey:url){
                if requestDetail.data == nil{
                    let userInfo: [AnyHashable : Any] =
                        [
                            NSLocalizedDescriptionKey :  NSLocalizedString("Unauthorized", value: "Please activate your account", comment: "") ,
                            NSLocalizedFailureReasonErrorKey : NSLocalizedString("Unauthorized", value: "Account not activated", comment: "")
                    ]
                    let err = NSError(domain: "ShiploopHttpResponseErrorDomain", code: 401, userInfo: userInfo)
                    let defaultResponse = DefaultDownloadResponse(requestUrl: url, data: nil, error:err)
                    if requestDetail.taskHandler?.count == 1{
                        DownloadService().cancel(WithURL: url)
                        requestDetail.taskHandler![0].progress!(1)
                        requestDetail.taskHandler![0].completion!(defaultResponse)
                        CacheController().removeRequestFromCache(withKey:url)
                    }else{
                        for responseHandler in requestDetail.taskHandler!{
                            if responseHandler.downloadHelperTaskID == taskId{
                                requestDetail.taskHandler![0].progress!(1)
                                requestDetail.taskHandler![0].completion!(defaultResponse)
                                let index = requestDetail.taskHandler?.index(of: responseHandler)
                                requestDetail.taskHandler?.remove(at: index!)
                                
                            }
                        }
                        
                    }
                    
                }else{
                }
            }else{
            }
        }
    
}

