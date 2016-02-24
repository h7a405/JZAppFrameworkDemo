//
//  ViewController.swift
//  JZAppFrameworkDemo
//
//  Created by Jason.Chengzi on 16/01/15.
//  Copyright © 2016年 weSwift. All rights reserved.
//

//MARK: - 类注释
/*
*
*/

//MARK: - 类描述
///

//MARK: - 头文件
import UIKit
import MultipeerConnectivity

//MARK: - class函数
class ViewController: UIViewController {
    //MARK: 储存变量 - Int/Float/Double/String
    
    //MARK: 集合类型 - Array/Dictionary/Tuple
    
    //MARK: 自定义类型 - Custom
    lazy var session : MCSession = {
        //创建节点，displayName是用于提供给周边设备查看和区分此服务的
        var tempSession = MCSession(peer: MCPeerID(displayName: "CZLee"))
        return tempSession
    }()
    lazy var advertiserAssistant : MCAdvertiserAssistant = {
        //创建广播
        return MCAdvertiserAssistant(serviceType: "cmj-stream", discoveryInfo: nil, session: self.session)
    }()
    //MARK: UIView子类 - UIView/UIControl/UIViewController
    lazy var imagePickerController : UIImagePickerController = {
        return UIImagePickerController()
    }()
    var browserController : MCBrowserViewController?
    
    @IBOutlet weak var imageView: UIImageView!
    //MARK: Foundation - NS/CG/CA
    
    //MARK: 计算变量
    
    //MARK: 闭包与结构体 - Closure/Struct
    
    //MARK: 代理与数据源 - delegate/datasource
    
    //MARK: 重用 - Override/Required/Convenience
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.session.delegate = self
        self.advertiserAssistant.delegate = self
        self.imagePickerController.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
//MARK: - 拓展
//MARK: 初始化与配置 - Initailize & Setup

//MARK: 操作与执行 - Action & Operation

//MARK: 更新 - Update

//MARK: 判断 - Judgement

//MARK: 响应方法 - Selector
extension ViewController {
    @IBAction func advertiserClick(sender: AnyObject) {
        Log.VLog("开始广播。")
        self.advertiserAssistant.start()
    }
    @IBAction func selectClick(sender: AnyObject) {
        self.presentViewController(imagePickerController, animated: true, completion: nil)
    }
}
//MARK: 回调 - Call back

//MARK: 数据源与代理 - DataSrouce & Delegate
//UINavigationControllerDelegate
extension ViewController : UINavigationControllerDelegate {
    
}
//UIImagePickerControllerDelegate
extension ViewController : UIImagePickerControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imageView.image = image
            //发送数据给所有已连接设备
            if let imageData = UIImagePNGRepresentation(image) {
                do {
                    try self.session.sendData(imageData, toPeers: self.session.connectedPeers, withMode: .Unreliable)
                } catch {
                    Log.VLog("发送数据过程中发生错误.")
                }
            }
        }
        self.imagePickerController.dismissViewControllerAnimated(true, completion: nil)
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.imagePickerController.dismissViewControllerAnimated(true, completion: nil)
    }
}
//MCSessionDelegate
extension ViewController : MCSessionDelegate {
    func session(session: MCSession, peer peerID: MCPeerID, didChangeState state: MCSessionState) {
        switch state {
        case .Connected:
            Log.VLog("连接成功")
        case .Connecting:
            Log.VLog("正在连接...")
        case .NotConnected:
            Log.VLog("连接失败")
        }
    }
    func session(session: MCSession, didReceiveData data: NSData, fromPeer peerID: MCPeerID) {
        Log.VLog("开始接收数据…")
        if let image = UIImage(data: data) {
            self.imageView.image = image
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
    }
    func session(session: MCSession, didReceiveStream stream: NSInputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    func session(session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, atURL localURL: NSURL, withError error: NSError?) {
        
    }
    func session(session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, withProgress progress: NSProgress) {
        
    }
}
//MCAdvertiserAssistantDelegate
extension ViewController : MCAdvertiserAssistantDelegate {
    
}

//MARK: 设置 - Setter

//MARK: 获取 - Getter

//MARK: - 其他
//MARK: 协议  -   Protocol

//MARK: 枚举  -   Enumeration
