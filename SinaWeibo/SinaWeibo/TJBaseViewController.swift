//
//  TJBaseViewController.swift
//  SinaWeibo
//
//  Created by Tony.Jin on 7/23/16.
//  Copyright © 2016 Innovatis Tech. All rights reserved.
//

import UIKit

class TJBaseViewController: UITableViewController {

    var islogin = true
    var vistorView: TJVistorView? //访客视图
    
    override func loadView() {
        islogin ? super.loadView() : setupVistorView()
    }
    
    func setupVistorView(){
        vistorView = TJVistorView.vistorView()
        vistorView!.backgroundColor = UIColor(white: 232.0/255.0, alpha: 1.0)
        view = vistorView
        
        vistorView?.delegate = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.clickRegisterBtn))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.clickLoginBtn))
    }
    
    func clickRegisterBtn(){
    }
    
    func clickLoginBtn(){
        
    }

}

extension TJBaseViewController: TJVistirViewDelegate{
    
    func vistorViewWithClickRegisterBtn(vistorView: TJVistorView) {
     
    }
    
    func vistorViewWithClickLoginBtn(vistorView: TJVistorView) {
        
    }
}












