//
//  TJQRCodeViewController.swift
//  SinaWeibo
//
//  Created by Tony.Jin on 7/26/16.
//  Copyright © 2016 Innovatis Tech. All rights reserved.
//

import UIKit
import AVFoundation

class TJQRCodeViewController: UIViewController {

    @IBOutlet weak var scanlineTop: NSLayoutConstraint!
    @IBOutlet weak var customTabBar: UITabBar!
    @IBOutlet weak var containerHeight: NSLayoutConstraint!
    @IBOutlet weak var scanImage: UIImageView!
    @IBOutlet weak var customContainer: UIView!
    
    @IBOutlet weak var customLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customTabBar.selectedItem = customTabBar.items?.first
        customTabBar.delegate = self
        
        scanQRCode()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        startAnimation()
    }

    @IBAction func buttonActionClose(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func butttonActionAlbum(sender: AnyObject) {
        
    }
    
    
    func startAnimation(){
        scanlineTop.constant = -containerHeight.constant
        view.layoutIfNeeded()
        
        UIView.animateWithDuration(1.0) {
            UIView.setAnimationRepeatCount(MAXFLOAT)
            self.scanlineTop.constant = self.containerHeight.constant
            self.view.layoutIfNeeded()
        }
    }
    
    private func scanQRCode(){
        // 1.判断输入能否添加到会话中
        if !session.canAddInput(input){
            return
        }
        // 2.判断输出能够添加到会话中
        if !session.canAddOutput(output){
            return
        }
        // 3.添加输入和输出到会话中
        session.addInput(input)
        session.addOutput(output)
        // 4.设置输出能够解析的数据类型, 注意点: 设置数据类型一定要在输出对象添加到会话之后才能设置
        output.metadataObjectTypes = output.availableMetadataObjectTypes
        // 5.设置监听监听输出解析到的数据
        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        // 6.添加预览图层
        view.layer.insertSublayer(previewLayer, atIndex: 0)
        previewLayer.frame = view.bounds
        // 7.开始扫描
        session.startRunning()
    }
    
    // MARK: - 懒加载
    /// 输入对象
    private lazy var input: AVCaptureDeviceInput? = {
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        return try? AVCaptureDeviceInput(device: device)
    }()
    /// 会话
    private lazy var session: AVCaptureSession = AVCaptureSession()
    /// 输出对象
    private lazy var output: AVCaptureMetadataOutput = {
        let out = AVCaptureMetadataOutput()
        //out.rectOfInterest = CGRect(x: <#T##Int#>, y: <#T##Int#>, width: <#T##Int#>, height: <#T##Int#>)
        let rect = self.view.frame
        
        return out
    }()
    
    /// 预览图层
    private lazy var previewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.session)
    
}


extension TJQRCodeViewController: UITabBarDelegate{
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        containerHeight.constant = (item.tag == 1) ? 100 : 200
        view.layoutIfNeeded()
        
        //移除动画
        scanImage.layer.removeAllAnimations()
        //开启动画
        startAnimation()
   
    }
}

extension TJQRCodeViewController: AVCaptureMetadataOutputObjectsDelegate{
    /// 只要扫描到结果就会调用
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!){
        customLabel.text =  metadataObjects.last?.stringValue
    }
}









