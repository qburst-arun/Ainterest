//
//  CacheController.swift
//  FileDownloadHelper
//
//  Created by user on 03/11/17.
//  Copyright © 2017 Arun's Technologies. All rights reserved.
//

import Foundation

public class CacheController: NSObject {
    // Shared instance
    public static let sharedInstance = CacheController()
    
    public func clearCache() {
     CacheServices.sharedInstance.clearAll()
    }
    
    public func addRequestToCache(withKey key:URL, withValue value:RequestDetail) {
        CacheServices.sharedInstance.insert(withKey: key, withValue: value)
    }
    
    public func getRequestFromCache(withKey key:URL) -> RequestDetail? {
        return CacheServices.sharedInstance.getContent(withKey:key)
    }
    
    
    public func removeRequestFromCache(withKey key:URL) {
        CacheServices.sharedInstance.removeContent(withKey: key)
    }
}
