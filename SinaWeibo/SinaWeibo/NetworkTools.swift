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
    
    func loadStatus(finished: (Array:[[String: AnyObject]]?, error: NSError?)->()){
        
        let url = "https://api.weibo.com/2/statuses/home_timeline.json"
        let paras = ["access_token": "2.00pFZdLC25bUWE6b1e1f2b940lv3Oc"]
        GET(url, parameters: paras, progress: { (prpgress) in
            print(prpgress)
            }, success: { (task, object) in
                //print(object!)
                guard let array = (object as! [String: AnyObject])["statuses"] as? [[String: AnyObject]] else{
                    finished(Array: nil, error: NSError(domain: "https://www.facebook.com", code: 404, userInfo: ["Message": "没有获取到数据"]))
                    return
                }
                finished(Array: array, error: nil)
                
            }) { (task, error) in
                finished(Array: nil, error: error)
        }
    }
}
