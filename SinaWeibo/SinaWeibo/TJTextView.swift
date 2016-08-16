//
//  TJTextView.swift
//  SinaWeibo
//
//  Created by Tony.Jin on 8/16/16.
//  Copyright © 2016 Innovatis Tech. All rights reserved.
//

import UIKit
import SnapKit

class TJTextView: UITextView {

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI(){
        
        addSubview(placeholderLabel)
        placeholderLabel.snp_makeConstraints { (make) in
            make.left.equalTo(4)
            make.top.equalTo(8)
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(valueChange), name: UITextViewTextDidChangeNotification, object: self)
        
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func valueChange(){
        placeholderLabel.hidden = hasText()
    }
    
    private lazy var placeholderLabel: UILabel = {
        let lb = UILabel()
        lb.text = "分享新鲜事..."
        lb.textColor = UIColor.lightGrayColor()
        return lb
    }()
    
    

}
