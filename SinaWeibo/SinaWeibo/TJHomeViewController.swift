//
//  TJHomeViewController.swift
//  SinaWeibo
//
//  Created by Tony.Jin on 7/23/16.
//  Copyright © 2016 Innovatis Tech. All rights reserved.
//

import UIKit
import QorumLogs
 
class TJHomeViewController: TJBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !islogin{
            vistorView?.setupVistorInfo(nil, title: "关注一些人，回这里看看有什么惊喜")
            return
        }
    
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendsearch", target: self, action: #selector(self.buttonActionLeftBtn))
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop", target: self, action: #selector(self.buttonActionRightBtn))
        
        let titleButton = TitleButton()
        titleButton.setTitle("Tony ", forState: UIControlState.Normal)
        titleButton.setImage(UIImage(named: "navigationbar_arrow_down"), forState: UIControlState.Normal)
        titleButton.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        titleButton.sizeToFit()
        navigationItem.titleView = titleButton
        
    }
    
    func buttonActionLeftBtn(){
        
    }
    
    func buttonActionRightBtn(){
        
    }
}
