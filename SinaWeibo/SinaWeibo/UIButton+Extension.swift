//
//  UIButton+Extension.swift
//  SinaWeibo
//
//  Created by Tony.Jin on 7/23/16.
//  Copyright © 2016 Innovatis Tech. All rights reserved.
//

import UIKit

extension UIButton{
    convenience init(imageName: String, backgroundImageName: String){
        
        self.init()
        setImage(UIImage(named: "tabbar_compose_icon_add"), forState: UIControlState.Normal)
        setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted)
        
        setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: UIControlState.Normal)
        setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted)
        
        sizeToFit() //调整按钮尺寸

    }
}

