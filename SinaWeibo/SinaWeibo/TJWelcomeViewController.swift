//
//  TJWelcomeViewController.swift
//  SinaWeibo
//
//  Created by Tony.Jin on 7/30/16.
//  Copyright © 2016 Innovatis Tech. All rights reserved.
//

import UIKit
import SDWebImage

class TJWelcomeViewController: UIViewController {

    @IBOutlet weak var buttomCons: NSLayoutConstraint!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        buttomCons.constant = (UIScreen.mainScreen().bounds.height - buttomCons.constant)
        
        iconImage.layer.cornerRadius = self.iconImage.frame.size.height / 2
        iconImage.layer.masksToBounds = true
        
        guard let url = NSURL(string: TJUserAccount.loadUserAccount()!.avatar_large!) else{
            return
        }
        iconImage.sd_setImageWithURL(url)
        
        UIView.animateWithDuration(2.0, animations: { () -> Void in
            self.view.layoutIfNeeded()
        }) { (_) -> Void in
            
            UIView.animateWithDuration(2.0, animations: { () -> Void in
                self.textLabel.alpha = 1.0
                }, completion: { (_) -> Void in
                    let view = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                    UIApplication.sharedApplication().keyWindow?.rootViewController = view
            })
        }

        
    }

}
