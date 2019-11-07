//
//  InfoManager.swift
//  Sudoku
//
//  Created by Mac on 28/11/2018.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

class InfoManager: NSObject {

      public let userDataSource = "\(NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!)/userDataSource.data"
    
    public let playRect = CGRect(x: (2048 - 2732*CGFloat(UIScreen.main.bounds.size.width/UIScreen.main.bounds.size.height))/2, y: 0, width: 2048-2 * (2048 - 2732*CGFloat(UIScreen.main.bounds.size.width/UIScreen.main.bounds.size.height))/2, height: 2732)
    
    static let instance:InfoManager = InfoManager()
    
    class func sharedInfoManager() -> InfoManager {
        return instance
    }
    
    func saveSuccessEasy() ->String {
        let successEasy = "\(NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!)/successEasyArr.data"
        
        return successEasy
    }
    func saveSuccessAdvanced() ->String {
        let successAdvanced = "\(NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!)/successAdvancedArr.data"
        
        return successAdvanced
    }
    func saveSuccessDifficulty() ->String {
        let successDifficulty = "\(NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!)/successDifficultyArr.data"
        
        return successDifficulty
    }
    func saveSuccessExpert() ->String {
        let successExpert = "\(NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!)/successExpertArr.data"
        
        return successExpert
    }
    func saveSuccessCrazy() ->String {
        let successCrazy = "\(NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!)/successCrazyArr.data"
        
        return successCrazy
    }
    
    func initPlayRect(width:CGFloat,height:CGFloat) -> CGRect {
        
        let rect =  CGRect(x: (width - height*CGFloat(UIScreen.main.bounds.size.width/UIScreen.main.bounds.size.height))/2, y: 0, width: width-2 * (width - height*CGFloat(UIScreen.main.bounds.size.width/UIScreen.main.bounds.size.height))/2, height: height)
        
        return rect
    }
}
