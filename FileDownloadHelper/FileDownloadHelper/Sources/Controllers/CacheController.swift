//
//  CacheController.swift
//  FileDownloadHelper
//
//  Created by user on 03/11/17.
//  Copyright © 2017 Arun's Technologies. All rights reserved.
//

import Foundation

public class CacheController: NSObject {
    
    public func clearCache() -> Bool {
    
        return true
    }
    
    public func addToCache(withKey key:String, withValue value:AnyObject) -> Bool {
        
        return true
    }
    
    public func checkKeyExistInCache(withKey key:String) -> CacheValueModel {
        
        return CacheValueModel(withUrl: nil,withData: nil,withTotalCalls: nil,withContentType:nil)
    }
}
