//
//  TJQRCodeViewController.swift
//  SinaWeibo
//
//  Created by Tony.Jin on 7/26/16.
//  Copyright © 2016 Innovatis Tech. All rights reserved.
//

import UIKit

class TJQRCodeViewController: UIViewController {

    @IBOutlet weak var customTabBar: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()

       customTabBar.selectedItem = customTabBar.items?.first
    }

    @IBAction func buttonActionClose(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }

    @IBAction func butttonActionAlbum(sender: AnyObject) {
        
    }
}
