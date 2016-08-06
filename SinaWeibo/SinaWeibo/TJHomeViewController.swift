//
//  TJHomeViewController.swift
//  SinaWeibo
//
//  Created by Tony.Jin on 7/23/16.
//  Copyright © 2016 Innovatis Tech. All rights reserved.
//

import UIKit
import QorumLogs
import SVProgressHUD
import SDWebImage
 
class TJHomeViewController: TJBaseViewController {
    
    var statuses: [TJStatusViewModel]?{
        didSet{
            tableView.reloadData()
        }
    }
    
    private var isPresent = false

    override func viewDidLoad() {
        super.viewDidLoad()

        if !islogin{
            vistorView?.setupVistorInfo(nil, title: "关注一些人，回这里看看有什么惊喜")
            return
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendsearch", target: self, action: #selector(self.buttonActionLeftBtn))
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop", target: self, action: #selector(self.buttonActionRightBtn))

        navigationItem.titleView = titleButton
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.btnChange), name: "present", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.btnChange), name: "dismiss", object: nil)
        
        loadingData()
        
        
        tableView.estimatedRowHeight = 400
        //tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func btnChange(){
         titleButton.selected = !titleButton.selected
    }
    
    func loadingData(){
        NetworkTools.sharedInstance.loadStatus { (array, error) in
            if error != nil{
                SVProgressHUD.showErrorWithStatus("没有获取到数据")
                SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.Black)
            }
            //字典转模型
            var models = [TJStatusViewModel]()
            for dict in array!{
                let status = TJStatus(dict: dict)
                let viewModel = TJStatusViewModel(status: status)
                models.append(viewModel)
            }
            
            //缓存微博所有配图
            self.cachesImages(models)
        }
    }
    
    private func cachesImages(viewModels: [TJStatusViewModel]){
        let group = dispatch_group_create()
        
        for viewModel in viewModels{
            guard let picurls = viewModel.thumbnail_pic else{
                return
            }

            for url in picurls{
                dispatch_group_enter(group)
                
                SDWebImageManager.sharedManager().downloadImageWithURL(url, options: SDWebImageOptions(rawValue: 0), progress: nil, completed: { (image, error, _, _, _) in
                    //print("图片下载完成")
                    dispatch_group_leave(group)
                })
            }
        }

        dispatch_group_notify(group, dispatch_get_main_queue()) { () -> Void in
           // print("全部下载完成")
            self.statuses = viewModels
        }
    }
    
    
    private lazy var titleButton: TitleButton = {
        let btn = TitleButton()
        let title = TJUserAccount.loadUserAccount()?.screen_name
        btn.setTitle(title, forState: UIControlState.Normal)
        btn.setImage(UIImage(named: "navigationbar_arrow_down"), forState: UIControlState.Normal)
        btn.setImage(UIImage(named: "navigationbar_arrow_up"), forState: UIControlState.Selected)
        btn.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        btn.addTarget(self, action: #selector(self.titleBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        btn.sizeToFit()
        return btn

    }()
    
    func titleBtnClick(btn: TitleButton){
       // btn.selected = !btn.selected
        let popview = UIStoryboard(name: "pullDown", bundle: nil).instantiateInitialViewController()
        
        popview?.transitioningDelegate = self
        popview?.modalPresentationStyle = UIModalPresentationStyle.Custom
        presentViewController(popview!, animated: true, completion: nil)
    }
    
    
    func buttonActionLeftBtn(){
        
    }
    
    func buttonActionRightBtn(){
        let QRStoryBoard = UIStoryboard(name: "QRCode", bundle: nil).instantiateInitialViewController()
        presentViewController(QRStoryBoard!, animated: true, completion: nil)
    }
    
    private lazy var rowHeightCache = [String: CGFloat]()
}


extension TJHomeViewController: UIViewControllerTransitioningDelegate{
     //该方法用于返回一个负责转场动画的对象， 可以在该对象中控制弹出视图的尺寸
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController?{
        return TJPresentationController(presentedViewController: presented, presentingViewController: presenting)
    }
    
    //该方法用于返回一个负责转场如何出现的对象
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        isPresent = true
        NSNotificationCenter.defaultCenter().postNotificationName("present", object: self)
        return self
    }
    
    ////该方法用于返回一个负责转场如何消失的对象
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        isPresent = false
        NSNotificationCenter.defaultCenter().postNotificationName("dismiss", object: self)
        return self
    }
    
}

extension TJHomeViewController: UIViewControllerAnimatedTransitioning{
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval{
        return 0.5
    }
    
    //专门控制modal如何出现和消失
    func animateTransition(transitionContext: UIViewControllerContextTransitioning){

        if isPresent{
            guard let toView = transitionContext.viewForKey(UITransitionContextToViewKey) else{
                return
            }
            
            transitionContext.containerView()?.addSubview(toView)
            
            toView.transform = CGAffineTransformMakeScale(1.0, 0.0)
            toView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.0) //设置锚点
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
                toView.transform = CGAffineTransformIdentity
            }) { (_) in
                transitionContext.completeTransition(true)
            }
        }
        else{
            guard let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey) else{
                return
            }
            
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
                fromView.transform = CGAffineTransformMakeScale(1.0, 0.0000001)
            }) { (_) in
                transitionContext.completeTransition(true)
            }
        }
    }
    
}

extension TJHomeViewController{
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.statuses?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Home", forIndexPath: indexPath) as! TJHomeTableViewCell
        
        cell.viewModel = statuses![indexPath.row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        let viewModel = statuses![indexPath.row]
        
        guard let height = rowHeightCache[viewModel.status.idstr ?? "-1"] else {
            let cell = tableView.dequeueReusableCellWithIdentifier("Home") as! TJHomeTableViewCell
            let temp = cell.calaulateRowHeight(viewModel)
            rowHeightCache[viewModel.status.idstr ?? "-1"] = temp
            return temp
        }
        
        return height
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //释放缓存内存
        rowHeightCache.removeAll()
    }
}
































