//
//  TJUserAccount.swift
//  SinaWeibo
//
//  Created by Tony.Jin on 7/30/16.
//  Copyright © 2016 Innovatis Tech. All rights reserved.
//

import UIKit

class TJUserAccount: NSObject, NSCoding{
    var access_token: String?
    var expires_in: Int = 0{
        didSet{
            expires_date = NSDate(timeIntervalSinceNow: NSTimeInterval(expires_in))
        }
    }
    var expires_date: NSDate?
    var uid: String?
    
    init(dict: [String: AnyObject]) {
        //字典的keyvalue必须和模型一一对应
        super.init()
        self.setValuesForKeysWithDictionary(dict)
    }
    
    // 当KVC发现没有对应的key时就会调用
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    override var description: String{
        let property = ["access_token", "expires_in", "uid", "expires_date"]
        let dict = dictionaryWithValuesForKeys(property)
        return "\(dict)"
    }
    
    // MARK: - 外部控制方法
    // 归档模型
    func saveAccount() -> Bool{
        // 1.获取缓存目录的路径
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!
        // 2.生成缓存路径
        let filePath = (path as NSString).stringByAppendingPathComponent("useraccount.plist")
        print(filePath)
        // 3.归档对象
        return NSKeyedArchiver.archiveRootObject(self, toFile: filePath)
    }
    
    /// 定义属性保存授权模型
    static var account: TJUserAccount?
    
    // 解归档模型
    class func loadUserAccount() -> TJUserAccount?{
        print("1")
        // 1.判断是否已经加载过了
        if TJUserAccount.account != nil{
            NJLog("已经有加载过")
            return TJUserAccount.account
        }
        
        // 2.尝试从文件中加载
        NJLog("还没有加载过")
        // 1.获取缓存目录的路径
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!
        // 2.生成缓存路径
        let filePath = (path as NSString).stringByAppendingPathComponent("useraccount.plist")
        // 3.解归档对象
        guard let account = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as? TJUserAccount else{
            return TJUserAccount.account
        }
        
        //3检验是否过期
//        guard let date = account.expires_date else{
//            return nil
//        }
//        print("过期时间：\(account.expires_date)")
//        print(NSDate())
//
//        if date.compare(NSDate()) == NSComparisonResult.OrderedAscending{
//            print("过期了")
//            return nil
//        }
        guard let date = account.expires_date where date.compare(NSDate()) != NSComparisonResult.OrderedAscending  else
        {
            print("过期了")
            return nil
        }

        
        TJUserAccount.account = account
        return TJUserAccount.account
    }
    
 
    class func isLogin() -> Bool {
        return TJUserAccount.loadUserAccount() != nil
    }

    
    //MARK: ---NSCoding---
    func encodeWithCoder(aCoder: NSCoder){
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeInteger(expires_in, forKey: "expires_in")
        aCoder.encodeObject(uid, forKey: "uid")
        aCoder.encodeObject(expires_date, forKey: "expires_date")
    }
    
    required init?(coder aDecoder: NSCoder){
        self.access_token = aDecoder.decodeObjectForKey("access_token") as? String
        self.expires_in = aDecoder.decodeIntegerForKey("expires_in") as Int
        self.uid = aDecoder.decodeObjectForKey("uid") as? String
        self.expires_date = aDecoder.decodeObjectForKey("expires_date") as? NSDate
    }

}
















