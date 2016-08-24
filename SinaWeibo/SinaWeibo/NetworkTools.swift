//
//  NetworkTools.swift
//  SinaWeibo
//
//  Created by Tony.Jin on 7/30/16.
//  Copyright © 2016 Innovatis Tech. All rights reserved.
//

import UIKit
import AFNetworking

class NetworkTools: AFHTTPSessionManager {

    static let sharedInstance: NetworkTools = {
        let baseURL = NSURL(string: "https://api.weibo.com/")!
        let instance = NetworkTools(baseURL: baseURL, sessionConfiguration: NSURLSessionConfiguration.defaultSessionConfiguration())
        instance.responseSerializer.acceptableContentTypes = (NSSet(objects: "application/json", "text/json", "text/javascript", "text/plain") as! Set)
        
        return instance
    }()
    
    
    func loadStatus(since_id: String, max_id: String, finished: (Array:[[String: AnyObject]]?, error: NSError?)->()){
        
        let url = "https://api.weibo.com/2/statuses/home_timeline.json"
        let temp = (max_id != "0") ? "\(Int(max_id)! - 1)" : max_id
        let paras = ["access_token": "2.00pFZdLC25bUWE6b1e1f2b940lv3Oc", "since_id": since_id, "max_id": temp]
        
        GET(url, parameters: paras, progress: { (progress) in
            //print(progress)
            },
            success: { (task, object) in
                //print(object)
                guard let array = (object as! [String: AnyObject])["statuses"] as? [[String: AnyObject]] else{
                    finished(Array: nil, error: NSError(domain: "https://www.facebook.com", code: 404, userInfo: ["Message": "没有获取到数据"]))
                    return
                }
                finished(Array: array, error: nil)
                
            }) { (task, error) in
                finished(Array: nil, error: error)
        }
    }
    
    
    func sendStatus(status: String, finished: (objc: AnyObject?, error: NSError?)->()){
        
        let url = "https://api.weibo.com/2/statuses/update.json"
        let paras = ["access_token": "2.00pFZdLC25bUWE6b1e1f2b940lv3Oc", "status": status]
        POST(url, parameters: paras, progress: { (progress) in
            //print(progress)
            }, success: { (task, object) in
                finished(objc: object, error: nil)
            }) { (task, error) in
                finished(objc: nil, error: error)
        }
        
    }
  
}

