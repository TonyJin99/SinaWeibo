//
//  TJOAuthViewController.swift
//  SinaWeibo
//
//  Created by Tony.Jin on 7/29/16.
//  Copyright © 2016 Innovatis Tech. All rights reserved.
//

import UIKit
import SVProgressHUD

class TJOAuthViewController: UIViewController {

    @IBOutlet weak var customWebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let urlStr = "https://api.weibo.com/oauth2/authorize?client_id=4144667657&redirect_uri=https://www.facebook.com"
        guard let url = NSURL(string: urlStr) else{
            return
        }
        
        let request = NSURLRequest(URL: url)
        customWebView.loadRequest(request)
    }

}

extension TJOAuthViewController: UIWebViewDelegate{
    
    func webViewDidStartLoad(webView: UIWebView) {
        SVProgressHUD.showInfoWithStatus("正在加载中...")
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.Black)
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    
    
    //该方法每次请求都会调用， 返回false表示不允许请求， 返回true代表允许请求
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool{
        //print(request)
        // 1.判断当前是否是授权回调页面
        guard let urlStr = request.URL?.absoluteString else{
            return false
        }
        
        if !urlStr.hasPrefix("https://www.facebook.com"){
            //print("不是回调页")
            return true
        }
        
        // 2.判断授权回调地址中是否包含code=， URL的query属性是专门用于获取URL中的参数的, 可以获取URL中?后面的所有内容
        //print("是回调页")
        let key = "code="
        if urlStr.containsString(key){
            //print("授权成功")
            let code = request.URL?.query!.substringFromIndex(key.endIndex)
            loadAccess(code)
        }

        return false
    }
    
    private func loadAccess(codeStr: String?){
        guard let code = codeStr else{
            return
        }
        
        let path = "oauth2/access_token"
        let paras = ["client_id": "4144667657", "client_secret": "7b5df42ed74d007d3a70d89f6c4a8789", "grant_type": "authorization_code", "code": code, "redirect_uri": "https://www.facebook.com"]
        NetworkTools.sharedInstance.POST(path, parameters: paras, progress: { (progress: NSProgress) in
            print(progress)
            }, success: { (task: NSURLSessionDataTask, dict: AnyObject?) in

                let account = TJUserAccount(dict: dict as! [String: AnyObject])
                account.loadUserInfo({ (account, error) in
                    account?.saveAccount()
                    let view = UIStoryboard(name: "Welcome", bundle: nil).instantiateInitialViewController()
                    UIApplication.sharedApplication().keyWindow?.rootViewController = view
                })
                
        }) { (task: NSURLSessionDataTask?, error: NSError) in
                print(error)
        }
        
        
    }
}












