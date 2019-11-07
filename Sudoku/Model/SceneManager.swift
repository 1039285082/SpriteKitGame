//
//  SceneManager.swift
//  Sudoku
//
//  Created by Mac on 26/11/2018.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import SpriteKit
class SceneManager: NSObject {

    static let instance:SceneManager = SceneManager()
    class func sharedSceneManager() -> SceneManager {
        return instance
    }
    
    func selectScene(name:String) -> SKScene {
        
        switch name {
        case "win":
            let scene = GameWinScene()
            
            scene.size = CGSize(width: 2048, height: 2732)
            
            scene.scaleMode = .aspectFill
            
            return scene
        case "game":
            let scene = GameScene()
            
            scene.size = CGSize(width: 2048, height: 2732)
            
            scene.scaleMode = .aspectFill
            
            return scene
        case  "main":
            let scene = MainScene()
            
            scene.size = CGSize(width: 2048, height: 2732)
            
            scene.scaleMode = .aspectFill
            
            return scene
        case "select" :
            let scene = SelectLevel()
            
            scene.size = CGSize(width: 2048, height: 2732)
            
            scene.scaleMode = .aspectFill
            
            return scene
        case "setting" :
            let scene = SettingScene()
            
            scene.size = CGSize(width: 2048, height: 2732)
            
            scene.scaleMode = .aspectFill
            
            return scene
        case "select2" :
            let scene = SelectLevel2()
            
            scene.size = CGSize(width: 2048, height: 2732)
            
            scene.scaleMode = .aspectFill
            
            return scene
            
        default:
            break
        }
        
        return SKScene()
    }
    
    
    
}
