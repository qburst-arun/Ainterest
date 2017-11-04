//
//  CancelResponse.swift
//  FileDownloadHelper
//
//  Created by user on 04/11/17.
//  Copyright © 2017 Arun's Technologies. All rights reserved.
//

import Foundation
public class CancelResponse: NSObject {
    public var status:String?
    public var message:String?
    
    init(status:String?, message:String?) {
        self.status = status
        self.message = message
    }
}
