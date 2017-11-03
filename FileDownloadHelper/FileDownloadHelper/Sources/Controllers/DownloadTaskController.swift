//
//  DownloadTaskController.swift
//  FileDownloadHelper
//
//  Created by user on 03/11/17.
//  Copyright © 2017 Arun's Technologies. All rights reserved.
//

import Foundation

public class DownloadTaskController: NSObject{
    
    public func startDownload(FromURL url:URL, withProgress progress:@escaping ProgressClosure) {
       DownloadService().download(FromURL: url, withProgress: progress)
    }
    
    
}

