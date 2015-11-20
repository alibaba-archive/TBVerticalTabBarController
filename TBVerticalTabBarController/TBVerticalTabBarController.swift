//
//  TBVerticalTabBarController.swift
//  TBVerticalTabBarController
//
//  Created by ChenHao on 11/18/15.
//  Copyright © 2015 HarriesChen. All rights reserved.
//

import UIKit

class TBVerticalTabBarController: UIViewController, switchTabBarProtocol {

    private let tabbarWidth: CGFloat = 78.0
    
    var containerView: UIView?
    var tabBar: TBVerticalTabBar?
    var selectedViewController: UIViewController?
    var selectedIndex: Int?
    var viewControllers:[UIViewController]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    func initTabBar() {
        tabBar = TBVerticalTabBar(frame: CGRect(x: 0, y: 0, width: tabbarWidth, height: UIScreen.mainScreen().bounds.height))
        tabBar?.delegate = self
        tabBar?.setItemArray(self.viewControllers!)
        self.view.addSubview(tabBar!)
    }
    
    private var containerFrame: CGRect {
        get {
            return CGRect(x: tabbarWidth, y: 0, width: UIScreen.mainScreen().bounds.width - tabbarWidth, height: UIScreen.mainScreen().bounds.height)
        }
    }
    
    private var containerSize: CGSize {
        get {
            return CGSize(width: UIScreen.mainScreen().bounds.width - tabbarWidth, height: UIScreen.mainScreen().bounds.height)
        }
    }
    
    func setViewcontrollers(views: [UIViewController]) {
        
        self.viewControllers = views
        initTabBar()
        containerView = UIView(frame: containerFrame)
        self.view.addSubview(containerView!)
        self.selectedIndex = 0
        self.selectedViewController = views[0]
        self.selectedViewController?.view.frame.size = containerSize
        self.containerView!.addSubview(selectedViewController!.view)
        tabBar?.setSelectIndex(self.selectedIndex!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TBVerticalTabBarController {
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        tabBar?.adjustTabBar()
        self.containerView?.frame = containerFrame
//        self.containerView?.subviews[0].frame = containerFrame
    }
}

extension TBVerticalTabBarController {
    func didChangeViewController(selectedIndex: Int) {
        
        self.addChildViewController(self.viewControllers![selectedIndex])
        self.selectedViewController?.view.removeFromSuperview()
        self.selectedViewController = self.viewControllers![selectedIndex]
        self.selectedViewController?.view.frame.size = self.containerSize
        self.containerView?.addSubview((self.selectedViewController?.view)!)
    }
}

protocol TBVerticalTabBarControllerDelegate {
    
}