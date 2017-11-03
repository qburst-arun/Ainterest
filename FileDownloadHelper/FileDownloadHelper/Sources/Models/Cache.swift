//
//  Cache.swift
//  FileDownloadHelper
//
//  Created by user on 03/11/17.
//  Copyright © 2017 Arun's Technologies. All rights reserved.
//

import Foundation
public class CacheValueModel: NSObject {
    var url:String?
    var data:Data?
    var totalCalls:Int?
    var contentType:SupportedFileFormats?
    
    init(withUrl url:String?, withData data:Data?, withTotalCalls totalCalls:Int?, withContentType contentType:SupportedFileFormats?) {
         self.url = url
         self.data = data
         self.totalCalls = totalCalls
         self.contentType = contentType
    }
}
