//
//  TJMessageViewController.swift
//  SinaWeibo
//
//  Created by Tony.Jin on 7/23/16.
//  Copyright © 2016 Innovatis Tech. All rights reserved.
//

import UIKit

class TJMessageViewController: TJBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !islogin{
            vistorView?.setupVistorInfo("visitordiscover_image_message", title: "登录后，别人评论你的微博，发给你的消息，都会在这里收到通知")
            return
        }

    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let ID = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(ID)
        if cell == nil{
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: ID)
        }
        cell?.textLabel?.text = String(format: "test-message-%d", indexPath.row)
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let text1 = TJTestViewController()
        text1.title = "TEST"
        self.navigationController?.pushViewController(text1, animated: true)
    }

}
