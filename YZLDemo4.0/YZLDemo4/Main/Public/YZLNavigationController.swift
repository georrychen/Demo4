//
//  YZLNavigationController.swift
//  YZLDemo4
//
//  Created by Xu Chen on 2018/11/5.
//  Copyright © 2018 xu.yzl. All rights reserved.
//

import UIKit

class YZLNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 隐藏系统导航栏
        navigationBar.isHidden = true
        // 导航栏不透明
        navigationBar.isTranslucent = false
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: true)
    }

}
