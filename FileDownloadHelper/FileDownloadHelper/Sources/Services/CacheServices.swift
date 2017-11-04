//
//  CacheServices.swift
//  FileDownloadHelper
//
//  Created by user on 03/11/17.
//  Copyright © 2017 Arun's Technologies. All rights reserved.
//

import Foundation

class CacheServices: NSObject {

    // MARK: - Shared Instance
    public static let sharedInstance = CacheServices()
    private var cache:NSCache = NSCache<AnyObject,RequestDetail>()
    
    public func configureCacheSize(maxlimitOfObjects:Int) {
        cache.countLimit = maxlimitOfObjects
    }
    public func deleteContent(withKey key:URL) {
        cache.removeObject(forKey: key as AnyObject)
    }
    
    public func insertToCache(withKey key:URL, withValue value:RequestDetail) {
        cache.setObject(value, forKey: key as AnyObject)
    }
    
    public func retriveContentFromCache(withKey key:URL) -> RequestDetail? {
        
        if let value:RequestDetail = cache.object(forKey: key as AnyObject ){
            return value
        }else{
            return nil
        }
    }
}
