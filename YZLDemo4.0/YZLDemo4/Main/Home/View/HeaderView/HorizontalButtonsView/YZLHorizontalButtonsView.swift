//
//  YZLHorizontalButtonsView.swift
//  YZLDemo4
//
//  Created by Xu Chen on 2018/11/7.
//  Copyright © 2018 xu.yzl. All rights reserved.
//  横向滚动按钮 collectionView

import UIKit

protocol YZLHorizontalButtonsViewDelegate {
    /// item 选中回调
    ///
    /// - Parameters:
    ///   - index: 序号
    ///   - model: model
    func YZLHorizontalButtonsViewDidSelected(atindex index: Int, model: YZLHorizontalButtonViewModel)
}


/// 热门课程 cell id
let kHorizontalCollectionCellId = "horizontalCollectionCellId7"

class YZLHorizontalButtonsView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    /// 代理
    var viewDelegate: YZLHorizontalButtonsViewDelegate?
    
    /// 数据源
    var datas = [YZLHorizontalButtonViewModel]() {
        didSet {
            self.reloadData()
        }
    }
    
    /// 初始化
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
      
        // 定义collectionView的布局类型，流布局
        let flowLayout = UICollectionViewFlowLayout()
        // 设置cell的大小
        flowLayout.itemSize = CGSize(width: 60, height: 75)
        // 每个Item之间最小的间距
        flowLayout.minimumInteritemSpacing = 20
        // 每行之间最小的间距
        flowLayout.minimumLineSpacing = 15
        // 分区边距
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 10, right: 30)
        
        super.init(frame: frame, collectionViewLayout: flowLayout)

        config()
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("YZLHorizontalButtonsView 释放了")
    }
    
    /// 配置 collcetionView
    func config() {
        delegate = self
        dataSource = self
        backgroundColor = UIColor.clear
        
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        
        // 注册 cell
        register(UINib.init(nibName: "YZLHorizontalCollectionCell", bundle: nil), forCellWithReuseIdentifier: kHorizontalCollectionCellId)
    }

}


// MARK: - 代理方法
extension YZLHorizontalButtonsView {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kHorizontalCollectionCellId, for: indexPath) as! YZLHorizontalCollectionCell
//        cell.backgroundColor = UIColor.chx_random()
        let viewModel = datas[indexPath.item]
        cell.bindViewModel(viewModel: viewModel)
        return cell
    }


}
