//
//  AppDelegate.swift
//  SinaWeibo
//
//  Created by Tony.Jin on 7/23/16.
//  Copyright © 2016 Innovatis Tech. All rights reserved.
//

import UIKit
import QorumLogs

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        QorumLogs.enabled = true
        
        UINavigationBar.appearance().tintColor = UIColor.orangeColor()
        
        /*
         // 1.开启自定义LOG
         QorumLogs.enabled = true
         // 设置打印的最低级别
         //        QorumLogs.minimumLogLevelShown = 4
         // 指定那一个类可以打印LOG
         //        QorumLogs.onlyShowThisFile(ViewController)
         
         // 测试自定义LOG
         //        QorumLogs.test()
         
         // 2.打印LOG
         QL1("1")
         QL2("2")
         QL3("3")
         QL4("4")
         
         // 3.打印分割线
         QLPlusLine()
         QLShortLine()
         */

        NJLog("abc")
        return true
    }
}

func NJLog<T>(message: T, fileName: String = #file, methodName: String = #function, lineNumber: Int = #line)
{
    #if DEBUG
        //    print("\((fileName as NSString).pathComponents.last!).\(methodName)[\(lineNumber)]:\(message)")
        print("\(methodName)[\(lineNumber)]:\(message)")
    #endif
}

