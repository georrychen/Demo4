//
//  YZLHotLiveCollectionCell.swift
//  YZLDemo4
//
//  Created by Xu Chen on 2018/11/6.
//  Copyright © 2018 xu.yzl. All rights reserved.
//  热门直播

import UIKit

class YZLHotLiveCollectionCell: UICollectionViewCell {

    /// 阴影背景图
    @IBOutlet weak var bgShadowImageView: UIImageView!
    /// logo 图
    @IBOutlet weak var logoView: UIImageView!
    /// 时长
    @IBOutlet weak var durationLabel: UIButton!
    /// 标题
    @IBOutlet weak var titleLabel: UILabel!
    /// 预约人数
    @IBOutlet weak var orderNumLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        logoView.backgroundColor = UIColor.chx_random()

        logoView.layer.cornerRadius = logoView.bounds.width / 2.0
        logoView.layer.masksToBounds = true

    }
    
    
    @IBAction func watchLiveButtonClicked(_ sender: UIButton) {
        
    }
    
    func bindViewModel(dict: [String: Any]) {
        
//        "title": "初中英语第三课第二讲",
//        "picname": "",
//        "teacherPic": "",
//        "duration": "15:00",
//        "studentCount": "153"
        
        let orderNumString = String(format: "%@人预约", (dict["studentCount"] as? String ?? ""))
        
        titleLabel.text = dict["title"] as? String
        orderNumLabel.text = orderNumString
        
    }
    
}
