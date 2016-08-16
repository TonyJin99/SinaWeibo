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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
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

}


extension TJComposeViewController: UITextViewDelegate{
    
    func textViewDidChange(textView: UITextView) {
        sendItem.enabled = textView.hasText()
    }
}
