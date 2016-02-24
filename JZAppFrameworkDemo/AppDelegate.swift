//
//  AppDelegate.swift
//  JZAppFrameworkDemo
//
//  Created by Jason.Chengzi on 16/01/15.
//  Copyright © 2016年 weSwift. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
//        
//        //初始化window
//        self.window = UIWindow(frame: CGRect.screenBounds)
//        //设置window背景颜色，默认白色
//        self.window!.backgroundColor = UIColor.whiteColor()
//        
//        //初始化根视图，适配iOS9
//        let rootViewController: ViewController = ViewController()
//        //设置根视图
//        self.window!.rootViewController = rootViewController
//        //显示window
//        self.window!.makeKeyAndVisible()
//        
        //更改navigation bar的着色颜色
        UINavigationBar.appearance().barTintColor = PROJECT_VIEW_NAVIGATION_BAR_COLOR
        //关闭通透
        UINavigationBar.appearance().translucent = false
        //更改状态栏文字颜色
        UINavigationBar.appearance().barStyle = .BlackTranslucent
        //更改title的颜色
        UINavigationBar.appearance().titleTextAttributes = [
            NSFontAttributeName: PROJECT_VIEW_NAVIGATION_BAR_FONT,
            NSForegroundColorAttributeName: PROJECT_VIEW_NAVIGATION_BAR_TEXT_COLOR
        ]
        
        if #available(iOS 9.0, *) {
            let barButtonItemAppearence = UIBarButtonItem.appearanceWhenContainedInInstancesOfClasses([UINavigationBar.self])
            barButtonItemAppearence.setTitleTextAttributes([
                NSFontAttributeName : PROJECT_VIEW_NAVIGATION_BAR_BUTTON_FONT,
                NSForegroundColorAttributeName : PROJECT_VIEW_NAVIGATION_BAR_BUTTON_TEXT_COLOR
                ], forState: .Normal)
        } else {
            // Fallback on earlier versions
        }
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

