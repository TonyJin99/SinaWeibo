//
//  TJPresentationController.swift
//  SinaWeibo
//
//  Created by Tony.Jin on 7/25/16.
//  Copyright © 2016 Innovatis Tech. All rights reserved.
//

import UIKit

class TJPresentationController: UIPresentationController {
    
    /*
     1.如果不自定义转场modal出来的控制器会移除原有的控制器
     2.如果自定义转场modal出来的控制器不会移除原有的控制器
     3.如果不自定义转场modal出来的控制器的尺寸和屏幕一样
     4.如果自定义转场modal出来的控制器的尺寸我们可以自己在containerViewWillLayoutSubviews方法中控制
     5.containerView 非常重要, 容器视图, 所有modal出来的视图都是添加到containerView上的
     6.presentedView() 非常重要, 通过该方法能够拿到弹出的视图
     */
    
    override init(presentedViewController: UIViewController, presentingViewController: UIViewController) {
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
    }
 
    //布局专场动画弹出的控件
    override func containerViewWillLayoutSubviews() {
        let width = UIScreen.mainScreen().bounds.width / 3
        presentedView()?.frame = CGRect(x: width, y: 60, width: width, height: 200)
        
        containerView?.insertSubview(coverBtn, atIndex: 0)
        coverBtn.addTarget(self, action: #selector(self.coverBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func coverBtnClick(){
        presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: Lazy Loading
    private lazy var coverBtn: UIButton = {
        let btn = UIButton()
        btn.frame = UIScreen.mainScreen().bounds
        btn.backgroundColor = UIColor.clearColor()
        return btn
    }()
    
    
}
