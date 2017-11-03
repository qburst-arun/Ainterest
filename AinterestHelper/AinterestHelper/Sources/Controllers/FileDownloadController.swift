//
//  FileDownloadController.swift
//  AinterestHelper
//
//  Created by user on 03/11/17.
//  Copyright © 2017 Arun's Technologies. All rights reserved.
//

import Foundation
public class FileDownloadController: NSObject, DownloadCompleted {
    let url:String
    let fileFormat:DownloadCompleted
    
    init(fileDownloadController: FileDownloadController) {
        self.fileDownloadController = fileDownloadController
    }
    
    func startDownload() {
    }
    
    func cancelDownload() {
    }
    
    public func fileDownloaded() -> String {
        fileFormat.fileDownloaded()
    }
}
