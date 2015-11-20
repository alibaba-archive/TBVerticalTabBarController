//
//  TBVerticalItem.swift
//  TBVerticalTabBarController
//
//  Created by ChenHao on 11/18/15.
//  Copyright © 2015 HarriesChen. All rights reserved.
//

import UIKit

class TBTabBarButton: UIButton {

    var index: Int
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        index = 0
        super.init(frame: frame)
        self.commonInit()
    }
    
    convenience init(frame: CGRect, index:Int) {
        self.init(frame: frame)
        self.index = index
    }
    
    func commonInit() {
        self.setTitleColor(UIColor(red: 28/255.0, green: 136/255.0, blue: 1, alpha: 1), forState: .Selected)
        self.setTitleColor(UIColor.grayColor(), forState: .Normal)
        
        setSelect(false)
    }
    
    func setSelect(isSelected: Bool) {
        
        if isSelected {
            self.tintColor = UIColor(red: 28/255.0, green: 136/255.0, blue: 1, alpha: 1)
            self.selected = true
        } else {
            self.tintColor = UIColor.grayColor()
            self.selected = false
        }
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
