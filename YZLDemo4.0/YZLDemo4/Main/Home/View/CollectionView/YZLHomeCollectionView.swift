//
//  YZLHomeCollectionView.swift
//  YZLDemo4
//
//  Created by Xu Chen on 2018/11/6.
//  Copyright © 2018 xu.yzl. All rights reserved.
//

import UIKit

protocol HomeCollectionViewDelegate {
    /// 滚动
    func collectionViewDidScroll(scrollView: UIScrollView)
}

/// 划算课程 cell id
let kDiscountCourseCellId = "discountCourseCellId"
/// 热门课程 cell id
let kHotCourseCellId = "hotCourseCellId"
/// 热门直播 cell id
let kHotLivewCellId = "hotLiveCellId"
/// 数学课程 cell id
let kMathCourseCellId = "mathCourseCellId"
/// headerView id
let kHeaderViewlId = "headerViewlId"



class YZLHomeCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    /// 代理
    var viewDelegate: HomeCollectionViewDelegate?
    
    /// 分区头视图 model 数组
    var headerViewData: [YZLHomeCollectionHeaderViewModel]?
    /// 列表数据源
    var listDataArray = [[[String: Any]]]() {
        didSet {
            reloadData()
        }
    }
    
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        // 定义collectionView的布局类型，流布局
        let flowLayout = UICollectionViewFlowLayout()
        // 每个Item之间最小的间距
        flowLayout.minimumInteritemSpacing = 10
        // 每行之间最小的间距
        flowLayout.minimumLineSpacing = 10
        // 分区边距
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        super.init(frame: frame, collectionViewLayout: flowLayout)
        
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("collcetionVeiw 释放了")
    }
    
    func configure() {
        backgroundColor = kBgColor
        delegate = self
        dataSource = self
        
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        
        // 注册 cell
        register(UINib.init(nibName: "YZLDiscountCourseCollectionCell", bundle: nil), forCellWithReuseIdentifier: kDiscountCourseCellId)
        register(UINib.init(nibName: "YZLHotCourseCollectionCell", bundle: nil), forCellWithReuseIdentifier: kHotCourseCellId)
        register(UINib.init(nibName: "YZLHotLiveCollectionCell", bundle: nil), forCellWithReuseIdentifier: kHotLivewCellId)
        register(UINib.init(nibName: "YZLMathCourseCollectionCell", bundle: nil), forCellWithReuseIdentifier: kMathCourseCellId)
        // 注册 headerView
        register(UINib.init(nibName: "YZLHomeCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: "UICollectionElementKindSectionHeader", withReuseIdentifier: kHeaderViewlId)
    }
}

extension YZLHomeCollectionView {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return listDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listDataArray[section].count
    }
    
    /// 设置不同种类的 Cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 每个分区的数据源
        let sectionArray = listDataArray[indexPath.section]
        
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kDiscountCourseCellId, for: indexPath) as! YZLDiscountCourseCollectionCell
            
            // 这里应该是用 viewMoel , 这里暂时用字典处理一下
            cell.bindViewModel(dict: sectionArray[indexPath.row])
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kHotLivewCellId, for: indexPath) as! YZLHotLiveCollectionCell
            // 这里应该是用 viewMoel , 这里暂时用字典处理一下
            cell.bindViewModel(dict: sectionArray[indexPath.row])
            
            return cell
        case 2, 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kHotCourseCellId, for: indexPath) as! YZLHotCourseCollectionCell
            // 这里应该是用 viewMoel , 这里暂时用字典处理一下
            cell.bindViewModel(dict: sectionArray[indexPath.row])
            
            return cell
        case 4, 5:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMathCourseCellId, for: indexPath) as! YZLMathCourseCollectionCell
            // 这里应该是用 viewMoel , 这里暂时用字典处理一下
            cell.bindViewModel(dict: sectionArray[indexPath.row])
            
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kHotCourseCellId, for: indexPath) as! YZLHotCourseCollectionCell
            // 这里应该是用 viewMoel , 这里暂时用字典处理一下
            cell.bindViewModel(dict: sectionArray[indexPath.row])
            
            return cell
        }
    
    }
    
    /// 设置分区头、分区尾
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == "UICollectionElementKindSectionHeader" {
            let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewlId, for: indexPath) as! YZLHomeCollectionHeaderView
            let viewModel = headerViewData?[indexPath.section] ?? YZLHomeCollectionHeaderViewModel()
            reusableView.bindViewModel(viewModel: viewModel)
            
            return reusableView
        } else {
            return UICollectionReusableView()
        }
    }
    
    /// Cell的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 1:
            return CGSize(width: self.frame.width, height: 180)
        case 4,5:
            return CGSize(width: kScreenWidth * 0.5 - 15, height: 175)

        default:
            return CGSize(width: self.frame.width, height: 150)
        }
    }
    

    /// 分区头视图高度
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.frame.size.width, height: kHomeCollectionSectionHeaderHeight)
    }
    
//    /// 分区偏移尺寸
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//
//        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
//    }
    
    
    /// 列表滚动代理
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        viewDelegate?.collectionViewDidScroll(scrollView: scrollView)
    }
    
    
}
