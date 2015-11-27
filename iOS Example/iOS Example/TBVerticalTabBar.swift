//
//  TBVerticalTabBar.swift
//  TBVerticalTabBarController
//
//  Created by ChenHao on 11/18/15.
//  Copyright © 2015 HarriesChen. All rights reserved.
//

import UIKit

public class TBVerticalTabBar: UIView {

    private var extraButtonsContainer: UIView = UIView()
    var selectedIndex: Int = 0
    var itemsArray: Array<TBTabBarButton> = []
    var delegate: TBVercicalTabBarProtocol?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setItemArray(items: Array<UIViewController>) {
        let tabBarItems = items.map { viewcontroller in viewcontroller.tabBarItem!}
        var buttonIndex = 0
        for i in 0..<tabBarItems.count {
            // swiftlint:disable force_cast
            let item: TBTabBarItem = tabBarItems[i] as! TBTabBarItem

            let frame: CGRect = CGRect(x: 0.0, y: TBVC.tabBarPaddingDouble + TBVC.tabBarWidthDouble * Double(i), width: TBVC.tabBarWidthDouble, height: TBVC.tabBarWidthDouble)
            let tabBar = TBTabBarButton(frame: frame, index: buttonIndex++)
            tabBar.setTitle(item.title, forState: .Normal)
            tabBar.setImage(item.image, forState: .Normal)
            tabBar.titleLabel?.font = UIFont.systemFontOfSize(14)
            let width: CGFloat = (tabBar.titleLabel?.bounds.size.width)!
            tabBar.imageEdgeInsets = UIEdgeInsetsMake(5,19,5,20)
            tabBar.titleEdgeInsets = UIEdgeInsetsMake(70, -width-39, 0, width)
            tabBar.addTarget(self, action: Selector("tabBarTouch:"), forControlEvents: .TouchUpInside)
            self.itemsArray.append(tabBar)
            self.addSubview(tabBar)
        }
    }

    func setExtraButtons(buttons: Array<TBTabBarItem>) {
        extraButtonsContainer.frame = CGRect(x: 0.0, y: TBVC.heightDouble - TBVC.tabBarWidthDouble * Double(buttons.count) - 30.0, width: TBVC.tabBarWidthDouble, height: TBVC.tabBarWidthDouble * Double(buttons.count))
        self.addSubview(extraButtonsContainer)
        var buttonIndex = 0
        for i in 0..<buttons.count {
            let item: TBTabBarItem = buttons[i]
            let frame: CGRect = CGRect(x: 0.0, y: 20.0 + 78.0 * Double(i), width: 78, height: 78)
            let tabBar = TBTabBarButton(frame: frame, index: buttonIndex++)
            tabBar.setTitle(item.title, forState: .Normal)
            tabBar.setImage(item.image, forState: .Normal)
            tabBar.titleLabel?.font = UIFont.systemFontOfSize(14)
            let width: CGFloat = (tabBar.titleLabel?.bounds.size.width)!
            tabBar.imageEdgeInsets = UIEdgeInsetsMake(5,19,5,20)
            tabBar.titleEdgeInsets = UIEdgeInsetsMake(70, -width-39, 0, width)
            tabBar.addTarget(self, action: Selector("extraButtonTouch:"), forControlEvents: .TouchUpInside)
            extraButtonsContainer.addSubview(tabBar)
        }
        extraButtonsContainer.translatesAutoresizingMaskIntoConstraints = false
        let constrainerBottom = NSLayoutConstraint(item: extraButtonsContainer, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: 0)
        let constrainerLeft = NSLayoutConstraint(item: extraButtonsContainer, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1, constant: 0)
        let constrainerRight = NSLayoutConstraint(item: extraButtonsContainer, attribute: .Right, relatedBy: .Equal, toItem: self, attribute: .Right, multiplier: 1, constant: 0)
        let constrainerHeight = NSLayoutConstraint(item: extraButtonsContainer, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant:CGFloat(78 * buttons.count)+30)
        self.addConstraints([constrainerLeft, constrainerBottom, constrainerRight])
        extraButtonsContainer.addConstraint(constrainerHeight)
        extraButtonsContainer.layoutIfNeeded()
    }

    func setSelectIndex(index: Int) {
        itemsArray[selectedIndex].setSelect(false)
        itemsArray[index].setSelect(true)
    }

    func tabBarTouch(button: TBTabBarButton) {
        if delegate != nil {
            itemsArray[selectedIndex].setSelect(false)
            button.selected = !button.selected
            button.setSelect(button.selected)
            selectedIndex = button.index
            delegate?.tabBar(self, didSelectViewController: button.index)
        }
    }

    func extraButtonTouch(button: TBTabBarButton) {
        if delegate != nil {
            delegate?.tabBar(self, didSelectExtraButton: button.index)
        }
    }

    override public func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetRGBStrokeColor(context, 0.8, 0.8, 0.8, 1)
        CGContextMoveToPoint(context, TBVC.tabBarWidth, 0)
        CGContextAddLineToPoint(context, TBVC.tabBarWidth, TBVC.height)
        CGContextStrokePath(context)
    }
}

protocol TBVercicalTabBarProtocol: NSObjectProtocol {
    /**
     will called after click the button and tell tabBarController to change
     the view controller by index
     - parameter tabBar:        vertical tabBar
     - parameter selectedIndex: the index the click
     */
    func tabBar(tabBar: TBVerticalTabBar, didSelectViewController selectedIndex: Int)
    /**
     will called after click the bottom buttons and tell the delegate to do
     something if they want
     - parameter tabBar:        vertical
     - parameter selectedIndex: the extralButton index
     */
    func tabBar(tabBar: TBVerticalTabBar, didSelectExtraButton selectedIndex: Int)
}
