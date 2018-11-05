//
//  UIColor+Extension.swift
//  YZLDemo4
//
//  Created by Xu Chen on 2018/11/5.
//  Copyright © 2018 xu.yzl. All rights reserved.
//

import Foundation

extension UIColor {
    
    /// 随机色
   class func chx_random() -> UIColor {
        let aRedValue: CGFloat = CGFloat(Int(arc4random()) % 255) / CGFloat(255)
        let aGedValue: CGFloat = CGFloat(Int(arc4random()) % 255) / CGFloat(255)
        let aBedValue: CGFloat = CGFloat(Int(arc4random()) % 255) / CGFloat(255)

        let randColor: UIColor = UIColor.init(red: aRedValue, green: aGedValue, blue: aBedValue, alpha: 1)
        return randColor
    }

}

