//
//  MainScene.swift
//  Sudoku
//
//  Created by Mac on 26/11/2018.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import SpriteKit


class MainScene: SKScene {
    
    private var title = SKSpriteNode()
    
    private var difficulty = SKSpriteNode()
    
    private var  array = Array<String>()
    
    private var playableRect:CGRect = CGRect.zero
    
    let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
    
    var VC:GameViewController? = nil
    
    override func didMove(to view: SKView) {
        VC = GameViewController()
        array = ["Primary".localized,"Advanced".localized,"Difficult".localized,"Expert".localized,"Crazy".localized,"Setting".localized]
      
        creatUI()
    }
    
  
  
    
    func creatUI(){
        let playRect = InfoManager.sharedInfoManager().playRect
        
        
         let dataSource = NSKeyedUnarchiver.unarchiveObject(withFile:InfoManager.sharedInfoManager().userDataSource)as? DataSource
        

        let back = SKSpriteNode(imageNamed: dataSource!.selectViewBg)
        
        back.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        
        self.addChild(back)
        
        title = SKSpriteNode(texture: SKTexture(imageNamed: "sudoku"))
        
        title.position = CGPoint(x:(playRect.maxX+playRect.minX)/2, y: playRect.maxY-title.size.height-200)
        
       
        
        self.addChild(title)
       
    
        for i in 0...5 {
           
            difficulty = SKSpriteNode(imageNamed: dataSource!.mainBtnImg)
            
            switch i {
            case 0 :
                difficulty.name = "easy".localized
            case 1 :
                 difficulty.name = "littleEasy".localized
            case 2 :
                difficulty.name = "difficulty".localized
            case 3 :
                difficulty.name = "prefresor".localized
            case 4 :
                difficulty.name = "crazy".localized
            default:
                difficulty.name = "setting".localized
            }
            
            if i < 3{
                    difficulty.position = CGPoint(x:playRect.minX+(playRect.width - 3*difficulty.size.width)/4+difficulty.size.width/2 + CGFloat(i) * ((playRect.width - 3*difficulty.size.width)/4+difficulty.size.width), y:playRect.maxY/2+300)

            }else{
                
                difficulty.position = CGPoint(x:playRect.minX+(playRect.width - 3*difficulty.size.width)/4+difficulty.size.width/2 + CGFloat(i-3) * ((playRect.width - 3*difficulty.size.width)/4+difficulty.size.width), y: playRect.maxY/2-300)
            }
           
            let difficLabel = SKLabelNode(fontNamed: "Helvetica-BoldOblique")
            difficLabel.name = "difficLabel"
            difficLabel.text = array[i]
            difficLabel.fontSize = 60
            difficLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
            difficLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
            
        
            
            
            difficulty.addChild(difficLabel)
            
            
            
            self.addChild(difficulty)
            if i == 5{
                let setIconNode = SKSpriteNode(imageNamed: "set_icon")
                setIconNode.position = CGPoint(x: difficulty.position.x-difficulty.size.width/2+setIconNode.size.width/2+30, y: difficulty.position.y+difficulty.size.height/2-setIconNode.size.height/2-30)
                self.addChild(setIconNode)
                
            }
        }
        
        

    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in (touches) {
            
            let location = touch.location(in: self)
            
            let nodeArr = self.nodes(at: location)
            
            for node in nodeArr{
                
                if node.name == "easy".localized{
                    
                    let selectSence = SceneManager.sharedSceneManager().selectScene(name: "select") as! SelectLevel
                     let door = SKTransition.push(with:SKTransitionDirection.left, duration: 0.5)
                    
                    selectSence.level = 0
                    appDelegate.soud.creatBackMusic()
                    self.view?.presentScene(selectSence, transition: door)
                    
                }
                if node.name == "littleEasy".localized{
                    let selectSence = SceneManager.sharedSceneManager().selectScene(name: "select") as! SelectLevel
                    let door = SKTransition.push(with:SKTransitionDirection.left, duration: 0.5)
                    
                    selectSence.level = 1
                    appDelegate.soud.creatBackMusic()
                    self.view?.presentScene(selectSence, transition: door)
                    
                }
                if node.name == "difficulty".localized{
                    let selectSence = SceneManager.sharedSceneManager().selectScene(name: "select") as! SelectLevel
                    let door = SKTransition.push(with:SKTransitionDirection.left, duration: 0.5)
                    
                    appDelegate.soud.creatBackMusic()
                    selectSence.level = 2
                    self.view?.presentScene(selectSence, transition: door)
                    
                }
                if node.name == "prefresor".localized{
                    let selectSence = SceneManager.sharedSceneManager().selectScene(name: "select") as! SelectLevel
                    let door = SKTransition.push(with:SKTransitionDirection.left, duration: 0.5)
                    
                    selectSence.level = 3
                    appDelegate.soud.creatBackMusic()
                    self.view?.presentScene(selectSence, transition: door)
                    
                }
                if node.name == "crazy".localized{
                    let selectSence = SceneManager.sharedSceneManager().selectScene(name: "select") as! SelectLevel
                    let door = SKTransition.push(with:SKTransitionDirection.left, duration: 0.5)
                    
                    selectSence.level = 4
                    appDelegate.soud.creatBackMusic()
                    self.view?.presentScene(selectSence, transition: door)
                    
                }
             
                if node.name == "setting".localized{
                    
                    let selectSence = SceneManager.sharedSceneManager().selectScene(name: "setting")
                    let door = SKTransition.push(with:SKTransitionDirection.left, duration: 0.5)
                    
                    appDelegate.soud.creatBackMusic()
                    self.view?.presentScene(selectSence, transition: door)
                    
                    
                    
                }
                
                
            }
            
        }
        
    }
    
  
    override func update(_ currentTime: TimeInterval) {
        
        
        
    }
    override func willMove(from view: SKView) {
        appDelegate.soud.stopBackMusic()
    }
}
