//
//  DownloadTaskController.swift
//  FileDownloadHelper
//
//  Created by user on 03/11/17.
//  Copyright © 2017 Arun's Technologies. All rights reserved.
//

import Foundation

public typealias DataCompletionClosure = (Data) -> ()
public class DownloadTaskController: NSObject{
    
    public func startDownload(FromURL url:URL, withProgress progress:@escaping ProgressClosure, withCompleteion completion:@escaping CompletionClosure) {
        
        if let downloadResponse:DefaultDownloadResponse = CacheController().checkUrlExistInCache(withKey:url){
            downloadResponse.totalCalls = downloadResponse.totalCalls! + 1
            CacheController().addFileToCache(withKey: url, withValue: downloadResponse)
            completion(downloadResponse)
        }else{
            DownloadService().download(FromURL: url, withProgress: progress, withCompleteion:{fileData in
                let response:DefaultDownloadResponse = DefaultDownloadResponse(withRequestUrl: String(describing: url), withData: fileData, withTotalCalls: 1)
                CacheController().addFileToCache(withKey: url, withValue: response)
                    completion(response)
                
            })
        }
    }
    
    public func cancelDownload(FromURL url:URL) {
        
        if let downloadResponse:DefaultDownloadResponse = CacheController().checkUrlExistInCache(withKey:url){
            if downloadResponse.totalCalls == 1{
                CacheController().removeFileFromCache(withKey: url)
            }else{
                downloadResponse.totalCalls = downloadResponse.totalCalls! - 1
                CacheController().addFileToCache(withKey: url, withValue: downloadResponse)
            }
        }else{
            
        }
    }
    
}

