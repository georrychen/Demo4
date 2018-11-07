//
//  YZLHomeTopScrollView.swift
//  YZLDemo4
//
//  Created by Xu Chen on 2018/11/7.
//  Copyright © 2018 xu.yzl. All rights reserved.
//  首页头部滚动视图 + pageControll

import UIKit

class YZLHomeTopScrollView: UIView, UIScrollViewDelegate {

    var cycleScrollView = UIScrollView()
    var pageControl =  UIPageControl()
    var timer = Timer()
    
    /// 数据源（模拟）
    var datas = [
        ["title": "标题1", "pic": "home_head_scroll0"],
        ["title": "标题2", "pic": "home_head_scroll0"]
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = kRGBColor_hex(h: 0xF4F7F9)
        
        // 1. 头部滚动视图
        cycleScrollView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: self.frame.height)
        cycleScrollView.backgroundColor = UIColor.chx_random()
        
        // 添加图片
        for (index, dict) in datas.enumerated() {
            let picName = dict["pic"] ?? "home_head_scroll0"
            let imageView_x: CGFloat = CGFloat(index) * cycleScrollView.bounds.width
            let imageView = UIImageView.init(frame: CGRect(x: imageView_x, y: 0, width: cycleScrollView.bounds.width, height: cycleScrollView.bounds.height))
            imageView.image = UIImage(named: picName)
            cycleScrollView.addSubview(imageView)
        }
        
        cycleScrollView.contentSize = CGSize.init(width: cycleScrollView.frame.width * CGFloat(datas.count), height: cycleScrollView.frame.height)
        cycleScrollView.delegate = self
        cycleScrollView.showsVerticalScrollIndicator = false
        cycleScrollView.showsHorizontalScrollIndicator = false
        cycleScrollView.isPagingEnabled = true
        cycleScrollView.bounces = false
        
        addSubview(cycleScrollView)
        
        // 2. pageCotnroll
        let pagecontroll_w = CGFloat(datas.count * 15)
        let pagecontroll_x = self.frame.width - pagecontroll_w - 20
        let pagecontroll_y = self.frame.height - 20 - 20
      
        pageControl.frame = CGRect(origin: CGPoint.init(x: pagecontroll_x, y: pagecontroll_y), size: CGSize(width: pagecontroll_w, height: 20))
        pageControl.pageIndicatorTintColor = kRGBColor_hex(h: 0xC3C4CC)
        pageControl.currentPageIndicatorTintColor = kRGBColor_hex(h: 0xFFFFFF)
        pageControl.addTarget(self, action: #selector(pageControlChanged), for: .valueChanged)
        addSubview(pageControl)
        pageControl.numberOfPages = datas.count
        
    }
    
    
    /// pageControl 触发事件
    @objc func pageControlChanged(pageControl: UIPageControl) {
        let page  = CGFloat(pageControl.currentPage)
        print("当前显示的页 \(page)")
        
        cycleScrollView.contentOffset = CGPoint(x: page * cycleScrollView.frame.width, y: 0)
    }
    
    /// 滚动代理
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x / cycleScrollView.frame.width
        
        pageControl.currentPage = Int(offset)
    }
    

}
