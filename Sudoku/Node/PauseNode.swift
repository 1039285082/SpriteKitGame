//
//  PsuseNode.swift
//  Sudoku
//
//  Created by Mac on 11/12/2018.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import SpriteKit
protocol pausedViewDelegate {
    func returnPausedViewBtnClick(buttonName:String)
}


class PauseNode: SKSpriteNode {
    var timeCount = Timer()
    let dataSource = NSKeyedUnarchiver.unarchiveObject(withFile:InfoManager.sharedInfoManager().userDataSource)as! DataSource
    var pausedDelegate:pausedViewDelegate?
    
     init() {
        let texture = SKTexture(imageNamed: "masking_bj")
        super.init(texture: texture, color: .clear, size: texture.size())
        self.position = CGPoint.zero
        
        let restart = SKSpriteNode(imageNamed: dataSource.pausedViewRestart)
        restart.name = "restart"
        restart.position = CGPoint.zero
        
        self.addChild(restart)
        
        let start = SKSpriteNode(imageNamed: dataSource.pausedViewStart)
        start.name = "start"
        start.position = CGPoint(x: 0, y: 300)
        self.addChild(start)
        
        let menu = SKSpriteNode(imageNamed: dataSource.pausedViewMenu)
        menu.name = "menu"
        menu.position = CGPoint(x: 0, y: -300)
        self.addChild(menu)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            
      
            let node = self.nodes(at: location).first
            let sp =  node as? SKSpriteNode
            switch sp?.name {
            case "start":
                timeCount.fireDate = Date.distantPast
                self.pausedDelegate?.returnPausedViewBtnClick(buttonName:"strat")
                self.removeFromParent()
            case "restart":
//                timeCount.fireDate = Date.init(timeIntervalSince1970: 0)
                timeCount.fireDate = Date.distantPast
                self.pausedDelegate?.returnPausedViewBtnClick(buttonName: "restart")
                self.removeFromParent()
            case "menu":
                self.pausedDelegate?.returnPausedViewBtnClick(buttonName: "menu")
                self.removeFromParent()
            default: break
            }
            
        }
        
        
       
    }

}
