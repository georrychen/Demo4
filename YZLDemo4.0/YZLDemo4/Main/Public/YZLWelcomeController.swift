//
//  YZLWelcomeController.swift
//  YZLDemo4
//
//  Created by Xu Chen on 2018/11/5.
//  Copyright © 2018 xu.yzl. All rights reserved.
//

import UIKit

/// 欢迎页
class YZLWelcomeController: YZLBaseViewController {
    
    private lazy var contentScrollView: UIScrollView = UIScrollView()
    let kNewfeatureCount = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

private extension YZLWelcomeController {
    func setupUI() {
        contentScrollView.frame = view.bounds
        contentScrollView.contentSize = CGSize(width: kScreenWidth * CGFloat(kNewfeatureCount), height: 0)
        contentScrollView.bounces = false
        contentScrollView.isPagingEnabled = true
        contentScrollView.showsVerticalScrollIndicator = false
        contentScrollView.showsHorizontalScrollIndicator = false
        
        view.addSubview(contentScrollView)
        
        for number in 0..<kNewfeatureCount {
            print(number)
            
            let imageView = UIImageView()
            imageView.frame = CGRect(x: CGFloat(number) * contentScrollView.frame.size.width, y: 0, width: contentScrollView.frame.size.width, height: contentScrollView.frame.size.height)
            let imageName = "引导页" + "\(number + 1)"
            imageView.image = UIImage(named: imageName)
            
            contentScrollView.addSubview(imageView)
            
            // 最后一页，添加点击事件
            if number == (kNewfeatureCount - 1)  {
                imageView.isUserInteractionEnabled = true
                let tapGes = UITapGestureRecognizer(target: self, action: #selector(startClicked))
                imageView.addGestureRecognizer(tapGes)
            }
        }
    }
    
    @objc func startClicked() {
        UIView.animate(withDuration: 0.15, animations: {
            self.view.alpha = 0
        }) { (_) in
            UIApplication.shared.keyWindow!.rootViewController = YZLMainViewController()
        }
    }
    
}
