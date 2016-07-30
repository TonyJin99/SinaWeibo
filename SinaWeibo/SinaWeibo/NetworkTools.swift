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
        
        instance.responseSerializer.acceptableContentTypes = (NSSet(object: "text/plain") as! Set)
        return instance
    }()
}
