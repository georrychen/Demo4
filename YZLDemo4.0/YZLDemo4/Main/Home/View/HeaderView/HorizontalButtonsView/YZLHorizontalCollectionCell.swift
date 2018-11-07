//
//  YZLHorizontalCollectionCell.swift
//  YZLDemo4
//
//  Created by Xu Chen on 2018/11/7.
//  Copyright © 2018 xu.yzl. All rights reserved.
//

import UIKit

class YZLHorizontalCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bindViewModel(viewModel: YZLHorizontalButtonViewModel) {
        title.text = viewModel.title
        imageView.image = UIImage(named: viewModel.picName ?? "")
    }

}
