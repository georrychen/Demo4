//
//  YZLMathCourseCollectionCell.swift
//  YZLDemo4
//
//  Created by Xu Chen on 2018/11/6.
//  Copyright © 2018 xu.yzl. All rights reserved.
//  数学课程 cell

import UIKit

class YZLMathCourseCollectionCell: UICollectionViewCell {

    @IBOutlet weak var logo: UIImageView!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var studentLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    lazy var  roundShape= <#expression#>
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        logo.backgroundColor = UIColor.chx_random()
        
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        
    }
    
    func bindViewModel(dict: [String: Any]) {
//        "title": "玩转数据结构91",
//        "picname": "",
//        "price": "95",
//        "studentCount": "250"
        
        let showStudentString = String(format: "%@位学员",(dict["studentCount"] as? String ?? ""))
        let priceString = String(format: "￥%@", dict["price"] as? String ?? "")
        
        titleLabel.text = dict["title"] as? String
        priceLabel.text = priceString
        studentLabel.text = showStudentString
        
        
    print("HHHHHHHHHHHHHHHHHHHHHHHHHHHHH")
        layoutIfNeeded()
        
        // FIXME: chenxu - 滚动视图时，会重复执行，需要修改裁圆角方法
        
        // 只裁剪上边距的圆角
        let rounded = UIBezierPath.init(roundedRect: logo.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize.init(width: 5.0, height: 5.0))
        let shape = CAShapeLayer.init()
        shape.path = rounded.cgPath
        
        logo.layer.mask = shape
    }
    
}
