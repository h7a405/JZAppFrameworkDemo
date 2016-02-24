//
//  CoreGraphicsExtension.swift
//  XiaoFeiXia
//
//  Created by Jason.Chengzi on 15/12/29.
//  Copyright © 2015年 HVIT. All rights reserved.
//

import UIKit

extension CGRect {
    static var screenBounds : CGRect {
        return UIScreen.mainScreen().bounds
    }
    static var applicationBounds : CGRect {
        return UIScreen.mainScreen().applicationFrame
    }
    static var statusBarBounds : CGRect {
        return UIApplication.sharedApplication().statusBarFrame
    }
}