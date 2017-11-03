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
    private var cache:NSCache = NSCache<AnyObject,CacheValueModel>()
    
    public func configureCacheSize(maxlimitOfObjects:Int) {
        
        cache.countLimit = maxlimitOfObjects
    }
    public func deleteContent(withKey key:String) -> Bool {
        cache.removeObject(forKey: key as AnyObject)
        return true
    }
    
    public func insertToCache(withKey key:String, withValue value:CacheValueModel) -> Bool {
        cache.setObject(value, forKey: key as AnyObject)
        return true
    }
    
    public func retriveContentFromCache(withKey key:String) -> CacheValueModel {
        
        if let value:CacheValueModel = cache.object(forKey: key as AnyObject){
            return value
        }else{
            return CacheValueModel(withUrl: nil,withData: nil,withTotalCalls: nil,withContentType:nil)
        }
    }
}
