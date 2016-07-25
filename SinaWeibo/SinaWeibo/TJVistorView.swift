//
//  TJVistorView.swift
//  SinaWeibo
//
//  Created by Tony.Jin on 7/24/16.
//  Copyright © 2016 Innovatis Tech. All rights reserved.
//

import UIKit

protocol TJVistirViewDelegate: NSObjectProtocol {
    func vistorViewWithClickRegisterBtn(vistorView: TJVistorView)
    func vistorViewWithClickLoginBtn(vistorView: TJVistorView)
}

class TJVistorView: UIView {

    @IBOutlet weak var rotationImageView: UIImageView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    weak var delegate: TJVistirViewDelegate?
    
    func setupVistorInfo(imageName: String?, title: String){
        titleLabel.text = title
        guard let name = imageName else{
            startAnimation()
            return
        }
        //不是首页
        rotationImageView.hidden = true
        iconImageView.image = UIImage(named: name)
    }
    
    @IBAction func buttonActionRegister(sender: AnyObject) {
        //与OC 不同，Swift中如果简单的调用代理方法，不用判断代理能否响应
        delegate?.vistorViewWithClickRegisterBtn(self)
    }
    
    @IBAction func buttonActionLogin(sender: AnyObject) {
        delegate?.vistorViewWithClickLoginBtn(self)
    }
    
    
    private func startAnimation(){
        
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        
        anim.toValue = 2 * M_PI
        anim.duration = 5.0
        anim.repeatCount = MAXFLOAT
        
        anim.removedOnCompletion = false // 默认情况下，只要视图消失，系统就会自动移除动画
        rotationImageView.layer.addAnimation(anim, forKey: nil)
    }
    
    
    //func相当于OC的-, class func相当于OC的+
    class func vistorView() -> TJVistorView{
        return NSBundle.mainBundle().loadNibNamed("TJVistorView", owner: nil, options: nil).last as! TJVistorView
    }
    


}
