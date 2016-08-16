//
//  TJTitleView.swift
//  SinaWeibo
//
//  Created by Tony.Jin on 8/16/16.
//  Copyright © 2016 Innovatis Tech. All rights reserved.
//

import UIKit
import SnapKit

class TJTitleView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpUI()
    }
    
    private func setUpUI(){
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        
        titleLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(self)
        }
        
        subTitleLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(titleLabel.snp_bottom)
        }
        
    }
    
    //MARK: lazy loading
    private lazy var titleLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFontOfSize(18)
        lb.text = "发送微博"
        return lb
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFontOfSize(14)
        lb.text = "Tony"
        return lb
    }()

}
