//
//  SwiftExtension.swift
//  JZAppFramework
//
//  Created by Jason Lee on 15/12/24.
//  Copyright © 2015年 CZLee. All rights reserved.
//

import UIKit
//MARK: String
extension String {
    //获取字符串的长度
    var length : Int {
        return self.characters.count
    }
    //获得字符串的长度：
    var convertToInt : Int {
        var stringLength = 0
        let string = NSString(string: self)
        var p = string.cStringUsingEncoding(NSUnicodeStringEncoding)
        for _ in 0..<string.lengthOfBytesUsingEncoding(NSUnicodeStringEncoding) {
            if p != nil {
                p++
                stringLength++
            } else {
                p++
            }
        }
        return (stringLength + 1) / 2
    }
    //获取字符串的size
    func sizeWithFont(font: UIFont) -> CGSize {
        return NSString(string: self).sizeWithAttributes([NSFontAttributeName: font])
    }
    //获取字符串高度
    func heightWithFont(font: UIFont, andWidth width: CGFloat) -> CGFloat {
        return self.sizeWithFont(font).width / width
    }
    //MD5加密字符串
    func md5() -> String {
        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
        let strLen = CUnsignedInt(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.destroy()
        return String(format: hash as String)
    }
    //打印字符串
    func print() {
        Log.VLog(self)
    }
    //转换为整型
    func intValue() -> Int? {
        return Int(self)
    }
    //转换为浮点型
    func floatValue() -> Float? {
        return Float(self)
    }
    //转换为长浮点型
    func doubleValue() -> Double? {
        return Double(self)
    }
    //获取指定长度的字符串
    func substringWithStart(start: Int, andEnd end: Int) -> String {
        return self.substringWithRange(self.startIndex.advancedBy(start)..<self.startIndex.advancedBy(end))
    }
    //生成UUID串
    static func generateUUIDString() -> String {
        return String(CFUUIDCreateString(kCFAllocatorDefault, CFUUIDCreate(kCFAllocatorDefault)))
    }
    
}
//MARK: Character
extension Character {
    func toInt() -> Int {
        var intFromCharacter:Int = 0
        for i in String(self).utf8
        {
            intFromCharacter = Int(i)
        }
        return intFromCharacter
    }
}
//MARK: Dictionary
extension Dictionary {
    func toString() -> String {
        var dicString = "{"
        for key in self.keys {
            dicString += "\n        [\(key) : \(((self[key] as? String) ?? ""))]"
        }
        return dicString + "\n        }"
    }
    func print() {
        Log.VLog(self.toString())
    }
}
//MARK: Array
extension Array {
    func toString() -> String {
        var stringToReturn = ""
        for (index, object) in self.enumerate() {
            stringToReturn += "\(index): \(object)"
        }
        return stringToReturn
    }
    func print() {
        Log.VLog(self.toString())
    }
}