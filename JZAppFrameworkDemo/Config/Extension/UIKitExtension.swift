//
//  UIKitExtension.swift
//  XiaoFeiXia
//
//  Created by Jason.Chengzi on 15/12/24.
//  Copyright © 2015年 HVIT. All rights reserved.
//

import UIKit

//MARK: - Control
//MARK: UIApplication
extension UIApplication {
    func mainWindow() -> UIWindow {
        return (self.delegate as! AppDelegate).window!
    }
}
//MARK: UIScreen
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
//MARK: UITextField
extension UITextField {
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
    func lengthOfContent() -> Int {
        return self.text!.characters.count
    }
    func setPhoneNumberOnly() {
        self.clearButtonMode = UITextFieldViewMode.WhileEditing
        self.keyboardType = UIKeyboardType.PhonePad
    }
    func setNumberOnly() {
        self.clearButtonMode = UITextFieldViewMode.WhileEditing
        self.keyboardType = UIKeyboardType.PhonePad
    }
    func setSecured() {
        self.clearButtonMode = UITextFieldViewMode.WhileEditing
        self.secureTextEntry = true
    }
}
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
}
//MARK: UIView
extension UIView {
    var xCoordinate: CGFloat {
        set {
            self.frame = CGRect(x: newValue, y: self.yCoordinate, width: self.widthOfFrame, height: self.heightOfFrame)
        }
        get {
            return self.frame.origin.x
        }
    }
    var yCoordinate: CGFloat {
        get {
            return self.frame.origin.y
        }
    }
    var widthOfFrame: CGFloat {
        get {
            return self.frame.size.width
        }
    }
    var heightOfFrame: CGFloat {
        get {
            return self.frame.size.height
        }
    }
    var sizeOfFrame: CGSize {
        set {
            self.frame = CGRect(x: self.xCoordinate, y: self.yCoordinate, width: newValue.width, height: newValue.height)
        }
        get {
            return self.frame.size
        }
    }
    var originOfFrame: CGPoint {
        set {
            self.frame = CGRect(x: newValue.x, y: newValue.y, width: self.widthOfFrame, height: self.heightOfFrame)
        }
        get {
            return self.frame.origin
        }
    }
    func centerHorizontal(subView: UIView) -> CGRect {
        return self.centerHorizontal(yCoordinate: subView.yCoordinate, widthOfSubView: widthOfFrame, heightOfSubView: heightOfFrame)
    }
    func centerHorizontal(yCoordinate y: CGFloat, widthOfSubView width: CGFloat, heightOfSubView height: CGFloat) -> CGRect {
        var rectToReturn: CGRect = CGRect(x: 0, y: y, width: width, height: height)
        rectToReturn.origin.x = (self.widthOfFrame - width) / 2
        
        return rectToReturn
    }
    func centerVertical(subView: UIView) -> CGRect {
        var rectToReturn: CGRect = CGRectZero
        let rectOfSubView: CGRect = subView.frame
        rectToReturn.origin.x = rectOfSubView.origin.x
        rectToReturn.size.width = rectOfSubView.size.width
        rectToReturn.size.height = rectOfSubView.size.height
        rectToReturn.origin.y = (self.heightOfFrame - rectOfSubView.size.height) / 2
        return rectToReturn
    }
    func centerMiddle(subView: UIView) -> CGRect {
        let xOfHorizotal: CGFloat = self.centerHorizontal(subView).origin.x
        let yOfVertical: CGFloat = self.centerVertical(subView).origin.y
        let rectToReturn: CGRect = CGRect(x: xOfHorizotal, y: yOfVertical, width: subView.widthOfFrame, height: subView.heightOfFrame)
        return rectToReturn
    }
}
//MARK: UILabel
extension UILabel {
    func setHeightWithContent(content: String) {
        let heightToSet = StringTool.getContentHeight(content, andFont: self.font, andWidth: self.widthOfFrame)
        self.sizeOfFrame = CGSize(width: self.widthOfFrame, height: heightToSet)
    }
}
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
    func setSystemFontSize(size: CGFloat) {
        self.titleLabel?.font = UIFont.systemFontOfSize(size)
    }
}

//MARK: - Properties
//MARK: UIColor
extension UIColor {
    static func RGBA (red r:CGFloat, green g:CGFloat, blue b:CGFloat, alpha a:CGFloat) -> UIColor {
        return UIColor(red: (r / 255.0), green: (g / 255.0), blue: (b / 255.0), alpha: a)
    }
    static func RGB (red r: CGFloat, green g: CGFloat, blue b: CGFloat) -> UIColor {
        return UIColor.RGBA(red: r, green: g, blue: b, alpha:1)
    }
    static func colorWithHexAndAlpha(hex h: Int, alpha a: CGFloat) -> UIColor {
        let red = (CGFloat(((h & 0xFF0000) >> 16)) / 255.0)
        let green = (CGFloat(((h & 0xFF00) >> 8)) / 255.0)
        let blue = (CGFloat((h & 0xFF)) / 255.0)
        return UIColor.RGBA(red: red, green: green, blue: blue, alpha: a)
    }
    static func colorWithHex(hex h: Int) -> UIColor {
        return UIColor.colorWithHexAndAlpha(hex: h, alpha: 1)
    }
    class func silverColor() -> UIColor {
        return UIColor.colorWithHex(hex: 0xC0C0C0)
    }
    class func skyBlueColor() -> UIColor {
        return UIColor.colorWithHex(hex: 0x87CEFA)
    }
    class func LuoTianYi() -> UIColor {
        return UIColor.colorWithHex(hex: 0x66CCFF)
    }
}
