//
//  FailNode.swift
//  Sudoku
//
//  Created by Mac on 11/12/2018.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import SpriteKit
protocol failDelegate {
    func returnFailBtnClick(btnName:String)
}
class FailNode: SKSpriteNode {
    let playRect = InfoManager.sharedInfoManager().playRect
    
    let margin:CGFloat = 135
    
    var levelLabel = SKLabelNode()
    
    var timeLabel = SKLabelNode()
    
    var failBtnClick:failDelegate?
    
    
    init() {
        
        let texture = SKTexture(imageNamed: "masking_bj")
        //        let texture = SKTexture(imageNamed: "guoguan_mountain")
        
        super.init(texture: texture, color: .clear, size: texture.size())
        self.position = CGPoint.zero
        
      
        let dataSource = NSKeyedUnarchiver.unarchiveObject(withFile:InfoManager.sharedInfoManager().userDataSource)as? DataSource
        let bj = SKSpriteNode(imageNamed: "shibai".localized)
        bj.position = CGPoint(x: 0, y: self.size.height/2-bj.size.height/2)
        
        
        levelLabel = SKLabelNode(fontNamed: "AaxiaoNangua")
        
        levelLabel.position = CGPoint(x: 0, y: 100)
        //        levelLabel.text = "Level 3"
        levelLabel.fontSize = 80
        levelLabel.fontColor = .white
        levelLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        levelLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        bj.addChild(levelLabel)
        
        
        let restart = SKSpriteNode(imageNamed: dataSource!.gameFailureRestartBtn)
        let menu = SKSpriteNode(imageNamed: dataSource!.gameSuccessMenuBtn)
        restart.position = CGPoint(x: -100-restart.size.width/2 , y: -250)
        bj.addChild(restart)
        
        restart.name = "restart"
        menu.name = "menu"
        menu.position = CGPoint(x:100+menu.size.width/2, y: -250)
        bj.addChild(menu)
        
        self.addChild(bj)
        
        bj.run(SKAction.sequence([SKAction.move(to: CGPoint.zero, duration: 1.0)]))
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            let node = self.nodes(at: touch.location(in: self)).first as? SKSpriteNode
            
            switch node?.name {
            case "restart":
                
                failBtnClick?.returnFailBtnClick(btnName:"restart")
                self.removeFromParent()
                
            case "menu":
                
                failBtnClick?.returnFailBtnClick(btnName: "menu")
                self.removeFromParent()
            default:break
                
            }
            
        }
    }
}
