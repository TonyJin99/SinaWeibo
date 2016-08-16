//
//  TJRefreshView.swift
//  SinaWeibo
//
//  Created by Tony.Jin on 8/8/16.
//  Copyright © 2016 Innovatis Tech. All rights reserved.
//

import UIKit
import SnapKit

class TJRefreshControl: UIRefreshControl{
    override init() {
        super.init()
        addSubview(refreshView)
        refreshView.snp_makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 150, height: 50))
            make.center.equalTo(self)
        }
        
        //监听UIRefreshControl的frame改变
        addObserver(self, forKeyPath: "frame", options: NSKeyValueObservingOptions.New, context: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit{
        removeObserver(self, forKeyPath: "frame")
    }
    
    //MARK: 内部控制方法
    override func endRefreshing() {
        super.endRefreshing()
        loadingFlag = false
        refreshView.stopLoadingView()
    }
    
    var rotationFlag = false
    var loadingFlag = false
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if frame.origin.y == 0 || frame.origin.y == -64{
            return
        }
        
        if refreshing && !loadingFlag{
            loadingFlag = true
            refreshView.startLoadingView()
            return
        }
       
        //通过观察，往下拉y越小，往上推，y越大
        if frame.origin.y < -50 && !rotationFlag{
            rotationFlag = true
            refreshView.rotateArrow()
            //print("up")
        }else if frame.origin.y > -50 && rotationFlag{
            rotationFlag = false
            refreshView.rotateArrow()
            //print("down")
        }
    }
    
    private lazy var refreshView: TJRefreshView = TJRefreshView.refreshView()
}


class TJRefreshView: UIView {
    
    @IBOutlet weak var loadingImage: UIImageView!
    @IBOutlet weak var downView: UIView!
    @IBOutlet weak var arrowImage: UIImageView!
    
    class func refreshView() -> TJRefreshView{
        return NSBundle.mainBundle().loadNibNamed("TJRefreshView", owner: nil, options: nil).last as! TJRefreshView
    }
    
    func rotateArrow(){
        UIView.animateWithDuration(0.3) {
            self.arrowImage.transform = CGAffineTransformRotate(self.arrowImage.transform, CGFloat(M_PI))
        }
    }
    
    func startLoadingView(){
        downView.hidden = true
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        
        anim.toValue = 2 * M_PI
        anim.duration = 5.0
        anim.repeatCount = MAXFLOAT
        
        loadingImage.layer.addAnimation(anim, forKey: nil)
    }
    
    func stopLoadingView(){
        downView.hidden = false
        loadingImage.layer.removeAllAnimations()
    }
    
    

}












