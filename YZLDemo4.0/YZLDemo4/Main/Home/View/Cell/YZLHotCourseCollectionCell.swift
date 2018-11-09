//
//  YZLHotCourseCollectionCell.swift
//  YZLDemo4
//
//  Created by Xu Chen on 2018/11/6.
//  Copyright © 2018 xu.yzl. All rights reserved.
//  热门课程 cell

import UIKit

class YZLHotCourseCollectionCell: UICollectionViewCell {

    /// 阴影背景图
    @IBOutlet weak var bgImageView: UIImageView!
    
    /// 课程 logo
    @IBOutlet weak var logoView: UIImageView!
    
    /// 标题
    @IBOutlet weak var titleLabel: UILabel!
    
    /// 子标题
    @IBOutlet weak var subTitleLabel: UILabel!
    
    /// 老师图标
    @IBOutlet weak var tearcherImageView: UIImageView!
    
    /// 老师名
    @IBOutlet weak var tearcherNameLabel: UILabel!
    
    /// 价格
    @IBOutlet weak var priceLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        logoView.backgroundColor = UIColor.chx_random()

        logoView.layer.cornerRadius = 4
        logoView.layer.masksToBounds = true
        
        tearcherImageView.layer.cornerRadius = tearcherImageView.bounds.width / 2.0
        tearcherImageView.layer.masksToBounds = true
        
        let bgImage = UIImage(named: "home_hot_cell_bg")
//        let shadowBgView = UIImage.chx_resizableImage(bgImage!)
        
        let shadowBgView = UIImage.chx_resizableImage(withCapInsets: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4), image: bgImage!)

        bgImageView.image = shadowBgView
    }
    
    
    func bindViewModel(dict: [String: Any]) {
    
//        "title": "玩转数据结构基础4",
//        "subTitle": "从数据结构基础到二叉树、红哈希表，bobo老师精心...",
//        "picname": "",
//        "price": "24",
//        "teacherPic": "",
//        "teacherName": "马冬梅",
//        "studentCount": "666"

        let showStudentString = String(format: "%@ · %@位学员", (dict["teacherName"] as? String ?? ""),(dict["studentCount"] as? String ?? ""))
        
        let priceString = String(format: "￥%@", dict["price"] as? String ?? "")

        titleLabel.text = dict["title"] as? String
        subTitleLabel.text = dict["subTitle"] as? String
        priceLabel.text = priceString
        tearcherNameLabel.text = showStudentString
        
        
    }

}
