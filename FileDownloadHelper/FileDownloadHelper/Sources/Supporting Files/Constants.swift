//
//  Constants.swift
//  FileDownloadHelper
//
//  Created by user on 04/11/17.
//  Copyright © 2017 Arun's Technologies. All rights reserved.
//

import Foundation

public typealias HelperTaskProgress = (Float) -> ()
public typealias HelperTaskCompletion = (DefaultDownloadResponse) -> ()

public typealias SessionTaskCompletion = (Data?, Error?) -> ()
public typealias SessionTaskProgress = (Float) -> ()

let userInfo: [AnyHashable : Any] =
    [
        NSLocalizedDescriptionKey :  NSLocalizedString("Cancelled", value: "cancelled", comment: "") ,
        NSLocalizedFailureReasonErrorKey : NSLocalizedString("Cancelled", value: "Canceled by user", comment: "")
    ]
public let DOWNLOAD_CANCEL_ERROR = NSError(domain: "NSURLErrorDomain", code: -999, userInfo: userInfo) as Error

