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
    var avatar_large: String? //用户头像
    var screen_name: String? //用户昵称
    
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
//        print("过期时间：\(account.expires_date)")
//        print(NSDate())
        guard let date = account.expires_date where date.compare(NSDate()) != NSComparisonResult.OrderedAscending  else
        {
            print("过期了")
            return nil
        }

        TJUserAccount.account = account
        return TJUserAccount.account
    }
    
    func loadUserInfo(finished: (account: TJUserAccount?, error: NSError?)->()){
        assert(access_token != nil, "先授权")
        let path = "2/users/show.json"
        let paras = ["access_token": access_token!, "uid": uid!]
        NetworkTools.sharedInstance.GET(path, parameters: paras, progress: { (progress: NSProgress) in
            print(progress)
            }, success: { (datatask: NSURLSessionDataTask, objc: AnyObject?) in
                let dict = objc as! [String: AnyObject]
                self.screen_name = dict["screen_name"] as? String
                self.avatar_large = dict["avatar_large"] as? String
                //self.saveAccount()
                finished(account: self, error: nil)
        }) { (datatask: NSURLSessionDataTask?, error: NSError) in
                print(error)
            finished(account: nil, error: error)
            
        }
        
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
        aCoder.encodeObject(screen_name, forKey: "screen_name")
        aCoder.encodeObject(avatar_large, forKey: "avatar_large")
    }
    
    required init?(coder aDecoder: NSCoder){
        self.access_token = aDecoder.decodeObjectForKey("access_token") as? String
        self.expires_in = aDecoder.decodeIntegerForKey("expires_in") as Int
        self.uid = aDecoder.decodeObjectForKey("uid") as? String
        self.expires_date = aDecoder.decodeObjectForKey("expires_date") as? NSDate
        self.screen_name = aDecoder.decodeObjectForKey("screen_name") as? String
        self.avatar_large = aDecoder.decodeObjectForKey("avatar_large") as? String
    }

}
















