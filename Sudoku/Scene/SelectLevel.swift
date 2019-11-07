//
//  SelectLevel.swift
//  Sudoku
//
//  Created by Mac on 27/11/2018.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import SpriteKit
import AVKit

class SelectLevel: SKScene {
    
    private var selectItem = SKSpriteNode()
    
    let itemW:CGFloat = 222
    
    private var isLockArr = Array<Bool>()
    
    private var video = SKVideoNode()
    private var player:AVPlayer! = nil
    private var questionArr = Array<Array<String>>()
    private var resolveArr = Array<Array<String>>()
    private var nextPageLabel = SKLabelNode()
    
    private var levelModelArr = Array<LevelModel>()
    
    let playRect = InfoManager.sharedInfoManager().playRect
    
    var level = Int()
    let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        getLevel()
        getIsLockArr()
        creatUI()
        creatTitle()
        
    }
    
    func getIsLockArr(){
        
        //        isLockArr = [false,true,true,true,true]
        
        for i in 0...24 {
            if i<levelModelArr.count+1{
                isLockArr.append(false)
            }else{
                
                isLockArr.append(true)
            }
        }
        
        
        
    }
    func creatTitle(){
        let title = SKLabelNode(fontNamed: "Helvetica-BoldOblique")
        title.text = "Select Level".localized
        title.fontSize = 80
        title.fontColor = .white
        title.position = CGPoint(x: self.size.width/2, y: self.size.height-150)
        
        title.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        title.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        
        self.addChild(title)
        
        let back = SKSpriteNode(imageNamed: "fanhui")
        back.name = "back"
        back.position = CGPoint(x: playRect.minX+100+back.size.width/2, y: self.size.height-150)
        self.addChild(back)
        
        nextPageLabel = SKLabelNode(fontNamed: "Helvetica-BoldOblique")
        
        nextPageLabel.name = "nextPage"
        
        nextPageLabel.text = "Next".localized
        
        nextPageLabel.fontSize = 60
        
        print("-----------\(nextPageLabel.frame.size.width)")
        let marginLeft = (playRect.width - 35 * 4 - itemW*5)/2
        nextPageLabel.position = CGPoint(x: playRect.maxX-marginLeft , y: self.size.height/4)
        
        
        
       
        
        nextPageLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        
        nextPageLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        
        self.addChild(nextPageLabel)
        
        
    }
    func creatUI(){
        //        .unarchiveObject(withFile:InfoManager.sharedInfoManager().userDataSource)as? DataSource
        let dataSource = NSKeyedUnarchiver.unarchiveObject(withFile:InfoManager.sharedInfoManager().userDataSource)as? DataSource
        let marginLeft = (playRect.width - 35 * 4 - itemW*5)/2
        let back = SKSpriteNode(imageNamed: dataSource!.selectViewBg)
        
        back.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        back.size = CGSize(width: self.size.width, height: self.size.height)
        self.addChild(back)
        for i in 0...24 {
            if isLockArr[i]{
                //
                selectItem = SKSpriteNode(imageNamed: dataSource!.lockBtnImg)
                selectItem.position = CGPoint(x: itemW/2+playRect.minX+marginLeft + CGFloat(i%5) * (itemW+35), y: self.size.height/4*3 - CGFloat(i/5)*(itemW+35))
                
                
                self.addChild(selectItem)
            }else{
                selectItem = SKSpriteNode(imageNamed: dataSource!.unlockBtnImg)
                selectItem.name = "isNotLocked\(i)"
                let levellabel = SKLabelNode(fontNamed: "AaxiaoNangua")
                levellabel.text = String(format: "\(i+1)")
                levellabel.color = .white
                
                levellabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
                levellabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
                
                levellabel.fontSize = 120
                selectItem.addChild(levellabel)
                
                if i<levelModelArr.count{
                    let levelModel = levelModelArr[i]
                    print("\(levelModel.successTime)")
                    let successTimeLabel = SKLabelNode(fontNamed: "AaxiaoNangua")
                    
                    successTimeLabel.text = levelModel.successTime
                    successTimeLabel.color = .white
                    successTimeLabel.fontSize = 48
                    
                    successTimeLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
                    successTimeLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
                    successTimeLabel.position = CGPoint(x: 0, y: -selectItem.size.height/3)
                    selectItem.addChild(successTimeLabel)
                }
               
                
           
                
                
                selectItem.position = CGPoint(x: itemW/2+playRect.minX+marginLeft + CGFloat(i%5) * (itemW+35), y: self.size.height/4*3 - CGFloat(i/5)*(itemW+35))
                
                
                self.addChild(selectItem)
                
                
            }
        }
        //
        //        for i in 0...24 {
        //
        //
        //        }
        //
        
        
        
        
        
    }
    func getLevel() {
        let question = QuestionModel()
        switch level {
        case 0:
            questionArr = question.readEasyQuestion()
            resolveArr = question.readEasyQuestionResolve()
            
            let arrModel = NSKeyedUnarchiver.unarchiveObject(withFile:InfoManager.sharedInfoManager().saveSuccessEasy())as! LevelArrModel
            levelModelArr = arrModel.ModelArr
        case 1:
            questionArr = question.readAdvancedQuestion()
            resolveArr = question.readAdvancedQuestionResolve()
            
            let arrModel = NSKeyedUnarchiver.unarchiveObject(withFile:InfoManager.sharedInfoManager().saveSuccessAdvanced())as! LevelArrModel
            levelModelArr = arrModel.ModelArr
        case 2:
            questionArr = question.readDifficultyQuestion()
            resolveArr = question.readDifficultyQuestionResolve()
            
            let arrModel = NSKeyedUnarchiver.unarchiveObject(withFile:InfoManager.sharedInfoManager().saveSuccessDifficulty())as! LevelArrModel
            levelModelArr = arrModel.ModelArr
        case 3:
            questionArr = question.readExpertQuestion()
            resolveArr = question.readExpertQuestionResolve()
            
            let arrModel = NSKeyedUnarchiver.unarchiveObject(withFile:InfoManager.sharedInfoManager().saveSuccessExpert())as! LevelArrModel
            levelModelArr = arrModel.ModelArr
        case 4:
            questionArr = question.readCrazyQuestion()
            resolveArr = question.readCrazyQuestionResolve()
            
            let arrModel = NSKeyedUnarchiver.unarchiveObject(withFile:InfoManager.sharedInfoManager().saveSuccessCrazy())as! LevelArrModel
            levelModelArr = arrModel.ModelArr
        default: break
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in (touches) {
            
            let location = touch.location(in: self)
            
            let nodeArr = self.nodes(at: location)
            
            for node in nodeArr{
                if node.name == "back"{
                    
                    let scene = SceneManager.sharedSceneManager().selectScene(name: "main")
                    
                    let door = SKTransition.push(with: SKTransitionDirection.right, duration: 0.5)
                    appDelegate.soud.creatBackMusic()
                    self.view?.presentScene(scene, transition: door)
                    
                }
                for i in 0...questionArr.count-1 {
                    if node.name == "isNotLocked\(i)"{
                        let gameScene = SceneManager.sharedSceneManager().selectScene(name: "game") as! GameScene
                        gameScene.difficultyLevel = level
                        gameScene.currentLevel = i+1
                        gameScene.itemArr = questionArr[i]
                        gameScene.resolveArr = resolveArr[i]
                        gameScene.questionArr = questionArr
                        gameScene.questionResolveArr = resolveArr
                        gameScene.page = 1
                        switch level {
                        case 0 :
                            gameScene.emptyCellNum = 25
                        case 1 :
                            gameScene.emptyCellNum = 30
                        case 2 :
                            gameScene.emptyCellNum = 35
                        case 3 :
                            gameScene.emptyCellNum = 40
                        case 4 :
                            gameScene.emptyCellNum = 45
                        default:break
                        }
                        
                        
                        //                    gameScene.
                        let door = SKTransition.push(with: SKTransitionDirection.left, duration: 0.5)
                        
                        self.view?.presentScene(gameScene, transition: door)
                        
                    }
                    
                }
                if node.name == "nextPage"{
                    let scene = SelectLevel2()
                    scene.size = CGSize(width: 2048, height: 2732)
                    scene.level = level
                    scene.scaleMode = .aspectFill
                    self.view?.presentScene(scene)
                    
                }
            }
            
            
        }
    }
}
