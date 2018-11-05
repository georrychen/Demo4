//
//  Bundle+Extension.swift
//  OnlineSchoolOldDemo(Swift)
//
//  Created by Xu Chen on 2018/8/20.
//  Copyright © 2018年 xu.yzl. All rights reserved.
//

import Foundation

extension Bundle {
    
    /// 命名空间字符串
    var nameSpace: String {
        return  infoDictionary?["CFBundleName"] as? String ?? ""
    }
}
