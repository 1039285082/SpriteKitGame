//
//  SelectLevel2.swift
//  Sudoku
//
//  Created by Mac on 5/12/2018.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import SpriteKit
class SelectLevel2: SKScene {
    
    
    private var selectItem = SKSpriteNode()
    
    let itemW:CGFloat = 222
    
    private var isLockArr = Array<Bool>()
    
    //    private var video = SKVideoNode()
    //    private var player:AVPlayer! = nil
    private var questionArr = Array<Array<String>>()
    private var resolveArr = Array<Array<String>>()
    let playRect = InfoManager.sharedInfoManager().playRect
    var level = Int()
    private var levelModelArr = Array<LevelModel>()
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0, y: 0)
        //        isLockArr = [false,true,true,true,true]
        getLevel()
        getIsLockArr()
        creatUI()
        creatTitle()
        
    }
    
    func getIsLockArr(){
        for i in 25...questionArr.count-1 {
            if i<levelModelArr.count+1{
                isLockArr.append(false)
            }else{
                
                isLockArr.append(true)
//                print("\(isLockArr.count)")
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
        
        let prePageLabel = SKLabelNode(fontNamed: "Helvetica-BoldOblique")
        
        prePageLabel.name = "prePage"
        prePageLabel.text = "Previous".localized
        
        prePageLabel.fontSize = 60
        
        let marginLeft = (playRect.width - 35 * 4 - itemW*5)/2
        prePageLabel.position = CGPoint(x: playRect.minX+marginLeft, y: self.size.height/4)
        
        
       
        
        prePageLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        
        prePageLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        
        self.addChild(prePageLabel)
        
        
        
        
    }
    func creatUI(){
        let dataSource = NSKeyedUnarchiver.unarchiveObject(withFile:InfoManager.sharedInfoManager().userDataSource)as? DataSource
        let marginLeft = (playRect.width - 35 * 4 - itemW*5)/2
        let back = SKSpriteNode(imageNamed: dataSource!.selectViewBg)
        
        back.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        back.size = CGSize(width: self.size.width, height: self.size.height)
        self.addChild(back)
        
        
        
        for i in 25...questionArr.count-1 {
            if isLockArr[i-25]{
                
                selectItem = SKSpriteNode(imageNamed: dataSource!.lockBtnImg)
                
                selectItem.position = CGPoint(x: itemW/2+playRect.minX+marginLeft + CGFloat((i-25)%5) * (itemW+35), y: self.size.height/4*3 - CGFloat((i-25)/5)*(itemW+35))
                
                self.addChild(selectItem)
            }else{
                selectItem = SKSpriteNode(imageNamed: dataSource!.unlockBtnImg)
                selectItem.name = "isNotLocked\(i)"
                let levellabel = SKLabelNode(fontNamed: "AaxiaoNangua")
                levellabel.text = String(format: "\(i+1)")
                levellabel.color = .white
                
                levellabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
                levellabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
                
                levellabel.fontSize = 80
                
                selectItem.addChild(levellabel)
                
                if i<levelModelArr.count{
                    let levelModel = levelModelArr[i]
//                    print("\(levelModel.successTime)")
                    let successTimeLabel = SKLabelNode(fontNamed: "AaxiaoNangua")
                    
                    successTimeLabel.text = levelModel.successTime
                    successTimeLabel.color = .white
                    successTimeLabel.fontSize = 48
                    
                    successTimeLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
                    successTimeLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
                    successTimeLabel.position = CGPoint(x: 0, y: -selectItem.size.height/3)
                    selectItem.addChild(successTimeLabel)
                }
                
                
                selectItem.position = CGPoint(x: itemW/2+playRect.minX+marginLeft + CGFloat((i-25)%5) * (itemW+35), y: self.size.height/4*3 - CGFloat((i-25)/5)*(itemW+35))
                
                selectItem.size = CGSize(width: itemW , height: itemW)
                
                
                
                self.addChild(selectItem)
            }
        }
        
        
        
        
        
        
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
                if node.name == "prePage"{
                    let scene = SelectLevel()
                    scene.size = CGSize(width: 2048, height: 2732)
                    scene.level = level
                    scene.scaleMode = .aspectFill
                    self.view?.presentScene(scene)
                    
                }
                for i in 25...questionArr.count-1 {
                    if node.name == "isNotLocked\(i)"{
                        let gameScene = SceneManager.sharedSceneManager().selectScene(name: "game") as! GameScene
                        
                        
                        gameScene.itemArr = questionArr[i]
                        
                        gameScene.resolveArr = resolveArr[i]
                        
                        gameScene.difficultyLevel = level
                        
                        gameScene.resolveArr = resolveArr[i]
                        gameScene.questionArr = questionArr
                        
                        gameScene.currentLevel = i+1
                        
                        gameScene.page = 2
                        
                        let door = SKTransition.push(with: SKTransitionDirection.left, duration: 0.5)
                        
                        self.view?.presentScene(gameScene, transition: door)
                        
                    }
                    
                }
            }
            
            
        }
    }
    
    
}
