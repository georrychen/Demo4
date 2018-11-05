//
//  YZLMainViewController.swift
//  YZLDemo4
//
//  Created by Xu Chen on 2018/11/5.
//  Copyright © 2018 xu.yzl. All rights reserved.
//  主控制器

import UIKit


class YZLMainViewController: UITabBarController,UITabBarControllerDelegate  {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        tabBarController?.tabBar.delegate = self
        
        addChildControllers()
        setNavigationBarColor()
        addTabbarShadow()
    }

    /// 设置导航栏、tabbar字体颜色
    func setNavigationBarColor() {
        let bar: UINavigationBar = UINavigationBar.appearance()
        bar.barTintColor = kNavbarBgColor
        bar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let item = UIBarButtonItem.appearance()
        let itemAttrs = [NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                         NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
        item.setTitleTextAttributes(itemAttrs, for: .normal)
    }
    
    /// tabbar添加阴影效果，去除分割线
    func addTabbarShadow() {
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.backgroundColor = UIColor.white
        
        shadowPath(withOffset: CGSize(width: 0, height: -0.5),
                   radius: 1,
                   color: kRGBColor_hex(h: 0x8C8C8C),
                   opacity: 0.15)
    }
    
    // 绘制阴影
    ///
    /// - Parameters:
    ///   - offset: 阴影偏移
    ///   - radius: 阴影半径
    ///   - color: 阴影颜色
    ///   - opacity: 阴影透明度
    func shadowPath(withOffset offset: CGSize,
                    radius: CGFloat,
                    color: UIColor,
                    opacity: Float) {
        // 添加路径，优化性能
        let path = CGMutablePath.init()
        path.addRect(tabBar.bounds)
        path.closeSubpath()
        tabBar.layer.shadowPath = path
        
        // 配置 shadow
        tabBar.layer.shadowColor = color.cgColor
        tabBar.layer.shadowOffset = offset
        tabBar.layer.shadowRadius = radius
        tabBar.layer.shadowOpacity = opacity
        
        tabBar.clipsToBounds = false
    }
}

// MARK: - 配置控制器
extension YZLMainViewController {
    
    /// 添加子控制器
    func addChildControllers() {
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let jsonPath = (docDir as NSString).appendingPathComponent("tabbarInfo.json")
        var jsonData = NSData(contentsOfFile: jsonPath)
        if jsonData == nil {
            // 如果本地沙盒没有保存文件，那么就从 Bundle 加载固定的数据
            let path = Bundle.main.path(forResource: "tabbarInfo.json", ofType: nil)
            jsonData = NSData(contentsOfFile: path!)
        }
        
        // 加载数据, JSON 反序列化数据
        guard let array = try? JSONSerialization.jsonObject(with: (jsonData! as Data) , options: []) as? [[String: Any]]  else {
            return
        }
        
        var arrayM = [UIViewController]()
        for dict in array! {
            arrayM.append(loadController(from: dict))
        }
        viewControllers = arrayM
    }
    
    /// 使用字典创建一个控制器
    ///
    /// - Parameter dict: 信息字典（clsName、title、imageName、seletedImageName）
    /// - Returns: 子控制器
    func loadController(from dict: [String: Any]) -> UIViewController {
        
        guard let clsName = dict["clsName"] as? String,
            let title = dict["title"] as? String,
            let imageName = dict["imageName"] as? String,
            let seletedImageName = dict["selectedImageName"] as? String,
            let cls = NSClassFromString(Bundle.main.nameSpace + "." + clsName) as? YZLBaseViewController.Type else {
                return UIViewController()
        }
        
        let aVc = cls.init()
        aVc.title = title
        aVc.tabBarItem.image = UIImage(named: imageName)
        // 设置tabBarItem 的 imageWithRenderingMode 才能显示自定义的图片
        //        aVc.tabBarItem.selectedImage = UIImage(named: seletedImageName)
        // 图片的渲染模式为 alwaysOriginal 时，才可以显示图片的颜色，不然就显示视图的 tintColor 蓝色了
        aVc.tabBarItem.selectedImage = UIImage(named: seletedImageName)?.withRenderingMode(.alwaysOriginal)
        
        // 设置字体
        aVc.tabBarItem.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor : kRGBColor(r: 127, g: 127, b: 127)],
            for: .normal)
        aVc.tabBarItem.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: kRGBColor(r: 63, g: 131, b: 230)],
            for: .selected)
        // 文字相对图片y轴偏移
        aVc.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -3)
        
        let aNav = YZLNavigationController(rootViewController: aVc)
        return aNav
    }
}

extension YZLMainViewController {
    
    /// 点击tabbar item 发送通知
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.title?.elementsEqual("我的") == true {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "tapProfileItem"), object: nil)
        }
    }
    
    /// 双击item，刷新页面
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index: NSInteger = tabBar.items?.firstIndex(of: viewController.tabBarItem) ?? 0
        addAnimationWithIndex(index: index)
        
        // 首页 双击刷新
        if viewController.isEqual(tabBarController.selectedViewController) {
            if (tabBarController.selectedViewController?.isEqual(tabBarController.viewControllers?.first))! {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: notification_homeRefresh), object: nil)
                return false
            }
            
        // 我的 双击刷新
        if (tabBarController.selectedViewController?.isEqual(tabBarController.viewControllers?.last))! {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: notification_profileRefresh), object: nil)
                return false
            }
        }
        
        return true
    }
    
    func addAnimationWithIndex(index: NSInteger) {
        //        NSMutableArray *tabbarbuttonArray = [NSMutableArray array];
        //        for (UIView *tabBarButton in self.tabBar.subviews) {
        //            if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
        //                [tabbarbuttonArray addObject:tabBarButton];
        //            }
        //        }
        //        [NNAnimation addAnimationWithCALayer:[tabbarbuttonArray[index] layer] interval:0.1 repeatCount:2 fromValue:0.95 toValue:1.05];
        var tabbarbuttonArray = [UIView]()
        for tabBarButton: UIView in tabBar.subviews {
            if tabBarButton.isKind(of: NSClassFromString("UITabBarButton")!) {
                tabbarbuttonArray.append(tabBarButton)
            }
        }
        NNAnimation.add(with: tabbarbuttonArray[index].layer, interval: 0.1, repeatCount: 2, fromValue: 0.95, toValue: 1.05)
        
    }
}


//- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
//
//    NSInteger integet = [self.tabBar.items indexOfObject:viewController.tabBarItem];
//    [self addAnimationWithIndex:integet];
//    if ([viewController isEqual:tabBarController.selectedViewController]) {
//        if ([tabBarController.selectedViewController isEqual:[tabBarController.viewControllers firstObject]]) {
//            //            [[NSNotificationCenter defaultCenter] postNotificationName:NNHomeViewBackToTop object:nil];
//            return NO;
//        }
//        if ([tabBarController.selectedViewController isEqual:tabBarController.viewControllers[1]]) {
//            //            [[NSNotificationCenter defaultCenter] postNotificationName:NNLearnViewBackToTop object:nil];
//            return NO;
//        }
//    }
//    return YES;
//    }
//
//    /**
//     点击 tabbarItem 缩放动画
//     */
//    - (void)addAnimationWithIndex:(NSInteger)index {
//        NSMutableArray *tabbarbuttonArray = [NSMutableArray array];
//        for (UIView *tabBarButton in self.tabBar.subviews) {
//            if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
//                [tabbarbuttonArray addObject:tabBarButton];
//            }
//        }
//        [NNAnimation addAnimationWithCALayer:[tabbarbuttonArray[index] layer] interval:0.1 repeatCount:2 fromValue:0.95 toValue:1.05];
//}
