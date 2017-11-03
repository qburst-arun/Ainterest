//
//  FileFormatController.swift
//  AinterestHelper
//
//  Created by user on 03/11/17.
//  Copyright © 2017 Arun's Technologies. All rights reserved.
//

import Foundation

public enum SupportedFileFormats:String {
    case image    = "Image"
    case pdf      = "PDF"
}

public protocol DownloadCompleted {
    func fileDownloaded() -> AnyObject
}

public class Image: DownloadCompleted {
    let name: String
    let color: String
    
    init(name: String, color: String) {
        self.name = name
        self.color = color
    }
    
   public func fileDownloaded() -> AnyObject {
        return "I'm \(name) and my color is \(color)" as AnyObject
    }
}

public class PDF: DownloadCompleted {
    let type: String
    
    init(type: String) {
        self.type = type
    }
    
   public func fileDownloaded() -> AnyObject {
        return "I'm a \(type)" as AnyObject
    }
}
