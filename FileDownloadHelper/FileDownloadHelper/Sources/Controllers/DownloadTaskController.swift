//
//  DownloadTaskController.swift
//  FileDownloadHelper
//
//  Created by user on 03/11/17.
//  Copyright © 2017 Arun's Technologies. All rights reserved.
//

import Foundation

public typealias DownloadCompletionClosure = (Data) -> ()
public typealias DownloadProgressClosure = (Float) -> ()
public class DownloadTaskController: NSObject{
    
    public func startDownload(FromURL url:URL, withTaskId taskId:Int, withProgress progress:@escaping ProgressClosure, withCompleteion completion:@escaping CompletionClosure) {
        
        if let requestDetail:RequestDetail = CacheController().checkUrlExistInCache(withKey:url){
            if requestDetail.data != nil {
                let defaultResponse:DefaultDownloadResponse = DefaultDownloadResponse(requestUrl: requestDetail.requestUrl, data: requestDetail.data, error: nil)
                progress(1)
                completion(defaultResponse)
            }else{
                let responseHandler:ResponseHandler = ResponseHandler(downloadHelperTaskID: taskId, progress: progress, completion: completion)
                requestDetail.responseHandler?.append(responseHandler)
                CacheController().addFileToCache(withKey: url, withValue: requestDetail)
            }
        }else{
            let sessionTaskId = DownloadService().download(FromURL: url, withProgress:{progress in
                let requestDetail:RequestDetail = CacheController().checkUrlExistInCache(withKey:url)!
                for handler in requestDetail.responseHandler!{
                    handler.progress!(progress)
                }
                
            }, withCompleteion:{fileData in
                let requestDetail:RequestDetail = CacheController().checkUrlExistInCache(withKey:url)!
                requestDetail.data = fileData
                let defaultResponse:DefaultDownloadResponse = DefaultDownloadResponse(requestUrl: requestDetail.requestUrl, data: requestDetail.data, error: nil)
                for handler in requestDetail.responseHandler!{
                    handler.completion!(defaultResponse)
                }
                requestDetail.responseHandler = []
                
                
            })
            
            let responseHandler:ResponseHandler = ResponseHandler(downloadHelperTaskID: taskId, progress: progress, completion: completion)
            let requestDetail:RequestDetail = RequestDetail(requestUrl: url, data: nil, urlSessionTaskID: sessionTaskId, responseHandler: [responseHandler])
            CacheController().addFileToCache(withKey: url, withValue: requestDetail)        }
    }
    
        public func cancelDownload(WithURL url:URL, TaskId taskId:Int) {
    
            if let requestDetail:RequestDetail = CacheController().checkUrlExistInCache(withKey:url){
                if requestDetail.data == nil{
                    let userInfo: [AnyHashable : Any] =
                        [
                            NSLocalizedDescriptionKey :  NSLocalizedString("Unauthorized", value: "Please activate your account", comment: "") ,
                            NSLocalizedFailureReasonErrorKey : NSLocalizedString("Unauthorized", value: "Account not activated", comment: "")
                    ]
                    let err = NSError(domain: "ShiploopHttpResponseErrorDomain", code: 401, userInfo: userInfo)
                    let defaultResponse = DefaultDownloadResponse(requestUrl: url, data: nil, error:err)
                    if requestDetail.responseHandler?.count == 1{
                        DownloadService().cancelDownload(WithURL: url)
                        requestDetail.responseHandler![0].progress!(1)
                        requestDetail.responseHandler![0].completion!(defaultResponse)
                        CacheController().removeFileFromCache(withKey:url)
                    }else{
                        for responseHandler in requestDetail.responseHandler!{
                            if responseHandler.downloadHelperTaskID == taskId{
                                requestDetail.responseHandler![0].progress!(1)
                                requestDetail.responseHandler![0].completion!(defaultResponse)
                                let index = requestDetail.responseHandler?.index(of: responseHandler)
                                requestDetail.responseHandler?.remove(at: index!)
                                
                            }
                        }
                        
                    }
                    
                }else{
                }
            }else{
            }
        }
    
}

