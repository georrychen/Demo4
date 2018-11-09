//
//  YZLHomeViewModel.swift
//  YZLDemo4
//
//  Created by Xu Chen on 2018/11/9.
//  Copyright © 2018 xu.yzl. All rights reserved.
//

import UIKit

class YZLHomeViewModel: NSObject {

    /// 加载本地分区头视图 数据
    func loadLocalSectionHeaderDatas() -> [YZLHomeCollectionHeaderViewModel] {
        var headerDatas = [YZLHomeCollectionHeaderViewModel]()
        
        // 分区头视图数据源
        let jsonFilePath = Bundle.main.path(forResource: "homeHeaderData.json", ofType: nil)
        let jsonData = NSData(contentsOfFile: jsonFilePath!)
        // 加载数据, JSON反序列化数据
        guard let array = try? JSONSerialization.jsonObject(with: (jsonData! as Data) , options: []) as? [[String: Any]]  else {
            return headerDatas
        }
        
        for (index, dict) in array!.enumerated() {
            let viewModel = YZLHomeCollectionHeaderViewModel()
            viewModel.index = index
            viewModel.icon = dict["icon"] as! String
            viewModel.title = dict["title"] as! String
            
            headerDatas.append(viewModel)
        }
        return headerDatas
    }
    

    
    /// 加载本地列表数据源
    func loadLocalListDatas() -> [[[String: Any]]] {
        var datas = [[[String: Any]]]()
        
        let discountData = localJosnArray(with: "homeData_discount")
        let hotliveData = localJosnArray(with: "homeData_hotlive")
        let hotCourseData = localJosnArray(with: "homeData_hotCourse")
        let mathData = localJosnArray(with: "homeData_math")
        let chineseData = localJosnArray(with: "homeData_chinese")
        let choiceData = localJosnArray(with: "homeData_choice")
        
        datas.append(discountData)
        datas.append(hotliveData)
        datas.append(choiceData)
        datas.append(hotCourseData)
        datas.append(chineseData)
        datas.append(mathData)
        
        return datas
    }
    
    
    
    func localJosnArray(with name: String) -> [[String: Any]] {
        // 数据源
        let jsonFilePath = Bundle.main.path(forResource: name, ofType: "json")
        let jsonData = NSData(contentsOfFile: jsonFilePath!)
        
        // 加载数据, JSON反序列化数据
        guard let array = try? JSONSerialization.jsonObject(with: (jsonData! as Data) , options: []) as? [[String: Any]]  else {
            
            return [[String: Any]]()
        }
        return array ?? [[String: Any]]()
    }
    
}
