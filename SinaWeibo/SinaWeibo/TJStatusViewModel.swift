//
//  TJStatusViewModel.swift
//  SinaWeibo
//
//  Created by Tony.Jin on 8/4/16.
//  Copyright © 2016 Innovatis Tech. All rights reserved.
//

import UIKit

class TJStatusViewModel: NSObject {
    
    var verified_image: UIImage? //用户认证图片
    var mbrankImage: UIImage? //会员图片
    var icon_Url: NSURL? //用户头像url地址
    var created_Time: String = ""
    var source_Text: String = ""
    var thumbnail_pic: [NSURL]? //保存所有配图URL
    var forwardText: String? //转发微博的正文
    
    var status: TJStatus
    
    init(status: TJStatus) {
        self.status = status
        
        icon_Url = NSURL(string: status.user?.profile_image_url ?? "")
        
        if status.user?.mbrank >= 1 && status.user?.mbrank <= 6 {
            mbrankImage = UIImage(named: "common_icon_membership_level\(status.user!.mbrank)")
        }
        
        switch status.user?.verified_type ?? -1{
        case 0:
            verified_image = UIImage(named:  "avatar_vip")
        case 2, 3, 5:
            verified_image = UIImage(named: "avatar_enterprise_vip")
        case 220:
            verified_image = UIImage(named: "avatar_grassroot")
        default:
            verified_image = nil
        }
        
        if let sourceStr: NSString = status.source where sourceStr != ""{
            let startIndex = sourceStr.rangeOfString(">").location + 1
            let length = sourceStr.rangeOfString("</").location - startIndex
            
            let rest = sourceStr.substringWithRange(NSMakeRange(startIndex, length))
            source_Text = "来自: " + rest
        }
        
        if let timeString = status.created_at where timeString != ""{
            //将服务器返回的时间转换成NSDate
            let createDate = NSDate.createDate(timeString, formatterStr: "EE MM dd HH:mm:ss Z yyyy")
            created_Time = createDate.descriptionStr()
        }

        //处理配图URL
        if let picurls = (status.retweeted_status != nil) ? status.retweeted_status?.pic_urls : status.pic_urls
        {
            thumbnail_pic = [NSURL]()
            for dict in picurls{
                guard let urlStr = dict["thumbnail_pic"] as? String else{
                    continue
                }
                let url = NSURL(string: urlStr)
                thumbnail_pic?.append(url!)
  
            }
        }
        
        //处理转发
        if let text = status.retweeted_status?.text{
            let name = status.retweeted_status?.user?.screen_name ?? ""
            forwardText = "@" + name + ":" + text
        }
        
    }
}











