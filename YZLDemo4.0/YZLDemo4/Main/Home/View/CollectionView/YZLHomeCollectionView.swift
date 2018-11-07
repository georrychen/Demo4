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

/// 热门课程 cell id
let kHotCourseCellId = "hotCourseCellId"
/// 热门直播 cell id
let kHotLivewCellId = "hotLiveCellId"
/// 数学课程 cell id
let kMathCourseCellId = "mathCourseCellId"

class YZLHomeCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var viewDelegate: HomeCollectionViewDelegate?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("collcetionVeiw 释放了")
    }
    
    func configure() {
        backgroundColor = UIColor.chx_random()
        delegate = self
        dataSource = self
        
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        
        // 注册 cell
        register(UINib.init(nibName: "YZLHotCourseCollectionCell", bundle: nil), forCellWithReuseIdentifier: kHotCourseCellId)
        register(UINib.init(nibName: "YZLHotLiveCollectionCell", bundle: nil), forCellWithReuseIdentifier: kHotLivewCellId)
        register(UINib.init(nibName: "YZLMathCourseCollectionCell", bundle: nil), forCellWithReuseIdentifier: kMathCourseCellId)
        
    }
}

extension YZLHomeCollectionView {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kHotCourseCellId, for: indexPath) as! YZLHotCourseCollectionCell
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kHotLivewCellId, for: indexPath) as! YZLHotLiveCollectionCell
            return cell
        case 2, 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kHotCourseCellId, for: indexPath) as! YZLHotCourseCollectionCell
            return cell
        case 4, 5:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMathCourseCellId, for: indexPath) as! YZLMathCourseCollectionCell
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kHotCourseCellId, for: indexPath) as! YZLHotCourseCollectionCell
            return cell
        }
        
    }
    
    
    /// 改变Cell的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width - 40, height: 140)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.frame.size.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        viewDelegate?.collectionViewDidScroll(scrollView: scrollView)
    }
}
