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
    
    public func addFileToCache(withKey key:URL, withValue value:RequestDetail) {
        CacheServices.sharedInstance.insertToCache(withKey: key, withValue: value)
    }
    
    public func checkUrlExistInCache(withKey key:URL) -> RequestDetail? {
        
        return CacheServices.sharedInstance.retriveContentFromCache(withKey:key)
    }
    
    
    public func removeFileFromCache(withKey key:URL) {
        CacheServices.sharedInstance.deleteContent(withKey: key)
    }
}
