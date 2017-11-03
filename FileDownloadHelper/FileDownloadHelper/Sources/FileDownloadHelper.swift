//
//  FileDownloadHelper.swift
//  FileDownloadHelper
//
//  Created by user on 03/11/17.
//  Copyright © 2017 Arun's Technologies. All rights reserved.
//

import Foundation
import Foundation

public class FileDownloadHelper: NSObject {
    
    private override init() {    }
    // MARK: - Shared Instance
    static let sharedInstance = FileDownloadHelper()
    
    let fileDownloadController: FileDownloadController
    //    let configureAinterestHelper: ConfigureAinterestHelper
    
    init(fileDownloadController: FileDownloadController) {
        self.fileDownloadController = fileDownloadController
    }
    
    func handle() {
        let data = apiHandler.requestDataToAPI()
        let array = parseHandler.parse(data: data)
        dbHandler.saveToDB(array: array)
    }
}
