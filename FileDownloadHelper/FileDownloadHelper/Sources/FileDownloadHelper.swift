//
//  FileDownloadHelper.swift
//  FileDownloadHelper
//
//  Created by user on 03/11/17.
//  Copyright © 2017 Arun's Technologies. All rights reserved.
//

import Foundation
public typealias ProgressClosure = (Float) -> ()
public class FileDownloadHelper: NSObject, DownloadCompleted {
    
    private override init() {    }
    // MARK: - Shared Instance
    public static let sharedInstance = FileDownloadHelper()
    
//    init(fileDownloadController: FileDownloadController) {
//        self.fileDownloadController = fileDownloadController
//    }
    
    public func startDownload(FromURL url:URL, ofType fileType:SupportedFormats, withProgress progress:@escaping ProgressClosure) {
        DownloadTaskController().download(FromURL: url, withProgress:progress)
    }
    
    public func cancelDownload(FromURL url:String) {
    }
    
    public func fileDownloaded() -> AnyObject {
//        fileFormat.fileDownloaded()
        return "asd" as AnyObject
    }
}
