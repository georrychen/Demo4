//
//  YZLSearchView.swift
//  YZLDemo4
//
//  Created by Xu Chen on 2018/11/7.
//  Copyright © 2018 xu.yzl. All rights reserved.
//

import UIKit


class YZLSearchView: UIView {

    /// 搜索框
    @IBOutlet weak var searchTextField: UITextField!
    
    /// 按钮点击闭包
    var buttonClickedClosure: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 设置圆角
        searchTextField.layer.masksToBounds = true
        searchTextField.layer.cornerRadius = 15
                
        self.addSearchLeftView()
    }
    
    /// 添加搜索栏左侧搜索图标
    func addSearchLeftView() {
        let leftIconButton = UIButton(type: .custom)
        leftIconButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        leftIconButton.setImage(UIImage(named: "home_search_icon"), for: .normal)
        
        searchTextField.leftViewMode = .always
        searchTextField.leftView = leftIconButton
    }
    
    /// 获取当前类对象
    class func searchView() -> YZLSearchView {
        let view = Bundle.main.loadNibNamed("YZLSearchView", owner: nil, options: nil)?.first as! YZLSearchView
        view.frame = (UIApplication.shared.keyWindow?.bounds)!
        return view
    }
    
    /// 点击取消
    @IBAction func cancelButtonClicked(_ sender: UIButton) {
        dismiss()
        buttonClickedClosure?()
    }
    
}

extension YZLSearchView {
    
    /// 弹窗
    func pop() {
        let duration = 0.15
        UIView.animate(withDuration: duration, delay: 0.1, options: UIView.AnimationOptions.curveLinear, animations: {
            self.alpha = 1
        }) { (_) in
            self.searchTextField.becomeFirstResponder()
            kWindow.addSubview(self)
        }
    }
    
    /// 消失
    func dismiss() {
//        let duration = 0.15
//        UIView.animate(withDuration: duration, delay: 0.1, options: UIView.AnimationOptions.curveLinear, animations: {
//            self.alpha = 0
//        }) { (_) in
            self.removeFromSuperview()
//        }
    }
    
}
