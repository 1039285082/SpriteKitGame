//
//  GameWinScene.swift
//  Sudoku
//
//  Created by Mac on 22/11/2018.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import SpriteKit
class GameWinScene: SKScene {

    override func didMove(to view: SKView) {
        
        let success = SKSpriteNode(imageNamed: "guoguan_mountain")
        success.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        success.size = CGSize(width: self.size.width-60, height: self.size.height/3)
        
        let next = SKSpriteNode(imageNamed: "next_fugu")
        
        next.position = CGPoint(x: -200 , y: -100)
//        next.size = CGSize(width: 225, height: 93)
        success.addChild(next)
        
        let menu = SKSpriteNode(imageNamed: "caidan_fugu")
        menu.position = CGPoint(x: 200 , y: -100)
//        menu.size = CGSize(width: 225, height: 93)
        success.addChild(menu)
        
        self.addChild(success)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let gameScene  = GameScene.init(size:self.size)
//
//        gameScene.scaleMode = scaleMode
//
//        let reveal = SKTransition.flipHorizontal(withDuration: 1.0)
//
//        view?.presentScene(gameScene, transition: reveal)
        
        
    }
    
}
