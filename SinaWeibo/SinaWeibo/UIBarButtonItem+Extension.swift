//
//  UIBarButtonItem+Extension.swift
//  SinaWeibo
//
//  Created by Tony.Jin on 7/24/16.
//  Copyright © 2016 Innovatis Tech. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    
    convenience init(imageName: String, target: AnyObject?, action: Selector) {
        
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), forState: UIControlState.Highlighted)
        btn.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        self.init(customView: btn)
        
    }
}
