//
//  DataSource.swift
//  Sudoku
//
//  Created by Mac on 21/11/2018.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

class DataSource: NSObject,NSCoding {
   

    var BackMusic:Bool = true
    var backgroundVideoName:String = "bj_1_fugu"
    var selectViewBg:String = "bj_1_fugu"
    var mainBtnImg:String = "shouye_mukuai_fugu"
    var lockBtnImg:String = "suo_select_fugu"
    var unlockBtnImg:String = "zhengchang_select_fugu"
    var gameBlockImg:String = "mukuai_fugu_view"
    var gameDiamondsImg:String = "juxing_fugu_view"
    var gameSuccessMenuBtn:String = "caidan_fugu"
    var gameSuccessNextBtn:String = "next_fugu"
    var gameFailureRestartBtn:String = "chong_fugu"
    var stop:String = "stop_1"
    
    var pausedViewStart:String = "kaishi_wood"
    var pausedViewRestart:String = "chongwan_wood"
    var pausedViewMenu:String = "caidan_wood"
    var backGroundMusic:String = "fugu.mp3"
    
    
    
    
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(BackMusic, forKey: "BackMusic")
        aCoder.encode(backgroundVideoName, forKey: "backgroundVideoName")
         aCoder.encode(selectViewBg, forKey: "selectViewBg")
        aCoder.encode(mainBtnImg, forKey: "mainBtnImg")
        aCoder.encode(lockBtnImg, forKey: "lockBtnImg")
        aCoder.encode(unlockBtnImg, forKey: "zhengchang_select_fugu")
        aCoder.encode(gameBlockImg, forKey: "gameBlockImg")
        aCoder.encode(gameDiamondsImg, forKey: "gameDiamondsImg")
        aCoder.encode(gameSuccessMenuBtn, forKey: "gameSuccessMenuBtn")
        aCoder.encode(gameSuccessNextBtn, forKey: "gameSuccessNextBtn")
        aCoder.encode(gameFailureRestartBtn, forKey: "gameFailureRestartBtn")
        aCoder.encode(stop, forKey: "stop")
        aCoder.encode(pausedViewStart, forKey: "pausedViewStart")
        aCoder.encode(pausedViewRestart, forKey: "pausedViewRestart")
        aCoder.encode(pausedViewMenu, forKey: "pausedViewMenu")
        aCoder.encode(backGroundMusic, forKey: "backGroundMusic")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        BackMusic = aDecoder.decodeBool(forKey: "BackMusic")
        backgroundVideoName = aDecoder.decodeObject(forKey: "backgroundVideoName") as! String 
        selectViewBg = aDecoder.decodeObject(forKey: "selectViewBg") as! String
        mainBtnImg = aDecoder.decodeObject(forKey: "mainBtnImg") as! String
        lockBtnImg = aDecoder.decodeObject(forKey: "lockBtnImg") as! String
        unlockBtnImg = aDecoder.decodeObject(forKey: "zhengchang_select_fugu") as! String
        gameBlockImg = aDecoder.decodeObject(forKey: "gameBlockImg") as! String
        gameDiamondsImg = aDecoder.decodeObject(forKey: "gameDiamondsImg") as! String
        gameSuccessMenuBtn = aDecoder.decodeObject(forKey: "gameSuccessMenuBtn") as! String
        gameSuccessNextBtn = aDecoder.decodeObject(forKey: "gameSuccessNextBtn") as! String
        gameFailureRestartBtn = aDecoder.decodeObject(forKey: "gameFailureRestartBtn") as! String
        stop = aDecoder.decodeObject(forKey: "stop") as! String
        pausedViewStart = aDecoder.decodeObject(forKey: "pausedViewStart") as! String
        pausedViewRestart = aDecoder.decodeObject(forKey: "pausedViewRestart") as! String
        pausedViewMenu = aDecoder.decodeObject(forKey: "pausedViewMenu") as! String
        backGroundMusic = aDecoder.decodeObject(forKey: "backGroundMusic") as! String
    }
    
    
  
    override init() {
        super.init()
    }
    
}

