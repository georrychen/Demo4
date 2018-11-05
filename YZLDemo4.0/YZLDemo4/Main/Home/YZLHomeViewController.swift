//
//  YZLHomeViewController.swift
//  YZLDemo4
//
//  Created by Xu Chen on 2018/11/5.
//  Copyright © 2018 xu.yzl. All rights reserved.
//

import UIKit

class YZLHomeViewController: YZLBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        customNavBar.title = "首页"
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: NSNotification.Name(rawValue: notification_homeRefresh), object: nil)
    }
    
    @objc func refreshData() {
        print("刷新首页数据")
    }
    
    deinit {
        print("无循环引用")
        
        NotificationCenter.default.removeObserver(self)
    }


}
