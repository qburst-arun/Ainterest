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
       
        APIServices.sharedInstance.getRequest(withUrl: URL(string:Constants.POST_API_URL)!, completion:{data, error in
            do{
                let parsedData = try JSONSerialization.jsonObject(with: data!) as! [Any]
                for obj in parsedData{
                    var postDetail:PostDetails?
                    
                    let id:String = (obj as! [String : Any])[Constants.API_FLAGS.ID] as! String
                    let imageWidth:Int = (obj as! [String : Any])[Constants.API_FLAGS.IMAGE_WIDTH] as! Int
                    let imageHeight:Int = (obj as! [String : Any])[Constants.API_FLAGS.IMAGE_HEIGHT] as! Int
                    let urlList = (obj as! [String : Any])[Constants.API_FLAGS.URLS] as! [String:String]
                    let imageUrl:URL = URL(string:urlList[Constants.API_FLAGS.FULL]!)!
                    
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
