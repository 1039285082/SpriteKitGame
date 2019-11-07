//
//  SuccessNode.swift
//  Sudoku
//
//  Created by Mac on 4/12/2018.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import SpriteKit

protocol successDelegate {
    func returnSuccessBtnClick(btnName:String)
}

class SuccessNode: SKSpriteNode {
    let playRect = InfoManager.sharedInfoManager().playRect
    
    let margin:CGFloat = 135
    
    var levelLabel = SKLabelNode()
    
    var timeLabel = SKLabelNode()
    
    var successDelegate:successDelegate?
    
    
    
    init() {
      
        let texture = SKTexture(imageNamed: "masking_bj")
//        let texture = SKTexture(imageNamed: "guoguan_mountain")
        
        super.init(texture: texture, color: .clear, size: texture.size())
        self.position = CGPoint.zero
        
      
        
        let dataSource = NSKeyedUnarchiver.unarchiveObject(withFile:InfoManager.sharedInfoManager().userDataSource)as? DataSource
        let bj = SKSpriteNode(imageNamed: "guoguan".localized)
        
        bj.zPosition = 10
        bj.position = CGPoint(x: 0, y: self.size.height/2-bj.size.height/2)
        
        levelLabel = SKLabelNode(fontNamed: "AaxiaoNangua")
        
        levelLabel.position = CGPoint(x: 0, y: 100)
        //        levelLabel.text = "Level 3"
        levelLabel.fontSize = 80
        levelLabel.fontColor = .white
        levelLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        levelLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        //        levelLabel.name = "levelLabel"
        bj.addChild(levelLabel)
        
        timeLabel = SKLabelNode(fontNamed: "AaxiaoNangua")
        
        timeLabel.position = CGPoint(x: 0, y: 0)
        
        timeLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        timeLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        //        timeLabel.text = "Total Time ：08:26"
        timeLabel.fontSize = 100
        timeLabel.fontColor = .white
        //        levelLabel.name = "levelLabel"
        bj.addChild(timeLabel)
        
        let next = SKSpriteNode(imageNamed: dataSource!.gameSuccessNextBtn)
        let menu = SKSpriteNode(imageNamed: dataSource!.gameSuccessMenuBtn)
//        let leftMargin = texture.size().width - margin - (next.size.width+menu.size.width)
        
        next.position = CGPoint(x: -100-next.size.width/2 , y: -250)
        bj.addChild(next)
        
        next.name = "next"
        menu.name = "menu"
        menu.position = CGPoint(x:100+menu.size.width/2, y: -250)
        bj.addChild(menu)
        
        self.addChild(bj)
        let clapHands = SKAction.playSoundFileNamed("claphands.mp3", waitForCompletion: false)

        bj.run(SKAction.sequence([SKAction.move(to: CGPoint.zero, duration: 1.0),clapHands]))
        
        let skemeterNode = SKEmitterNode(fileNamed: "MyParticle1.sks")
        skemeterNode!.position = bj.position
        skemeterNode?.zPosition = 5
        self.addChild(skemeterNode!)
        
        skemeterNode?.run(SKAction.sequence([SKAction.wait(forDuration: 2.0),SKAction.removeFromParent()]))
        
        
        
        let skemeterNode1 = SKEmitterNode(fileNamed: "colour2.sks")
        skemeterNode1!.position = CGPoint(x: bj.position.x-200, y: bj.position.y)
        skemeterNode1?.zPosition = 5
        self.addChild(skemeterNode1!)
        
        skemeterNode1?.run(SKAction.sequence([SKAction.wait(forDuration: 2.0),SKAction.removeFromParent()]))
        
        
        let skemeterNode2 = SKEmitterNode(fileNamed: "ParticleColour3.sks")
        skemeterNode2!.position = CGPoint(x: bj.position.x+200, y: bj.position.y)
        skemeterNode2?.zPosition = 5
        self.addChild(skemeterNode2!)
        
        skemeterNode2?.run(SKAction.sequence([SKAction.wait(forDuration: 2.0),SKAction.removeFromParent()]))
        
//        let clapHands = skpl
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("123")
        for touch in touches{
            let node = self.nodes(at: touch.location(in: self)).first as? SKSpriteNode
          
            
            
          
            
            
            switch node?.name {
            case "next":
                successDelegate?.returnSuccessBtnClick(btnName: "next")
                 self.removeFromParent()
                
            case "menu":
                successDelegate?.returnSuccessBtnClick(btnName: "menu")
                 self.removeFromParent()
            default:break
                
            }
            
        
            
        
        }
        
        
    }
    
}

