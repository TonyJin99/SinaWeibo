//
//  TJNewFeatureViewController.swift
//  SinaWeibo
//
//  Created by Tony.Jin on 7/31/16.
//  Copyright © 2016 Innovatis Tech. All rights reserved.
//

import UIKit
import SnapKit

class TJNewFeatureViewController: UIViewController {
    
    var count = 4

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
}


extension TJNewFeatureViewController: UICollectionViewDelegate{
    
    func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        let index = collectionView.indexPathsForVisibleItems().last
        let currentCell = collectionView.cellForItemAtIndexPath(index!) as! TJNewFeatureCell
        
        if index?.item == count - 1{
            currentCell.startAnimation()
        }
    }
}

extension TJNewFeatureViewController: UICollectionViewDataSource{

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 4
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("tony", forIndexPath: indexPath) as! TJNewFeatureCell
        cell.backgroundColor = (indexPath.item % 2 == 0) ? UIColor.redColor() : UIColor.purpleColor()
        cell.index = indexPath.item
        return cell
    }
    
}

//MARK: 自定义cell
class TJNewFeatureCell: UICollectionViewCell{
    
    var index: Int = 0{
        didSet{
            let name = "new_feature_\(index + 1)"
            iconImage.image = UIImage(named: name)
            
            startButton.hidden = true
            if index == 3 {
                startButton.hidden = false
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentView.addSubview(iconImage)
        contentView.addSubview(startButton)
        
        iconImage.snp_makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        startButton.snp_makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.bottom.equalTo(contentView).offset(-150)
        }
        
    }
    
    private lazy var iconImage = UIImageView()
    
    private lazy var startButton: UIButton = {
        let btn = UIButton(imageName: nil, backgroundImageName: "new_feature_button")
        btn.addTarget(self, action: #selector(self.startButtonAction), forControlEvents: UIControlEvents.TouchUpInside)
        return btn
    }()
    
    func startButtonAction(){
        let view = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        UIApplication.sharedApplication().keyWindow?.rootViewController = view

    }
    
    
    func startAnimation(){
        startButton.transform = CGAffineTransformMakeScale(0.0, 0.0)
        startButton.userInteractionEnabled = false
        UIView.animateWithDuration(2.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
            self.startButton.transform = CGAffineTransformIdentity
            
            }, completion: { (_) -> Void in
                self.startButton.userInteractionEnabled = true
        })
        
    }
}


//MARK: 自定义布局
class TJNewFeatureLayOut: UICollectionViewFlowLayout{
    override func prepareLayout() {
       
        itemSize = UIScreen.mainScreen().bounds.size  //1 设置每个cell的尺寸
        minimumLineSpacing = 0 //2 设置cell之间的间隙
        minimumInteritemSpacing = 0 //2 设置cell之间的间隙
        scrollDirection = UICollectionViewScrollDirection.Horizontal //3 设置滚动方向
        collectionView?.pagingEnabled = true  //4 设置分页
        collectionView?.bounces = false //5 禁止回弹
        collectionView?.showsVerticalScrollIndicator = false //6 去除滚动条
        collectionView?.showsHorizontalScrollIndicator = false //6 去除滚动条
        
    }
}

