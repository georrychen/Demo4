//
//  YZLHomeCollectionHeaderView.swift
//  YZLDemo4
//
//  Created by Xu Chen on 2018/11/8.
//  Copyright © 2018 xu.yzl. All rights reserved.
//

import UIKit

class YZLHomeCollectionHeaderView: UICollectionReusableView {
    
    /// 标题
    @IBOutlet weak var titleLabel: UILabel!
    /// 更多
    @IBOutlet weak var moreButton: UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    @IBAction func clickedMoreButton(_ sender: UIButton) {
        
    }
    
    func bindViewModel(viewModel: YZLHomeCollectionHeaderViewModel) {
        titleLabel.text = viewModel.title
        moreButton.setImage(UIImage(named: viewModel.icon), for: .normal)
    }
    
}
