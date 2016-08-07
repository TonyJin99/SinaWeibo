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
        
        //print(NSHomeDirectory())
        QorumLogs.enabled = true
        
        UINavigationBar.appearance().tintColor = UIColor.orangeColor()
        UITabBar.appearance().tintColor = UIColor.orangeColor()
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor()

        window?.rootViewController = defaultViewController()
        window?.makeKeyAndVisible()
        isNewVersion()
        
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

       // print(TJUserAccount.loadUserAccount())
        return true
    }
}


extension AppDelegate{
    
    private func defaultViewController() -> UIViewController{
        
        if TJUserAccount.isLogin(){
            if isNewVersion() {
                let view = UIStoryboard(name: "TJNewFeature", bundle: nil).instantiateInitialViewController()!
                return view
            }
            else{
                let view = UIStoryboard(name: "Welcome", bundle: nil).instantiateInitialViewController()!
                return view
            }
        }
        
        return UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
    }
  
    private func isNewVersion() -> Bool{
       
        let currentVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
        let defaults = NSUserDefaults.standardUserDefaults()
        let sanboxVersion = (defaults.objectForKey("CFBundleShortVersionString") as? String) ?? "0.0"
 
        if currentVersion.compare(sanboxVersion) == NSComparisonResult.OrderedDescending{

            defaults.setObject(currentVersion, forKey: "CFBundleShortVersionString")
            defaults.synchronize() // iOS7以前需要写, iOS7以后不用写
            return true
        }
        NJLog("没有新版本")
        return false
    }
}

func NJLog<T>(message: T, fileName: String = #file, methodName: String = #function, lineNumber: Int = #line)
{
    #if DEBUG
        //    print("\((fileName as NSString).pathComponents.last!).\(methodName)[\(lineNumber)]:\(message)")
        print("\(methodName)[\(lineNumber)]:\(message)")
    #endif
}

