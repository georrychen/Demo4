//
//  YZLBaseViewController.swift
//  YZLDemo4
//
//  Created by Xu Chen on 2018/11/5.
//  Copyright © 2018 xu.yzl. All rights reserved.
//  基类控制器

import UIKit

class YZLBaseViewController: UIViewController {

    /// 自定义导航栏
    lazy var customNavBar = YZLCustomNavBarView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: (44 + (UIApplication.shared.statusBarFrame.height))))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCustomNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = UIColor.chx_random()
    }
    
    func configureCustomNavigationBar() {
        customNavBar.barBackgroundColor = kNavbarBgColor
        customNavBar.titleLabelColor = UIColor.white
//        customNavBar.isHidden = true
        
        view.addSubview(customNavBar)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
