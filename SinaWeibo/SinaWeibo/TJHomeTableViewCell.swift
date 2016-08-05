//
//  TJHomeTableViewCell.swift
//  SinaWeibo
//
//  Created by Tony.Jin on 8/1/16.
//  Copyright © 2016 Innovatis Tech. All rights reserved.
//

import UIKit
import SDWebImage

class TJHomeTableViewCell: UITableViewCell {

    @IBOutlet weak var verifiedImageView: UIImageView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var vipImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    var viewModel: TJStatusViewModel?{
        didSet{
            
            iconImageView.layer.cornerRadius = iconImageView.frame.size.width / 2
            iconImageView.layer.masksToBounds = true
            iconImageView.sd_setImageWithURL(viewModel?.icon_Url)
            
            verifiedImageView.image = viewModel!.verified_image
            
            nameLabel.text = viewModel!.status.user?.screen_name
            

            if let image = viewModel!.mbrankImage{
                vipImageView.image = image
                nameLabel.textColor = UIColor.orangeColor()
            }else{
                vipImageView.image = nil
                nameLabel.textColor = UIColor.blackColor()
            }
            
            timeLabel.text = viewModel!.created_Time
            sourceLabel.text = viewModel!.source_Text
            contentLabel.text = viewModel?.status.text
            
            print(viewModel?.status.user?.screen_name)
            print(viewModel?.thumbnail_pic?.count)
            print(calculateImageSize())
        }
    }
    

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentLabel.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 2 * 10
        
    }
    
    //计算cell和collectionView的尺寸
    private func calculateImageSize() -> (CGSize, CGSize) {
        
        let count = viewModel?.thumbnail_pic?.count ?? 0
        let imageWidth: CGFloat = 90
        let imageHeight: CGFloat = 90
        let imageMargin: CGFloat = 10
        if count == 0{
            return (CGSizeZero, CGSizeZero)
        }
      
        if count == 1{
            let key = viewModel?.thumbnail_pic?.first?.absoluteString
            let image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(key)
            return (image.size, image.size)
        }
     
        if count == 4{
            let width = CGFloat(2 * imageWidth + imageMargin)
            let height = CGFloat(2 * imageWidth + imageMargin)
            return(CGSize(width: imageWidth, height: imageHeight), CGSize(width: width, height: height))
        }
        
        let col = 3
        let row = (count - 1)/3 + 1
        let width = CGFloat(col) * imageWidth + CGFloat((col - 1)) * imageMargin
        let height = CGFloat(row) * imageHeight + CGFloat((row - 1)) * imageMargin
        return(CGSize(width: imageWidth, height: imageHeight), CGSize(width: width, height: height))
        
    }


}

























