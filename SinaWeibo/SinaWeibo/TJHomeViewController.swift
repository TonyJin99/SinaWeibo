//
//  TJHomeViewController.swift
//  SinaWeibo
//
//  Created by Tony.Jin on 7/23/16.
//  Copyright © 2016 Innovatis Tech. All rights reserved.
//

import UIKit

class TJHomeViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let friendBtn = UIButton(type: UIButtonType.Custom)
        friendBtn.addTarget(self, action: #selector(self.friendSearch), forControlEvents: UIControlEvents.TouchUpInside)
        
        friendBtn.setBackgroundImage(UIImage(named: "navigationbar_friendsearch"), forState: UIControlState.Normal)
        friendBtn.setBackgroundImage(UIImage(named: "navigationbar_friendsearch_highlighted"), forState: UIControlState.Highlighted)
        let size = friendBtn.currentBackgroundImage?.size
        friendBtn.frame = CGRectMake(0, 0, (size?.width)!, (size?.height)!)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: friendBtn)
        
        let popBtn = UIButton(type: UIButtonType.Custom)
        popBtn.addTarget(self, action: #selector(self.pop), forControlEvents: UIControlEvents.TouchUpInside)
        
        popBtn.setBackgroundImage(UIImage(named: "navigationbar_pop"), forState: UIControlState.Normal)
        popBtn.setBackgroundImage(UIImage(named: "navigationbar_pop_highlighted"), forState: UIControlState.Highlighted)
        let sizepop = popBtn.currentBackgroundImage?.size
        popBtn.frame = CGRectMake(0, 0, (sizepop?.width)!, (sizepop?.height)!)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: popBtn)

       }
    
    func friendSearch(){
        
    }
    
    func pop(){
        
    }



}
