//
//  TJComposeViewController.swift
//  SinaWeibo
//
//  Created by Tony.Jin on 8/16/16.
//  Copyright © 2016 Innovatis Tech. All rights reserved.
//

import UIKit
import SVProgressHUD

class TJComposeViewController: UIViewController {

    @IBOutlet weak var sendItem: UIBarButtonItem!
    @IBOutlet weak var customTextView: TJTextView!
    @IBOutlet weak var toolbarbottom: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(UIKeyboardWillChangeFrame), name: UIKeyboardWillChangeFrameNotification, object: nil)

    }
    
    func UIKeyboardWillChangeFrame(notice: NSNotification){
        //获取键盘的frame
        let rect = notice.userInfo![UIKeyboardFrameEndUserInfoKey]?.CGRectValue
        let height = UIScreen.mainScreen().bounds.height
        
        let offSetY = height - rect!.origin.y
        
        // 4.修改底部工具条约束
        toolbarbottom.constant = offSetY
        UIView.animateWithDuration(0.25) { () -> Void in
            self.view.layoutIfNeeded()
        }

    }
    
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        customTextView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        customTextView.resignFirstResponder()
    }
    
    

    @IBAction func itemActionClose(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }


    @IBAction func itemActionSend(sender: AnyObject) {
        
        let sendText = customTextView.text
        NetworkTools.sharedInstance.sendStatus(sendText) { (objc, error) in
            if error != nil{
                SVProgressHUD.showErrorWithStatus("发送微博失败...")
                SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.Black)
                return
            }
            
            SVProgressHUD.showSuccessWithStatus("发送微博成功")
            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.Black)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }

    
    @IBAction func itemActionEmotion(sender: AnyObject) {
        // 注意点: 要想切换切换, 必须先关闭键盘, 切换之后再打开
        customTextView.resignFirstResponder()
        
        if customTextView.inputView != nil{
            customTextView.inputView = nil
        }else{
            customTextView.inputView = UISwitch()
        }
        
        customTextView.becomeFirstResponder()

        
    }
    
}




extension TJComposeViewController: UITextViewDelegate{
    
    func textViewDidChange(textView: UITextView) {
        sendItem.enabled = textView.hasText()
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        customTextView.resignFirstResponder()
    }
}
