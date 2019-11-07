//
//  LevelArrModel.swift
//  Sudoku
//
//  Created by Mac on 12/12/2018.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

class LevelArrModel: NSObject,NSCoding{

    var ModelArr = Array<LevelModel>()
    
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(ModelArr, forKey: "ModelArr")
    }
    
    required init?(coder aDecoder: NSCoder) {
        ModelArr = aDecoder.decodeObject(forKey: "ModelArr") as! Array<LevelModel>
    }
    override init() {
        super.init()
    }
}
