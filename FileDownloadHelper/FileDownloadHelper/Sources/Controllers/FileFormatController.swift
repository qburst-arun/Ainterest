//
//  FileFormatController.swift
//  AinterestHelper
//
//  Created by user on 03/11/17.
//  Copyright © 2017 Arun's Technologies. All rights reserved.
//

import Foundation

public protocol DownloadCompleted {
    func fileDownloaded() -> String
}

class Image: DownloadCompleted {
    let name: String
    let color: String
    
    init(name: String, color: String) {
        self.name = name
        self.color = color
    }
    
    func fileDownloaded() -> String {
        return "I'm \(name) and my color is \(color)"
    }
}

class PDF: DownloadCompleted {
    let type: String
    
    init(type: String) {
        self.type = type
    }
    
    func fileDownloaded() -> String {
        return "I'm a \(type)"
    }
}
