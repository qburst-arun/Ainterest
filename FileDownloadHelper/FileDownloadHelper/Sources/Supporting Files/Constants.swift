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

public typealias SessionTaskCompletion = (Data) -> ()
public typealias SessionTaskProgress = (Float) -> ()

let userInfo: [AnyHashable : Any] =
    [
        NSLocalizedDescriptionKey :  NSLocalizedString("Cancelled", value: "Download canceled", comment: "") ,
        NSLocalizedFailureReasonErrorKey : NSLocalizedString("Cancelled", value: "Canceled by user", comment: "")
    ]
public let DOWNLOAD_CANCEL_ERROR = NSError(domain: "DownloadFileErrorDomain", code: 401, userInfo: userInfo) as Error

