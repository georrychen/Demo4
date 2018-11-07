//
//  YZLHomeViewController.swift
//  YZLDemo4
//
//  Created by Xu Chen on 2018/11/5.
//  Copyright © 2018 xu.yzl. All rights reserved.
//

import UIKit

class YZLHomeViewController: YZLBaseViewController, HomeCollectionViewDelegate {

    /// 头部视图总高度
    let kHeaderViewHeight: CGFloat = 500

    /// 修改导航栏透明度的临界点
    let kNavigationbarChangeAlphaLimitHeight: CGFloat = 100
    

    /// 头部视图
    lazy var myHeadView = YZLHomeHeadView.init(frame: CGRect(x: 0, y: -kHeaderViewHeight, width: view.bounds.width, height: kHeaderViewHeight))
    /// 头部搜索栏
    lazy var headSearchBarView = YZLHomeHeadSearchView.headSearchbarView()
    /// 搜索视图
    lazy var searchView = YZLSearchView.searchView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        customNavBar.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: NSNotification.Name(rawValue: notification_homeRefresh), object: nil)
        
        setupUI()
    }
    
    func setupUI() {
        let collectionView = YZLHomeCollectionView.init(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.viewDelegate = self
        collectionView.contentInset = UIEdgeInsets(top: kHeaderViewHeight, left: 0, bottom: 0, right: 0)
        view.addSubview(collectionView)

        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        // 添加头部视图
        collectionView.addSubview(myHeadView)

        // 添加导航搜索栏
        headSearchBarView.clickedSearchButtonClosure = { [weak self] ()->() in
            print("点击了搜索")
            self?.searchView.pop()
        }
        view.addSubview(headSearchBarView)
    }
    
    
    
    @objc func refreshData() {
        print("刷新首页数据")
    }
    
    deinit {
        print("无循环引用")
        
        NotificationCenter.default.removeObserver(self)
    }


}

// MARK: - HomeCollectionViewDelegate
extension YZLHomeViewController {
    
    func collectionViewDidScroll(scrollView: UIScrollView) {
        // 滚动偏移位置(从 0 开始，这里加上 kHeaderViewHeight，是因为collection刚开始创建的时候，就向下偏移了 kHeaderViewHeight 高度，加上正好为 0)
        let offsetY = scrollView.contentOffset.y + kHeaderViewHeight
        
        print("滚动偏移位置： \(offsetY)")

        // 1. 修改导航栏透明度
        if (offsetY > kNavigationbarChangeAlphaLimitHeight) {
            let alpha: CGFloat = (offsetY - kNavigationbarChangeAlphaLimitHeight) / kNavigationBarHeight
            print("透明度 = \(alpha)")
            if alpha <= 1 {
                self.headSearchBarView.setBackgroundAlpha(alpha: alpha)
            }
        } else {
            self.headSearchBarView.setBackgroundAlpha(alpha: 0)
        }
        
        
        
        
    }
   
    
}
