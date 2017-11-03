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
        
        if let downloadResponse:DefaultDownloadResponse = CacheController().checkUrlExistInCache(withKey: String(describing: url)){
            downloadResponse.totalCalls = downloadResponse.totalCalls! + 1
            CacheController().addFileToCache(withKey: String(describing: url), withValue: downloadResponse)
            completion(downloadResponse)
        }else{
            DownloadService().download(FromURL: url, withProgress: progress, withCompleteion:{fileData in
                let response:DefaultDownloadResponse = DefaultDownloadResponse(withRequestUrl: String(describing: url), withData: fileData, withTotalCalls: 1)
                CacheController().addFileToCache(withKey: String(describing: url), withValue: response)
                    completion(response)
                
            })
        }
    }
    
    
}

