//
//  YZLHomeHeadView.swift
//  YZLDemo4
//
//  Created by Xu Chen on 2018/11/6.
//  Copyright © 2018 xu.yzl. All rights reserved.
//

import UIKit

class YZLHomeHeadView: UIView, YZLHorizontalButtonsViewDelegate {

    /// 滚动图
    lazy var topScrollView = YZLHomeTopScrollView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 200))
    /// 通知栏
    lazy var topNoticeView = YZLHomeTopNoticeView.noticeView()
    /// 滚动按钮视图
    var horizontalButtonsView: YZLHorizontalButtonsView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = kBgColor
        
        // 1. 添加头部滚动视图
        addSubview(topScrollView)
        
        // 2. 添加头部通知栏视图
        topNoticeView.frame = CGRect(x: 0, y: topScrollView.bounds.height - CGFloat(15), width: self.frame.width, height: CGFloat(44))
        addSubview(topNoticeView)
        
        // 3. 添加横向滚动按钮视图
        let collectionView = YZLHorizontalButtonsView.init(frame: CGRect(x: 0, y: 250, width: kScreenWidth, height: 250), collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.viewDelegate = self
        addSubview(collectionView)
        
        refreshHorizontalButtonsLocalDatas(collectionView: collectionView)
    }

    func refreshHorizontalButtonsLocalDatas(collectionView: YZLHorizontalButtonsView) {
        let jsonFilePath = Bundle.main.path(forResource: "horizontalButtonDatas.json", ofType: nil)
        let jsonData = NSData(contentsOfFile: jsonFilePath!)
        // 加载数据, JSON反序列化数据
        guard let array = try? JSONSerialization.jsonObject(with: (jsonData! as Data) , options: []) as? [[String: Any]]  else {
            return
        }
        
        var arrayM = [YZLHorizontalButtonViewModel]()
        for (index, dict) in array!.enumerated() {
            let viewModel = YZLHorizontalButtonViewModel()
            viewModel.ID = "\(index)"
            viewModel.picName = dict["picname"] as? String
            viewModel.title = dict["title"] as? String
            
            arrayM.append(viewModel)
        }
        
        // 刷新数据
        collectionView.datas = arrayM
    }
    
    
    func YZLHorizontalButtonsViewDidSelected(atindex index: Int, model: YZLHorizontalButtonViewModel) {
        
    }
    
}
