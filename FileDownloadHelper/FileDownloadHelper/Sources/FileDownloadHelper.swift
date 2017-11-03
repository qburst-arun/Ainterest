//
//  FileDownloadHelper.swift
//  FileDownloadHelper
//
//  Created by user on 03/11/17.
//  Copyright © 2017 Arun's Technologies. All rights reserved.
//

import Foundation
public typealias ProgressClosure = (Float) -> ()
public typealias CompletionClosure = (DefaultDownloadResponse) -> ()
public class FileDownloadHelper: NSObject {
    
    private override init() {    }
    // MARK: - Shared Instance
    public static let sharedInstance = FileDownloadHelper()
    
//    init(fileDownloadController: FileDownloadController) {
//        self.fileDownloadController = fileDownloadController
//    }
    
    public func startDownload(FromURL url:URL, withProgress progress:@escaping ProgressClosure, withCompleteion completion:@escaping CompletionClosure) {
        DownloadTaskController().startDownload(FromURL: url, withProgress:progress, withCompleteion: completion)
    }
    
    public func cancelDownload(FromURL url:URL) {
        DownloadTaskController().cancelDownload(FromURL: url)
    }
    
    
}
