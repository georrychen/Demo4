//
//  AppDelegate.swift
//  YZLDemo4
//
//  Created by Xu Chen on 2018/11/5.
//  Copyright © 2018 xu.yzl. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()
        window?.backgroundColor = UIColor.white
        window?.rootViewController = loadRootViewController()
        window?.makeKeyAndVisible()
       
        application.statusBarStyle = .lightContent

        configureTabbarJsonData()
        
        return true
    }

}


extension AppDelegate {
    
    /// 获取根视图控制器
    ///
    /// - Returns: rootCtl
    func loadRootViewController() -> UIViewController {
        let lastVersion: String = UserDefaults.standard.object(forKey: "lastVersionString") as? String ?? ""
        let currentVersion: String = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String ?? ""
        print("版本对比: - \(lastVersion) - \(currentVersion)")

        if currentVersion.elementsEqual(lastVersion) {
            return YZLMainViewController()
        } else { // 版本号不同，显示欢迎页
            UserDefaults.standard.set(currentVersion, forKey: "lastVersionString")
            UserDefaults.standard.synchronize()
            
            return YZLWelcomeController()
        }
    }
    
    /// 配置 tabbarController 数据
    func configureTabbarJsonData() {
        let jsonUrl = Bundle.main.url(forResource: "tabbarInfo.json", withExtension: nil)
        let jsonData = NSData(contentsOf: jsonUrl!)
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let jsonPath = (docDir as NSString).appendingPathComponent("tabbarInfo.json")
        let writeSucceed = jsonData?.write(toFile: jsonPath, atomically: true)
        
        if writeSucceed == true {
            print("tabbar 信息加载完毕 \(jsonPath)")
        }
    }
    
}
