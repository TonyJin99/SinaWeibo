//
//  TJNavigationController.swift
//  SinaWeibo
//
//  Created by Tony.Jin on 7/23/16.
//  Copyright © 2016 Innovatis Tech. All rights reserved.
//

import UIKit

class TJNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        
        if self.viewControllers.count > 0{
            viewController.hidesBottomBarWhenPushed = true
            let backBtn = UIButton(type: UIButtonType.Custom)
            backBtn.addTarget(self, action: #selector(self.back), forControlEvents: UIControlEvents.TouchUpInside)
            
            backBtn.setBackgroundImage(UIImage(named: "navigationbar_back"), forState: UIControlState.Normal)
            backBtn.setBackgroundImage(UIImage(named: "navigationbar_back_highlighted"), forState: UIControlState.Highlighted)
            let size = backBtn.currentBackgroundImage?.size
            backBtn.frame = CGRectMake(0, 0, (size?.width)!, (size?.height)!)
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
            
            let moreBtn = UIButton(type: UIButtonType.Custom)
            moreBtn.addTarget(self, action: #selector(self.more), forControlEvents: UIControlEvents.TouchUpInside)
            
            moreBtn.setBackgroundImage(UIImage(named: "navigationbar_more"), forState: UIControlState.Normal)
            moreBtn.setBackgroundImage(UIImage(named: "navigationbar_more_highlighted"), forState: UIControlState.Highlighted)
            let size_more = moreBtn.currentBackgroundImage?.size
            moreBtn.frame = CGRectMake(0, 0, (size_more?.width)!, (size_more?.height)!)
            viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: moreBtn)
        }
        super.pushViewController(viewController, animated: true)
        
    }
    
    
    func back(){
        self.popViewControllerAnimated(true)
    }
    
    func more(){
        self.popToRootViewControllerAnimated(true)
    }


}
