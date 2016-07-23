//
//  TJMainViewController.swift
//  SinaWeibo
//
//  Created by Tony.Jin on 7/23/16.
//  Copyright © 2016 Innovatis Tech. All rights reserved.
//

import UIKit

class TJMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.addSubview(composeButton)
        
        //3 设置子控制器
        let homeVc = TJHomeViewController()
        self.addChildVC(homeVc, title: "Home", image: "tabbar_home", selectedImage: "tabbar_home_selected")
        
        let messageVc = TJMessageViewController()
        self.addChildVC(messageVc, title: "Message", image: "tabbar_message_center", selectedImage: "tabbar_message_center_selected")
        
        let addVc = TJAddViewController()
        self.addChildVC(addVc, title: " ", image: " ", selectedImage: " ")
        
        let discoverVc = TJDiscoverViewController()
        self.addChildVC(discoverVc, title: "Discover", image: "tabbar_discover", selectedImage: "tabbar_discover_selected")
        
        let profileVc = TJProfileViewController()
        self.addChildVC(profileVc, title: "Me", image: "tabbar_profile", selectedImage: "tabbar_profile_selected")
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)

        let rect = composeButton.frame.size
        let width = tabBar.bounds.width / CGFloat(childViewControllers.count)

        composeButton.frame = CGRect(x: 2 * width, y: 0, width: width, height: rect.height)
    }
    
    func addChildVC(chileVc: UIViewController, title: String, image: String, selectedImage: String){
        //        chileVc.tabBarItem.title = title
        //        chileVc.navigationItem.title = title
        chileVc.title = title
        chileVc.tabBarItem.image = UIImage(named: image)
        chileVc.tabBarItem.selectedImage = UIImage(named: selectedImage)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        let navigation = TJNavigationController(rootViewController: chileVc)
        self.addChildViewController(navigation)
    }
    
    lazy var composeButton: UIButton = {

        let btn = UIButton()
      
        btn.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: UIControlState.Normal)
        btn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted)
      
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted)
        
        btn.sizeToFit() //调整按钮尺寸
        
        return btn
    }()

}


















