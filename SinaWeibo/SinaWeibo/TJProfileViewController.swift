//
//  TJProfileViewController.swift
//  SinaWeibo
//
//  Created by Tony.Jin on 7/23/16.
//  Copyright © 2016 Innovatis Tech. All rights reserved.
//

import UIKit

class TJProfileViewController: TJBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if !islogin{
            vistorView?.setupVistorInfo("visitordiscover_image_profile", title: "登录后，你的微博、相册、个人资料会显示在这里，展示给别人")
            return
        }
    }


}
