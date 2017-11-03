//
//  CacheController.swift
//  FileDownloadHelper
//
//  Created by user on 03/11/17.
//  Copyright © 2017 Arun's Technologies. All rights reserved.
//

import Foundation

public class CacheController: NSObject {
    
    public func clearAllCache() {
    
    }
    
    public func addFileToCache(withKey key:String, withValue value:DefaultDownloadResponse) {
        CacheServices.sharedInstance.insertToCache(withKey: key, withValue: value)
    }
    
    public func checkUrlExistInCache(withKey key:String) -> DefaultDownloadResponse? {
        
        return CacheServices.sharedInstance.retriveContentFromCache(withKey:key)
    }
    
    
    public func removeFileFromCache(withKey key:String, withValue value:DefaultDownloadResponse) {
        CacheServices.sharedInstance.deleteContent(withKey: key)
    }
}
