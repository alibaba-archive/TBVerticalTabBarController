//
//  TBVerticalTabBarController.swift
//  TBVerticalTabBarController
//
//  Created by ChenHao on 11/18/15.
//  Copyright © 2015 HarriesChen. All rights reserved.
//

import UIKit


struct TBVC {
    static let tabBarWidth: CGFloat = 78.0
    static let mainWidth: CGFloat = UIScreen.mainScreen().bounds.size.width
    static let mainHeight: CGFloat = UIScreen.mainScreen().bounds.size.height
}

class TBVerticalTabBarController: UIViewController, TBVercicalTabBarProtocol {
    
    var containerView: UIView?
    var tabBar: TBVerticalTabBar?
    var selectedViewController: UIViewController?
    var selectedIndex: Int?
    var viewControllers: [UIViewController]?
    var delegate: TBVerticalTabBarControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func initTabBar() {
        tabBar = TBVerticalTabBar(frame: CGRect(x: 0, y: 0, width: TBVC.tabBarWidth, height: TBVC.mainHeight))
        tabBar?.delegate = self
        tabBar?.setItemArray(self.viewControllers!)
        self.view.addSubview(tabBar!)
    }
    
    private var containerFrame: CGRect {
        get {
            return CGRect(x: TBVC.tabBarWidth, y: 0, width: TBVC.mainWidth - TBVC.tabBarWidth, height: TBVC.mainHeight)
        }
    }
    
    private var containerSize: CGSize {
        get {
            return CGSize(width: TBVC.mainWidth - TBVC.tabBarWidth, height: TBVC.mainHeight)
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
        
        let v = selectedViewController!.view
        
        self.containerView!.addSubview(v)
        v.translatesAutoresizingMaskIntoConstraints = false
        let containnerV = NSLayoutConstraint(item: v, attribute: .Width, relatedBy: .Equal, toItem: containerView, attribute: .Width, multiplier: 1, constant: 0)
        let containnerH = NSLayoutConstraint(item: v, attribute: .Height, relatedBy: .Equal, toItem: containerView, attribute: .Height, multiplier: 1, constant: 0)
        let containerTop = NSLayoutConstraint(item: v, attribute: .Top, relatedBy: .Equal, toItem: containerView, attribute: .Top, multiplier: 1, constant: 0)
        let containerLeft = NSLayoutConstraint(item: v, attribute: .Left, relatedBy: .Equal, toItem: containerView, attribute: .Left, multiplier: 1, constant: 0)
        
        containerView?.addConstraints([containnerH,containnerV,containerTop, containerLeft])
//        containerView?.addConstraints(containers1)
        tabBar?.setSelectIndex(self.selectedIndex!)
    }
    
    override func viewWillLayoutSubviews() {
        var size: CGSize = self.view.frame.size
        size.width -= 78
        containerView?.frame.size = size
    }
    
    func setExtraButtons(buttons: [TBTabBarItem]) {
        self.tabBar?.setExtraButtons(buttons)
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
    }
}

extension TBVerticalTabBarController {
    func tabBar(tabBar: TBVerticalTabBar, didSelectExtraButton selectedIndex: Int) {
        self.delegate?.VerticalTabBarController(self, didSelectExtralButtonIndex: selectedIndex)
    }
    
    func tabBar(tabBar: TBVerticalTabBar, didSelectViewController selectedIndex: Int) {
        self.addChildViewController(self.viewControllers![selectedIndex])
        self.selectedViewController?.view.removeFromSuperview()
        self.selectedViewController = self.viewControllers![selectedIndex]
        self.selectedViewController?.view.frame.size = self.containerSize
        self.containerView?.addSubview((self.selectedViewController?.view)!)
    }
}

protocol TBVerticalTabBarControllerDelegate: NSObjectProtocol {
    
    func VerticalTabBarController(tabBarController: TBVerticalTabBarController, shouldSelectViewController viewController: UIViewController) -> Bool
    
    func VerticalTabBarController(tabBarController: TBVerticalTabBarController, didSelectViewController viewController: UIViewController)
    
    func VerticalTabBarController(tabBarController: TBVerticalTabBarController, didSelectExtralButtonIndex: Int)
    
}