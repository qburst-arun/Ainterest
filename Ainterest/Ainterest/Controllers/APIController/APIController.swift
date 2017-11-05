//
//  APIController.swift
//  Ainterest
//
//  Created by user on 05/11/17.
//  Copyright © 2017 Arun's Technologies. All rights reserved.
//

import Foundation

public class APIController: NSObject {
    
    public func getPostsDetails(completion:@escaping (([PostDetails]?, Error?) -> ())){
        
        var postDetailsList:[PostDetails] = []
       
        APIServices.sharedInstance.getRequest(withUrl: URL(string: "https://pastebin.com/raw/wgkJgazE")!, completion:{data, error in
            do{
                let parsedData = try JSONSerialization.jsonObject(with: data!) as! [Any]
                for obj in parsedData{
                    var postDetail:PostDetails?
                    
                    let id:String = (obj as! [String : Any])["id"] as! String
                    let imageWidth:Int = (obj as! [String : Any])["width"] as! Int
                    let imageHeight:Int = (obj as! [String : Any])["height"] as! Int
                    let urlList = (obj as! [String : Any])["urls"] as! [String:String]
                    let imageUrl:URL = URL(string:urlList["full"]!)!
                    
                    postDetail = PostDetails(id: id, imageUrl: imageUrl, imageWidth: imageWidth, imageHeight: imageHeight)
                    postDetailsList.append(postDetail!)
                    
                }
                completion(postDetailsList, nil)
            } catch let error as NSError {
                print(error)
            }
        })
        
    }
    
}
