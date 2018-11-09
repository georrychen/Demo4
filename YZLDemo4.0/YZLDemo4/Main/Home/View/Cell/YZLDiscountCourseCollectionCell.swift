//
//  YZLDiscountCourseCollectionCell.swift
//  YZLDemo4
//
//  Created by Xu Chen on 2018/11/9.
//  Copyright © 2018 xu.yzl. All rights reserved.
//  划算课程 cell

import UIKit

class YZLDiscountCourseCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var tuanLabel: UILabel!
    @IBOutlet weak var originPriceLabel: UILabel!
    
    @IBOutlet weak var buyButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        logoView.backgroundColor = UIColor.chx_random()

        logoView.layer.cornerRadius = 4
        logoView.layer.masksToBounds = true
    }

    func bindViewModel(dict: [String: Any]) {
        
//        "title": "玩转数据结构基础应用2",
//        "picname": "",
//        "price": "199",
//        "originPrice": "228",
//        "isPingtuan": "0",
//        "pingtuanNum": "0",
//        "kanjiaNum": "108",
//        "endTime": "20181202"
        
        let priceString = String(format: "￥%@", dict["price"] as? String ?? "")
        let originPriceString = String(format: "￥%@", dict["originPrice"] as? String ?? "")
        let pingString = String(format: "%@人拼团开启", dict["pingtuanNum"] as? String ?? "")
        let kanjiaString = String(format: "%@人参与砍价", dict["kanjiaNum"] as? String ?? "")
        let isPingtuan = dict["isPingtuan"] as? String ?? "0"

        // 拼团label 要显示的文字
        let tuanShowString = (isPingtuan == "1") ? pingString : kanjiaString
        // 去拼团button 要显示的文字
        let buyButtonString = (isPingtuan == "1") ? "去拼团" : "去砍价"

        titleLabel.text = dict["title"] as? String
        priceLabel.text = priceString
        originPriceLabel.text = originPriceString
        
        tuanLabel.text = tuanShowString
        buyButton.setTitle(buyButtonString, for: .normal)
    }
    
    
}
