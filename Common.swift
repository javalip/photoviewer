//
//  Common.swift
//  MyPhotoViewer
//
//  Created by Preeti  on 3/21/16.
//  Copyright © 2016 Preeti . All rights reserved.
//

import Foundation
import Alamofire

class User {
    static var username = "" as String
    class func getUserName() -> String {
        return username
    }
    class func setUserName(uname: String) {
        username = uname
    }
}

class Media
{
    private class func getUserMedia(request: String, completionHandler:(NSDictionary?,NSError?)->Void)
    
    {
        Alamofire.request(.GET, request)
            .responseJSON{ response in
                if let error = response.result.error
                {
                    completionHandler(nil,error)
                }
                else
                {
                    completionHandler(response.result.value! as? NSDictionary, nil)
                }
                
        }
        
    }
    class func getMedia(completionHandler: (NSDictionary?,NSError?)->	Void)
    {
        let access_token = "2976894754.fc8b61d.27d63d5903304477a4467b5a2ff99d81"
        
        //One way to request data using Alamofire
        let request = "https://api.instagram.com/v1/users/self/media/recent?access_token=\(access_token)"
        
        getUserMedia(request, completionHandler: completionHandler)
        
    }
}