//
//  TJUser.swift
//  SinaWeibo
//
//  Created by Tony.Jin on 8/1/16.
//  Copyright © 2016 Innovatis Tech. All rights reserved.
//

import UIKit

class TJUser: NSObject {
    
    var idstr: String? //字符串型的用户UID
    var screen_name: String? //用户昵称
    var profile_image_url: String? //用户头像地址（中图），50×50像素
    //用户认证类型 -1：没有认证，0，认证用户，2,3,5: 企业认证，220: 达人
    var verified_type: Int = -1 //数据认证类型
    var mbrank: Int = -1 //会员等级， 1-6
    

    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    
    }
    
    override var description: String {
        let property = ["idstr", "screen_name", "profile_image_url", "verified_type", "mbrank"]
        let dict = dictionaryWithValuesForKeys(property)
        return "\(dict)"
    }
    


}
