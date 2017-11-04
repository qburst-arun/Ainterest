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
                let defaultResponse:DefaultDownloadResponse = DefaultDownloadResponse(withRequestUrl: requestDetail.requestUrl, withData: requestDetail.data, withError: nil)
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
                let defaultResponse:DefaultDownloadResponse = DefaultDownloadResponse(withRequestUrl: requestDetail.requestUrl, withData: requestDetail.data, withError: nil)
                for handler in requestDetail.responseHandler!{
                    handler.completion!(defaultResponse)
                }
                requestDetail.responseHandler = []
                
                
            })
            
            let responseHandler:ResponseHandler = ResponseHandler(downloadHelperTaskID: taskId, progress: progress, completion: completion)
            let requestDetail:RequestDetail = RequestDetail(requestUrl: url, data: nil, urlSessionTaskID: sessionTaskId, responseHandler: [responseHandler])
            CacheController().addFileToCache(withKey: url, withValue: requestDetail)        }
    }
    
    //    public func cancelDownload(FromURL url:URL, withTaskId taskId:Int) {
    //
    //        if let downloadResponse:DefaultDownloadResponse = CacheController().checkUrlExistInCache(withKey:url){
    //            if downloadResponse.totalCachedCalls == 1{
    //                CacheController().removeFileFromCache(withKey: url)
    //            }else{
    //                downloadResponse.totalCachedCalls = downloadResponse.totalCachedCalls! - 1
    //                CacheController().addFileToCache(withKey: url, withValue: downloadResponse)
    //            }
    //        }else{
    //
    //        }
    //    }
    
}

