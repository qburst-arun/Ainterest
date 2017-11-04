//
//  DefaultDownloadResponse.swift
//  FileDownloadHelper
//
//  Created by user on 03/11/17.
//  Copyright © 2017 Arun's Technologies. All rights reserved.
//

import Foundation
public class DefaultDownloadResponse: NSObject {
    public var requestUrl:URL?
    public var data:Data?
    public var error:Error?
    
    init(requestUrl:URL?, data:Data?, error:Error?) {
        self.requestUrl = requestUrl
        self.data = data
        self.error = error
    }
}
