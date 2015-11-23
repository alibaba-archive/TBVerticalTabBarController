//
//  AppDelegate.swift
//  TBVerticalTabBarController
//
//  Created by ChenHao on 11/18/15.
//  Copyright © 2015 HarriesChen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
//        let tabbarcontroller: UITabBarController = UITabBarController()
//        tabbarcontroller.viewControllers = [ViewController()]
//        
//        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
//        self.window?.rootViewController = tabbarcontroller
//        self.window?.makeKeyAndVisible()
        
        let tabbarcontroller: TBVerticalTabBarController = TBVerticalTabBarController()
        
        let nav1:UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Nav1") as! UINavigationController
        
        let nav2:UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Nav2") as! UINavigationController
        
        let nav3:UISplitViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Nav3") as! UISplitViewController
        nav3.preferredDisplayMode = .AllVisible
        
        let nav4:UISplitViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Nav3") as! UISplitViewController
        nav4.preferredDisplayMode = .AllVisible
        
        let nav5:UISplitViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Nav3") as! UISplitViewController
        nav5.preferredDisplayMode = .AllVisible
        
        
        let item1 = TBTabBarItem(title: "哈哈", image: UIImage(named: "dialog"), tag: 0)
        nav1.tabBarItem = item1
        let item2 = TBTabBarItem(title: "我的", image: UIImage(named: "user"), tag: 0)
        nav2.tabBarItem = item2
        let item3 = TBTabBarItem(title: "我的", image: UIImage(named: "message"), tag: 0)
        nav3.tabBarItem = item3
        
        let item4 = TBTabBarItem(title: nil, image: UIImage(named: "add"), tag: 0)
        item4.position = .Bottom
        nav4.tabBarItem = item4
        
        let item5 = TBTabBarItem(title: nil, image: UIImage(named: "setting"), tag: 0)
        item5.position = .Bottom
        nav5.tabBarItem = item5
        
        tabbarcontroller.setViewcontrollers([nav1, nav2, nav3])
        tabbarcontroller.setExtraButtons([item4,item5])
        tabbarcontroller.delegate = self
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController = tabbarcontroller
        self.window?.makeKeyAndVisible()
        
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

extension AppDelegate: TBVerticalTabBarControllerDelegate {
    func VerticalTabBarController(tabBarController: TBVerticalTabBarController, didSelectExtralButtonIndex: Int) {
        let setting = SettingViewController()
        
        let nav = UINavigationController(rootViewController: setting)
        nav.modalPresentationStyle = .FormSheet
        self.window?.rootViewController?.presentViewController(nav, animated: true, completion: nil)
    }
    
    func VerticalTabBarController(tabBarController: TBVerticalTabBarController, didSelectViewController viewController: UIViewController) {
        
    }
    
    func VerticalTabBarController(tabBarController: TBVerticalTabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        return true
    }
}

