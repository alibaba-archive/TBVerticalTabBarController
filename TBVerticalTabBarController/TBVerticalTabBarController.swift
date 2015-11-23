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
    
    var containerView: UIView = UIView()
    var tabBar: TBVerticalTabBar = TBVerticalTabBar()
    var selectedViewController: UIViewController?
    var selectedIndex: Int?
    var viewControllers: [UIViewController]?
    var delegate: TBVerticalTabBarControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    func commonInit() {
        initTabBar()
        initContainer()
    }
    
    func initTabBar() {
        tabBar.delegate = self
        self.view.addSubview(tabBar)
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        let topConstraints = NSLayoutConstraint(item: tabBar, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1, constant: 0)
        
        let leftConstraints = NSLayoutConstraint(item: tabBar, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1, constant: 0)
        
        let bottomConstraints = NSLayoutConstraint(item: tabBar, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1, constant: 0)
        
        let widthConstraints = NSLayoutConstraint(item: tabBar, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: TBVC.tabBarWidth)
        
        self.view?.addConstraints([topConstraints,leftConstraints,bottomConstraints])
        tabBar.addConstraint(widthConstraints)
    }
    
    func initContainer() {
        containerView = UIView()
        containerView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstraints = NSLayoutConstraint(item: containerView, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1, constant: 0)
        
        let leftConstraints = NSLayoutConstraint(item: containerView, attribute: .Left, relatedBy: .Equal, toItem: self.tabBar, attribute: .Right, multiplier: 1, constant: 0)
        
        let bottomConstraints = NSLayoutConstraint(item: containerView, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1, constant: 0)
        
        let rightConstraints = NSLayoutConstraint(item: containerView, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1, constant: 0)
        self.view.addConstraints([topConstraints,leftConstraints,rightConstraints,bottomConstraints])
    }
    
    func setViewcontrollers(views: [UIViewController]) {
        
        self.viewControllers = views
        tabBar.setItemArray(self.viewControllers!)
        self.selectedIndex = 0
        self.selectedViewController = views[0]
//        self.selectedViewController?.view.frame.size = containerSize
        
        let v = selectedViewController!.view
        self.containerView.addSubview(v)
        v.translatesAutoresizingMaskIntoConstraints = false
        let containnerV = NSLayoutConstraint(item: v, attribute: .Width, relatedBy: .Equal, toItem: containerView, attribute: .Width, multiplier: 1, constant: 0)
        let containnerH = NSLayoutConstraint(item: v, attribute: .Height, relatedBy: .Equal, toItem: containerView, attribute: .Height, multiplier: 1, constant: 0)
        let containerTop = NSLayoutConstraint(item: v, attribute: .Top, relatedBy: .Equal, toItem: containerView, attribute: .Top, multiplier: 1, constant: 0)
        let containerLeft = NSLayoutConstraint(item: v, attribute: .Left, relatedBy: .Equal, toItem: containerView, attribute: .Left, multiplier: 1, constant: 0)
        
        containerView.addConstraints([containnerH,containnerV,containerTop, containerLeft])
        tabBar.setSelectIndex(self.selectedIndex!)
        v.layoutIfNeeded()
    }
    
    override func viewWillLayoutSubviews() {
        
    }
    
    func setExtraButtons(buttons: [TBTabBarItem]) {
        self.tabBar.setExtraButtons(buttons)
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
}

extension TBVerticalTabBarController {
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        tabBar.adjustTabBar()
        self.containerView.frame = containerFrame
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
        self.containerView.addSubview((self.selectedViewController?.view)!)
    }
}

protocol TBVerticalTabBarControllerDelegate: NSObjectProtocol {
    
    func VerticalTabBarController(tabBarController: TBVerticalTabBarController, shouldSelectViewController viewController: UIViewController) -> Bool
    
    func VerticalTabBarController(tabBarController: TBVerticalTabBarController, didSelectViewController viewController: UIViewController)
    
    func VerticalTabBarController(tabBarController: TBVerticalTabBarController, didSelectExtralButtonIndex: Int)
    
}