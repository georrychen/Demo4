//
//  YZLHomeHeadSearchView.swift
//  YZLDemo4
//
//  Created by Xu Chen on 2018/11/6.
//  Copyright © 2018 xu.yzl. All rights reserved.
//

import UIKit

class YZLHomeHeadSearchView: UIView {

    /// 搜索框视图
    @IBOutlet weak var searchView: UIView!
    /// 背景视图
    @IBOutlet weak var backgroundView: UIView!
    
    /// 搜索按钮点击闭包
    var clickedSearchButtonClosure: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 圆角
        searchView.layer.masksToBounds = true
        searchView.layer.cornerRadius = 15
        // 添加点击手势
        let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(dismiss))
        searchView.addGestureRecognizer(tapGes)
    }
    
    /// 获取当前类对象
    class func headSearchbarView() -> YZLHomeHeadSearchView {
        let view = Bundle.main.loadNibNamed("YZLHomeHeadSearchView", owner: nil, options: nil)?.first as! YZLHomeHeadSearchView
        view.frame = CGRect(x: 0, y: 0, width: kWindow.bounds.width, height: UIApplication.shared.statusBarFrame.height + 44)
        return view
    }
    
    
    /// 设置背景图透明图
    func setBackgroundAlpha(alpha: CGFloat) {
        backgroundView.alpha = alpha
    }
    
    /// 单击搜索按钮
    @IBAction func clickedSearchButton(_ sender: UIButton) {
        clickedSearchButtonClosure?()
    }
    
    @objc func dismiss() {
        clickedSearchButtonClosure?()
    }
    
}
