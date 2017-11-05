//
//  PostDetails.swift
//  Ainterest
//
//  Created by user on 05/11/17.
//  Copyright © 2017 Arun's Technologies. All rights reserved.
//

import Foundation
public class PostDetails:NSObject{
    
    public var id:String?
    public var imageUrl:URL?
    public var imageWidth:Int?
    public var imageHeight:Int?
    
    init(id:String, imageUrl:URL, imageWidth:Int, imageHeight:Int){
        self.id = id
        self.imageUrl = imageUrl
        self.imageWidth = imageWidth
        self.imageHeight = imageHeight
    }
}
