//
//  NSDate+Extension.swift
//  SinaWeibo
//
//  Created by Tony.Jin on 8/5/16.
//  Copyright © 2016 Innovatis Tech. All rights reserved.
//

import UIKit

extension NSDate{
    
    class func createDate(timeStr: String, formatterStr: String) ->NSDate{
        let formatter = NSDateFormatter()
        formatter.dateFormat = formatterStr
        formatter.locale = NSLocale(localeIdentifier: "en") //如果不写，真机中可能无法转换
        return formatter.dateFromString(timeStr)!

    }
    
    func descriptionStr() -> String {
        //"Tue Aug 02 22:50:31 +0800 2016"
        //1 创建时间格式化对象
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "en")
        
        //2 创建一个日历类
        let calendar = NSCalendar.currentCalendar()
        
        //3定义变量记录时间格式
        var formatterString = "HH:mm"
        
        //4 判断是否是今天
        if calendar.isDateInToday(self) {
            //比较两个时间的差值
            let interval = Int(NSDate().timeIntervalSinceDate(self))
            
            if interval < 60{
                return "刚刚"
            }else if interval < 60 * 60{
                return "\(interval / 60)分钟前"
            }else if interval < 60 * 60 * 24{
                return "\(interval / 3600)小时前"
            }
        }else if calendar.isDateInYesterday(self) {
            formatterString = "昨天" + formatterString
        }else {
            let components = calendar.components(NSCalendarUnit.Year, fromDate: self, toDate: NSDate(), options: NSCalendarOptions(rawValue: 0))
            if components.year >= 1 {
                formatterString = "yyyy-MM-dd" + formatterString
            }else {
                formatterString = "MM-dd" + formatterString
            }
        }
        formatter.dateFormat = formatterString
        return formatter.stringFromDate(self)
    }
    
    
}