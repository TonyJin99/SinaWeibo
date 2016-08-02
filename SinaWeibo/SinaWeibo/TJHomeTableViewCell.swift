//
//  TJHomeTableViewCell.swift
//  SinaWeibo
//
//  Created by Tony.Jin on 8/1/16.
//  Copyright © 2016 Innovatis Tech. All rights reserved.
//

import UIKit
import SDWebImage

class TJHomeTableViewCell: UITableViewCell {

    @IBOutlet weak var verifiedImageView: UIImageView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var vipImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    var status: TJStatus?{
        didSet{
            if let urlStr = status?.user?.profile_image_url{
                let url = NSURL(string: urlStr)
                iconImageView.layer.cornerRadius = iconImageView.frame.size.width / 2
                iconImageView.layer.masksToBounds = true
                iconImageView.sd_setImageWithURL(url)
            }
            
            if let type = status?.user?.verified_type{
                var name = ""
                switch type{
                case 0:
                    name = "avatar_vip"
                case 2, 3, 5:
                    name = "avatar_enterprise_vip"
                case 220:
                    name = "avatar_grassroot"
                default:
                    name = ""
                }
                verifiedImageView.image = UIImage(named: name)

            }
            
            nameLabel.text = status?.user?.screen_name
            
            if let rank = status?.user?.mbrank{
                if rank >= 1 && rank <= 6 {
                    
                    vipImageView.image = UIImage(named: "common_icon_membership_level\(rank)")
                    nameLabel.textColor = UIColor.orangeColor()
                }else{
                    vipImageView.image = nil
                    nameLabel.textColor = UIColor.blackColor()
                }
            }
            
            //"Tue Aug 02 22:50:31 +0800 2016"
            if let timeString = status?.created_at{
                var formatterString = "HH:mm"
                //将服务器返回的时间转换成NSDate
                let formatter = NSDateFormatter()
                formatter.dateFormat = "EE MM dd HH:mm:ss Z yyyy"
                formatter.locale = NSLocale(localeIdentifier: "en") //如果不写，真机中可能无法转换
                let createDate = formatter.dateFromString(timeString)!

                let calendar = NSCalendar.currentCalendar()
                /*
                let components = calendar.components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day], fromDate: createDate)
                print(components.year)
                print(components.month)
                print(components.day)
                */
                
                if calendar.isDateInToday(createDate) {
                    //比较两个时间的差值
                    let interval = Int(NSDate().timeIntervalSinceDate(createDate))
                    
                    if interval < 60{
                        timeLabel.text = "刚刚"
                    }else if interval < 60 * 60{
                        timeLabel.text = "\(interval / 60)分钟前"
                    }else if interval < 60 * 60 * 24{
                        timeLabel.text = "\(interval / 3600)小时前"
                    }
                }else if calendar.isDateInYesterday(createDate) {
                    formatterString = "昨天" + formatterString
                    formatter.dateFormat = formatterString
                    timeLabel.text = formatter.stringFromDate(createDate)
                }else {
                    let components = calendar.components(NSCalendarUnit.Year, fromDate: createDate, toDate: NSDate(), options: NSCalendarOptions(rawValue: 0))
                    if components.year >= 1 {
                        formatterString = "yyyy-MM-dd" + formatterString
                        formatter.dateFormat = formatterString
                        timeLabel.text = formatter.stringFromDate(createDate)
                    }else {
                        formatterString = "MM-dd" + formatterString
                        formatter.dateFormat = formatterString
                        timeLabel.text = formatter.stringFromDate(createDate)
                    }
                }
  
            }
            
            if let sourceStr: NSString = status?.source where sourceStr != ""{
                let startIndex = sourceStr.rangeOfString(">").location + 1
                let length = sourceStr.rangeOfString("</").location - startIndex
                
                let rest = sourceStr.substringWithRange(NSMakeRange(startIndex, length))
                sourceLabel.text = "来自: " + rest
            }
            
            contentLabel.text = status?.text
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentLabel.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 2 * 10
        
    }


}
