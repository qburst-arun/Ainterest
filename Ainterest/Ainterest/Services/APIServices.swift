//
//  APIServices.swift
//  Ainterest
//
//  Created by user on 05/11/17.
//  Copyright © 2017 Arun's Technologies. All rights reserved.
//

import Foundation

public class APIServices: NSObject {
    public static let sharedInstance = APIServices()
    
    public func getRequest(withUrl:URL, completion:@escaping ((Data?, Error?) -> ())){
        var request = URLRequest(url: URL(string: "https://pastebin.com/raw/wgkJgazE")!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        session.dataTask(with: request) {data, response, error in
            
        completion(data, error)
        
    }.resume()
        
    }
    
}
