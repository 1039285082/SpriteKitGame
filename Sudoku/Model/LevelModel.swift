//
//  LevelModel.swift
//  Sudoku
//
//  Created by Mac on 11/12/2018.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

class LevelModel: NSObject,NSCoding{
    
    //是否通关
    var whetherSuccess = Bool()
    //难度系数
    var difficulLevel:Int?
    //当前关卡
    var currentLevel:Int?
    //通关时间
    var successTime = String()
    
    
    

    func encode(with aCoder: NSCoder) {

        aCoder.encode(whetherSuccess, forKey: "whetherSuccess")
        aCoder.encode(difficulLevel, forKey: "difficulLevel")
        aCoder.encode(currentLevel, forKey: "currentLevel")
        aCoder.encode(successTime, forKey: "successTime")
    }

    required init?(coder aDecoder: NSCoder) {

       whetherSuccess = aDecoder.decodeBool(forKey: "whetherSuccess")
        difficulLevel = aDecoder.decodeObject(forKey: "difficulLevel") as? Int
        currentLevel = aDecoder.decodeObject(forKey: "currentLevel") as? Int
        successTime = aDecoder.decodeObject(forKey: "successTime") as! String
    }
    override init() {
        super.init()
    }
    
}
