//
//  YZLFindViewController.swift
//  YZLDemo4
//
//  Created by Xu Chen on 2018/11/5.
//  Copyright © 2018 xu.yzl. All rights reserved.
//

import UIKit

class YZLFindViewController: YZLBaseViewController {

    /// 滚动按钮视图
//    var horizontalButtonsView = YZLHorizontalButtonsView.init(frame: CGRect(x: 0, y: 200, width: kScreenWidth, height: 300), collectionViewLayout: UICollectionViewLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customNavBar.title = "发现"
//        customNavBar.setLeftButton(withTitle: "返回", titleColor: UIColor.white)
    
//        horizontalButtonsView.reloadData()
//        view.addSubview(horizontalButtonsView)
        
        
        
        let collectionView = YZLHorizontalButtonsView.init(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
//        collectionView.viewDelegate = self
//        collectionView.contentInset = UIEdgeInsets(top: kHeaderViewHeight, left: 0, bottom: 0, right: 0)
        view.addSubview(collectionView)
        
    }
    


}
