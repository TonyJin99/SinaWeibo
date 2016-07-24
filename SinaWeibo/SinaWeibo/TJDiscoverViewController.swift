//
//  TJDiscoverViewController.swift
//  SinaWeibo
//
//  Created by Tony.Jin on 7/23/16.
//  Copyright © 2016 Innovatis Tech. All rights reserved.
//

import UIKit

class TJDiscoverViewController: TJBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !islogin{
            vistorView?.setupVistorInfo("visitordiscover_image_message", title: "登录后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过")
            return
        }

    }


}
