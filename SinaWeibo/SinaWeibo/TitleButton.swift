//
//  TitleButton.swift
//  SinaWeibo
//
//  Created by Tony.Jin on 7/25/16.
//  Copyright © 2016 Innovatis Tech. All rights reserved.
//

import UIKit

class TitleButton: UIButton {
    
//    override func titleRectForContentRect(contentRect: CGRect) -> CGRect {
//        return CGRectZero
//    }
    
//    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
//        return CGRectZero
//    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel?.frame.origin.x = 0
        imageView?.frame.origin.x = titleLabel!.frame.width
    }

}
