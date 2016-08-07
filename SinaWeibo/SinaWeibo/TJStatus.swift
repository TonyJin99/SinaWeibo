//
//  TJStatus.swift
//  SinaWeibo
//
//  Created by Tony.Jin on 8/1/16.
//  Copyright © 2016 Innovatis Tech. All rights reserved.
//

import UIKit

class TJStatus: NSObject{
    

    var created_at: String? //微博创建时间
    var idstr: String? //字符串型的微博ID
    var text: String? //微博信息内容
    var source: String? //微博来源
    var user: TJUser? //微博作者的用户信息
    var pic_urls: [[String: AnyObject]]? //配图数组
    var retweeted_status : TJStatus? //转发微博
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    //KVC的setValuesForKeysWithDictionary方法内部会调用setValue方法
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "user"{
            user = TJUser(dict: value as! [String : AnyObject])
            return
        }
        
        if key == "retweeted_status"{
            retweeted_status = TJStatus(dict: value as! [String : AnyObject])
            return
        }
        super.setValue(value, forKey: key)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    override var description: String {
        let property = ["created_at", "idstr", "text", "source"]
        let dict = dictionaryWithValuesForKeys(property)
        return "\(dict)"
    }

}
