//
//  UIKitExtension.swift
//  JZAppFramework
//
//  Created by Jason Lee on 15/12/24.
//  Copyright © 2015年 CZLee. All rights reserved.
//

import UIKit

//MARK: - UIBarItem
//MARK: UIBarButtonItem
//MARK: UITabBarItem
//MARK: - UIColor
extension UIColor {
    //MARK: 便捷颜色初始化
    class func colorWithRed(red: CGFloat, green: CGFloat, blue: CGFloat, andAlpha alpha: CGFloat) -> UIColor {
        return UIColor(red: (red / 255.0), green: (green / 255.0), blue: (blue / 255.0), alpha: alpha)
    }
    class func colorWithRed(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor.colorWithRed(red, green: green, blue: blue, andAlpha: 1)
    }
    //MARK: 16进制初始化颜色
    class func colorWithHex(hex h: Int, andAlpha alpha: CGFloat) -> UIColor {
        let red = (CGFloat(((h & 0xFF0000) >> 16)) / 255.0)
        let green = (CGFloat(((h & 0xFF00) >> 8)) / 255.0)
        let blue = (CGFloat((h & 0xFF)) / 255.0)
        return UIColor.colorWithRed(red, green: green, blue: blue, andAlpha: alpha)
    }
    class func colorWithHex(hex h: Int) -> UIColor {
        return UIColor.colorWithHex(hex: h, andAlpha: 1)
    }
    class func silverColor() -> UIColor {
        return UIColor.colorWithHex(hex: 0xC0C0C0)
    }
    class func skyBlueColor() -> UIColor {
        return UIColor.colorWithHex(hex: 0x87CEFA)
    }
    class func _66CCFF() -> UIColor {
        return UIColor.colorWithHex(hex: 0x66CCFF)
    }
}
//MARK: - UIDevice
//MARK: - UIEvent
//MARK: - UIFont
//MARK: - UIGestureRecognizer
//MARK: UILongPressGestureRecognizer
//MARK: UIPanGestureRecognizer
//MARK: UIPinchGestureRecognizer
//MARK: UIRotationGestureRecognizer
//MARK: UISwipeGestureRecognizer
//MARK: UITapGestureRecognizer
//MARK: - UIImage
extension UIImage {
    //MARK: 压缩图片方法。
    //来自 http://superdanny.link/2016/01/28/iOS-Upload-Image/
    func getCompressedImageData(maxSize : Int = 30) -> NSData {
        //先调整分辨率
        var newSize     = CGSize(width: self.size.width, height: self.size.height)
        
        let tempHeight  = newSize.height / 1024
        let tempWidth   = newSize.width / 1024
        
        if tempWidth > 1.0 && tempWidth > tempHeight {
            newSize = CGSize(width: self.size.width / tempWidth, height: self.size.height / tempHeight)
        } else if tempHeight > 1.0 && tempWidth < tempHeight {
            newSize = CGSize(width: self.size.width / tempHeight, height: self.size.height / tempWidth)
        }
        
        UIGraphicsBeginImageContext(newSize)
        self.drawAsPatternInRect(CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //先判断当前质量是否满足要求，不满足再进行压缩
        var finalImageData  = UIImageJPEGRepresentation(newImage, 1.0)
        let sizeOrigin      = Int64((finalImageData?.length)!)
        let sizeOriginKB    = Int(sizeOrigin / 1024)
        
        if sizeOriginKB <= maxSize {
            return finalImageData!
        }
        
        //保存压缩系数
        var compressionQuiltyArray  = [CGFloat]()
        let avg                     = CGFloat(1.0 / 250)
        var value                   = avg
        
        for i in 250...1 {
            value = CGFloat(i) * avg
            compressionQuiltyArray.append(value)
        }
        
        //调整大小
        //说明：压缩系数数组compressionQualityArr是从大到小存储。
        //思路：折半计算，如果中间压缩系数仍然降不到目标值maxSize，则从后半部分开始寻找压缩系数；反之从前半部分寻找压缩系数
        finalImageData  = UIImageJPEGRepresentation(newImage, CGFloat(compressionQuiltyArray[125] as NSNumber))
        var range       = (begins: 0, ends: 0)
        
        if (UIImageJPEGRepresentation(newImage, CGFloat(compressionQuiltyArray[125] as NSNumber))?.length)! / 1024 > maxSize {
            //从后半部分开始
            range.begins    = 126
            range.ends      = 250
        } else {
            //从前半部分开始
            range.begins    = 0
            range.ends      = 125
        }
        
        for idx in range.begins..<range.ends {
            let value           = compressionQuiltyArray[idx]
            let sizeOrigin      = Int64((finalImageData?.length)!)
            let sizeOriginKB    = Int(sizeOrigin / 1024)
            
            Log.VLog("当前图片质量：\(sizeOriginKB)", logType: .Image)
            
            if sizeOriginKB > maxSize {
                Log.VLog("\(idx) --- \(value)", logType: .Image)
                
                finalImageData = UIImageJPEGRepresentation(newImage, CGFloat(value as NSNumber))
            } else {
                break
            }
        }
        return finalImageData!
    }
}
//MARK: - UIMenuController
//MARK: - UIMenuItem
//MARK: - UINavigationItem
//MARK: - UINib
//MARK: - UIPasteBoard
//MARK: - UIPopoverController
//MARK: - UIResponder
//MARK: UIApplication
//MARK: UIView
extension UIView {
    //左上角x坐标
    var viewX : CGFloat { get {return self.frame.origin.x} set(newX) {self.frame.origin.x = newX} }
    //左上角y坐标
    var viewY : CGFloat { get {return self.self.frame.origin.y} set(newY) {self.frame.origin.y = newY} }
    //宽度
    var viewWidth : CGFloat { get {return self.frame.size.width} set(newWidth) {self.frame.size.width = newWidth} }
    //高度
    var viewHeight: CGFloat { get {return self.frame.size.height} set(newHeight) {self.frame.size.height = newHeight} }
    //右上角x
    var viewMaxX : CGFloat { get {return self.viewX + self.viewWidth} set(newMaxX) {self.viewX = newMaxX - self.viewWidth} }
    //左下角y
    var viewMaxY : CGFloat { get {return self.viewY + self.viewHeight} set(newMaxY) {self.viewY = newMaxY - self.viewHeight} }
    
    //左上角起点的坐标
    var viewOrigin : CGPoint { get {return self.frame.origin }
        set(newOrigin) {self.viewX = newOrigin.x; self.viewY = newOrigin.y} }
    //右下角终点的坐标
    var viewEnd : CGPoint { get {return CGPoint(x: self.viewMaxX, y: self.viewMaxY)} set(newViewEnd) {self.viewMaxX = newViewEnd.x; self.viewMaxY = newViewEnd.y} }
    //尺寸
    var viewSize : CGSize { get {return self.frame.size}
        set(newSize) {self.viewWidth = newSize.width; self.viewHeight = newSize.height}}
    //中心点
    var viewCenter : CGPoint { get {return CGPoint(x: (self.viewWidth / 2) + self.viewX, y: (self.viewHeight / 2) + self.viewY)}
        set(newCenterPoint) { self.viewOrigin = CGPoint(x: newCenterPoint.x - (self.viewWidth / 2), y: newCenterPoint.y - (self.viewHeight / 2))} }
    
    var viewCenterVertical: CGFloat { get {return self.viewHeight / 2} set(newCenterVertical) { self.viewY = newCenterVertical - (self.viewHeight / 2)} }
    var viewCenterHorizontal: CGFloat { get {return self.viewWidth / 2} set(newCenterHorizontal) { self.viewX = newCenterHorizontal - (self.viewWidth / 2)} }
    
}
//MARK: UIWindow
//MARK: UILabel
extension UILabel {
    func setHeightWithContent(content: String) {
        let heightToSet = content.heightWithFont(self.font, andWidth: self.viewWidth)
        self.viewSize = CGSize(width: self.viewWidth, height: heightToSet)
    }
    //MARK: 更改为多行显示
    func enableMultilLines(multiLines : Bool) {
        if multiLines {
            self.lineBreakMode = .ByWordWrapping
            self.numberOfLines = 0
        } else {
            self.numberOfLines = 1
        }
    }
    //MARK: 自动调整高度
    func heightAutoFit() {
        guard self.text == nil else {
            return
        }
//        var size : CGSize = CGSize(width: self.frame.size.width, height: self.frame.size.height)
//        let contentSize : CGSize = self.text!.sizeWithFont(self.font)
//        size.height = contentSize.width / size.width
//        self.frame = CGRect(origin: self.frame.origin, size: size)
        self.viewSize = CGSize(width: self.viewWidth, height: self.text!.heightWithFont(self.font, andWidth: self.viewWidth))
    }
}
//MARK: UIPickerView
//MARK: UIProgressView
//MARK: UIActivityIndicatorView
//MARK: UIImageView
extension UIImageView {
    //MARK: 显示整张图片
    //UIViewContentModeScaleToFill属性会导致图片变形。
    //UIViewContentModeScaleAspectFit会保证图片比例不变，而且全部显示在ImageView中，这意味着ImageView会有部分空白。
    //UIViewContentModeScaleAspectFill也会证图片比例不变，但是是填充整个ImageView的，可能只有部分图片显示出来。
    func showFullImage() {
        self.contentMode = .ScaleAspectFit
    }
    //MARK: 设置显示圆形
    func showRoundImage() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.size.width / 2
    }
    //MARK: 设置显示默认边框
    func showDefaultBorder() {
        self.layer.setBorderUIColor(UIColor.whiteColor())
        self.layer.borderWidth = 1
    }
}
//MARK: UITabBar
//MARK: UIToolBar
//MARK: UINavigationBar
//MARK: UITableViewCell
//MARK: UIActionSheet
//MARK: UIAlertView
//MARK: UIScrollView
extension UIScrollView {
    //FIXME: 滚动到底部
    func scrollToBottom() {
        print("offset:\(self.contentOffset)\nsize:\(self.contentSize)\nviewHeight:\(self.viewHeight)")
        if (self.contentOffset.y + self.viewHeight) <= self.contentSize.height {
            self.setContentOffset(CGPoint(x: 0, y: (self.contentSize.height - self.viewHeight)), animated: true)
        }
    }
}
//MARK: UITableView
//MARK: UITextView
extension UITextView {
    var length: Int {
        get {
            return self.text!.characters.count
        }
    }
    func isEmpty() -> Bool {
        if self.text!.characters.count == 0 || self.text!.characters.count < 1 || self.text == nil || self.text == "" {
            return true
        } else {
            return false
        }
    }
    
    func append(text: String) {
        print(text)
        let tempText = (self.text ?? "") + "\n\(text)"
        self.text = tempText
        
        self.scrollToBottom()
    }
    func clean() {
        self.text = ""
    }
}
//MARK: UISearchBar
//MARK: UIWebView
//MARK: UIControl
//MARK: UIButton
extension UIButton {
    func setNormalTitle(title: String?) {
        self.setTitle(title, forState: UIControlState.Normal)
    }
    func setHighlightedTitle(title: String?) {
        self.setTitle(title, forState: UIControlState.Highlighted)
    }
    func setNormalTitleColor(color: UIColor?) {
        self.setTitleColor(color, forState: UIControlState.Normal)
    }
    func setHighlightedTitleColor(color: UIColor?) {
        self.setTitleColor(color, forState: UIControlState.Highlighted)
    }
    func setFontSize(size: CGFloat) {
        self.titleLabel?.font = UIFont.systemFontOfSize(size)
    }
}
//MARK: UIDatePicker
//MARK: UIPageControl
//MARK: UISegmentedControl
//MARK: UITextField
extension UITextField {
    var length: Int {
        get {
            return self.text!.characters.count
        }
    }
    var isEmpty: Bool {
        if self.text!.characters.count == 0 || self.text!.characters.count < 1 || self.text == nil || self.text == "" {
            return true
        } else {
            return false
        }
    }
    class func phoneNumberTextField(frame: CGRect) -> UITextField {
        return UITextField.specialTextField(frame, type: .PhonePad)
    }
    class func numberTextField(frame: CGRect) -> UITextField {
        return UITextField.specialTextField(frame, type: .NumberPad)
    }
    class func secureTextField(frame: CGRect) -> UITextField {
        return UITextField.specialTextField(frame, secure: true)
    }
    private class func specialTextField(frame: CGRect, type: UIKeyboardType? = .Default, secure: Bool? = false) -> UITextField {
        let textField = UITextField(frame: frame)
        textField.clearButtonMode = .WhileEditing
        textField.keyboardType = type!
        textField.secureTextEntry = secure!
        return textField
    }
}
//MARK: UISlider
//MARK: UISwitch
//MARK: UIViewController
extension UIViewController {
    func setNavigationBarUncovered() {
        if Float(UIDevice.currentDevice().systemVersion)! > 7.0 {
            self.edgesForExtendedLayout = UIRectEdge.None
            self.extendedLayoutIncludesOpaqueBars = false
            self.modalPresentationCapturesStatusBarAppearance = false
        }
    }
}
//MARK: UISplitViewController
//MARK: UITabBarController
//MARK: UITableViewContoller
//MARK: UINavigationController
//MARK: UIImagePickerController
//MARK: UIVideoEditorController
//MARK: - UIScreen
extension UIScreen {
    func screenSize() -> CGRect {
        return self.bounds
    }
    func screenWidth() -> CGFloat {
        return self.bounds.width
    }
    func screenHeight() -> CGFloat {
        return self.bounds.height
    }
}
//MARK: - UISearchDisplayController
//MARK: - UITouch
