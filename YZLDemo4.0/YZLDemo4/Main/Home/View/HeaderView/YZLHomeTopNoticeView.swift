//
//  YZLHomeTopNoticeboardView.swift
//  YZLDemo4
//
//  Created by Xu Chen on 2018/11/7.
//  Copyright © 2018 xu.yzl. All rights reserved.
//

import UIKit

class YZLHomeTopNoticeView: UIView {

    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 设置背景图，不别拉伸. 不起作用？
//        var image = UIImage(named: "home_top_notice_bg")
//        image = UIImage.chx_resizableImage(image!)
//        backgroundImageView.image = image
        

        setBgViewShadowPath()
    }
    

    /// 设置背景图圆角阴影边框
    func setBgViewShadowPath() {
        // 阴影
        backgroundImageView.layer.shadowColor = UIColor.init(red: 115.0/255.0, green: 115.0/255.0, blue: 115.0/255.0, alpha: 0.1).cgColor
        backgroundImageView.layer.shadowOffset = CGSize(width: 0, height: 4)
        backgroundImageView.layer.shadowOpacity = 1
        backgroundImageView.layer.shadowRadius = 9
        
        // 边框
        backgroundImageView.layer.borderWidth = 0.5
        backgroundImageView.layer.borderColor = UIColor.init(red: 219.0/255.0, green: 219.0/255.0, blue: 219.0/255.0, alpha: 0.2).cgColor
        
        // 圆角
        backgroundImageView.layer.cornerRadius = 5
    }
    
    
    class func noticeView() -> YZLHomeTopNoticeView {
        let view = Bundle.main.loadNibNamed("YZLHomeTopNoticeView", owner: self, options: nil)?.first as! YZLHomeTopNoticeView
        return view
    }
    
}
