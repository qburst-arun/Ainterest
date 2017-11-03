//
//  DefaultDownloadResponse.swift
//  FileDownloadHelper
//
//  Created by user on 03/11/17.
//  Copyright © 2017 Arun's Technologies. All rights reserved.
//

import Foundation
public class DefaultDownloadResponse: NSObject {
    public var requestUrl:String?
    public var data:Data?
    public var totalCalls:Int?
    
    init(withRequestUrl requestUrl:String?, withData data:Data?, withTotalCalls totalCalls:Int?) {
        self.requestUrl = requestUrl
        self.data = data
        self.totalCalls = totalCalls
    }
}
