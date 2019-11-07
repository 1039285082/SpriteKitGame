//
//  GameScene.swift
//  Sudoku
//
//  Created by Mac on 19/11/2018.
//  Copyright © 2018 Mac. All rights reserved.
//


import SpriteKit
import GameplayKit
import AVKit
import GoogleMobileAds
class GameScene: SKScene,settingDelegate,pausedViewDelegate,successDelegate,failDelegate,GADInterstitialDelegate {
    
    
    
    private var outline = SKSpriteNode()
    private  var label:SKLabelNode?
    let playW:CGFloat = UIScreen.main.bounds.size.width-20
    private var lastPosition = CGPoint.zero
    private var cellArr = Array<SKSpriteNode>()
    
    private var selectCellArr = Array<SKSpriteNode>()
    
    private var timer = SKLabelNode()
    private var lastTime:TimeInterval = 0
    
    private var second:TimeInterval  = 0
    private var timeCount : Timer?
    private var tips = SKSpriteNode()
    private var cancel = SKSpriteNode()
    private var cancelArr = Array<SKSpriteNode>()
    private var video = SKVideoNode()
    private var player:AVPlayer! = nil
    private var dataSource = DataSource()
    

    
    private var back = SKSpriteNode()
    
    private var cell = SKSpriteNode()
    
    private var selectCell  = SKSpriteNode()
    
    private var titleLabel = SKLabelNode()
    
    private var success = SuccessNode()
    
    private var fail = FailNode()
    
    private var gridViewRectArr = Array<CGRect>()
    
    private var lastNode = SKSpriteNode()
    
    private var backBlock = String()
    
    private var stopImg = String()
    
    private var pauseNode = SKSpriteNode()
    
    private var failNumber = 1
    
    private var isWin:Bool = true
    
    let playRect = InfoManager.sharedInfoManager().playRect
    
    
    private let cellWidth:CGFloat = 125
    
    private let margin:CGFloat = 10
    
    private let selectCellW:CGFloat = 180
    
    var itemArr = Array<String>()
    var resolveArr = Array<String>()
    
    var difficultyLevel = Int()
    
    var currentLevel = Int()
    
    var page = Int()
    
    var emptyCellNum = Int()
    //问题和答案数组
    var questionArr = Array<Array<String>>()
    var questionResolveArr = Array<Array<String>>()
    
    let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint.zero
        self.backgroundColor = .lightGray
        dataSource = NSKeyedUnarchiver.unarchiveObject(withFile:InfoManager.sharedInfoManager().userDataSource) as! DataSource
        
        creatSudoku()
        
        creatTime()
        
        creatVideo()
        
        creatBcakNode()
        AdManager.sharedAdManager().creatInterstitial()
  
        creatBackGroundMusic()
    }
    
    func creatBackGroundMusic(){
        
        if dataSource.BackMusic{
            appDelegate.soud.creatBgMusic()
        }
    
        
        
    }
    
    func creatBcakNode(){
        
        
        let backNode = SKSpriteNode(imageNamed: "fanhui")
        backNode.name = "backNode"
        backNode.position = CGPoint(x:playRect.minX+200, y: self.size.height-150)
        
        
        
        self.addChild(backNode)
        
        titleLabel = SKLabelNode(fontNamed:"Helvetica-BoldOblique")
        titleLabel.fontSize = 80
        titleLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        titleLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        let str = "Level".localized
        titleLabel.text = String(format: "\(str)-\(currentLevel)")
        titleLabel.position = CGPoint(x:self.size.width/2, y: self.size.height-150)
        
        
        
        self.addChild(titleLabel)
      
        pauseNode = SKSpriteNode(imageNamed: dataSource.stop)
        pauseNode.name = "paused"
//        pauseNode.texture = SKTexture(imageNamed: "pause")
        pauseNode.position = CGPoint(x: playRect.maxX-200, y: self.size.height - 150)
        self.addChild(pauseNode)
        
    }
    
    func creatVideo() {
        
        
        
        
        
        if dataSource.backgroundVideoName.contains(".mp4") {
            
            let url = URL(fileURLWithPath: dataSource.backgroundVideoName, relativeTo: Bundle.main.resourceURL)
            let item = AVPlayerItem(url: url)
            self.player = AVPlayer(playerItem: item)
            video = SKVideoNode(avPlayer:self.player)
            
            NotificationCenter.default.addObserver(forName:.AVPlayerItemDidPlayToEndTime,object:player.currentItem,queue:nil)
            {
                notification in
                let targetTime = CMTimeMake(value: 0, timescale: Int32(NSEC_PER_SEC))
                self.player.seek(to: targetTime)
                self.player.play()
            }
            
            video.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
            video.size = CGSize(width: self.size.width*2, height: self.size.width*16/9)
            
            
            video.zPosition = -200
            video.play()
            
            
            self.addChild(video)
            
        }else{
            
            back = SKSpriteNode()
            back.texture = SKTexture(imageNamed: dataSource.selectViewBg)
            back.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
            back.size = CGSize(width: self.size.width, height: self.size.height)
            back.zPosition = -200
            self.addChild(back)
            
            
        }
        
        
        
    }
    func creatTime() {
        
        
        timeCount = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimerCount), userInfo: nil, repeats: true)
        timeCount!.fire()
        
        timer = SKLabelNode(fontNamed: "AaxiaoNangua")
        
        //        timer.fontColor = .white
        timer.name = "time"
        timer.fontSize = 80
        if dataSource.backgroundVideoName.contains("snow") {
          timer.fontColor = .blue
        }else{
            timer.fontColor = .white
        }
        
        
        timer.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        timer.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        timer.position = CGPoint(x: self.size.width/2, y: 400)
        
        self.addChild(timer)
        
    }
    
    func creatSudoku (){
        
        let marginLeft = (playRect.width - 12*margin - 9*cellWidth)/2
        
        for i in 0...8 {
            
            for j in 0...8 {
                
                let arr = self.itemArr
                cell = SKSpriteNode()
                
                let m = ceil(Double(j+1)/3)
                //                    print("\(m)")
                let n = ceil(Double(i+1)/3)
                
            
               
                //九宫格区域范围
                let gridViewArr = [18,21,24,45,48,51,72,75,78]
                for z in 0...gridViewArr.count-1{
                    if j+i*9 == gridViewArr[z] {
                        let gridViewRect = CGRect(x: cell.position.x-cellWidth/2, y: cell.position.y-cellWidth/2, width: margin*2+3*cellWidth, height: margin*2+3*cellWidth)
                        gridViewRectArr.append(gridViewRect)
                        
                    }
                    
                }
                
                
                
                if arr[i*9+j] == "0"{
                    cell.name = "emptyCell"
                    cell.texture = SKTexture(imageNamed: dataSource.gameDiamondsImg)
                    cell.position = CGPoint(x:playRect.minX + marginLeft + cellWidth/2 + CGFloat(j) * (margin + cellWidth) + margin * CGFloat(m), y: self.size.height-400-CGFloat(i) * (margin + cellWidth) - margin * CGFloat(n))
                    cell.size = CGSize(width: cellWidth, height: cellWidth)
                    cell.zPosition = -50
                    cell.color = UIColor.white
                    
                    label = SKLabelNode(fontNamed: "AaxiaoNangua")
                    label!.name = "label"
                    label!.fontColor = UIColor.white
                    label!.fontSize = 80
                    label!.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
                    label!.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
                    label!.text = String("")
                    cell.addChild(label!)
                    self.addChild(cell)
                    cellArr.append(cell)
                    
                }else{
                    cell.name = "cell"
                    cell.texture = SKTexture(imageNamed:dataSource.gameBlockImg)
                 
                    cell.position = CGPoint(x:playRect.minX + marginLeft + cellWidth/2 + CGFloat(j) * (margin + cellWidth) + margin * CGFloat(m), y: self.size.height-400-CGFloat(i) * (margin + cellWidth) - margin * CGFloat(n))
                    cell.size = CGSize(width: cellWidth, height: cellWidth)
                    cell.zPosition = -10
                    cell.color = UIColor.white
                    
                    label = SKLabelNode(fontNamed: "AaxiaoNangua")
                    label!.name = "label"
                    label!.fontColor = UIColor.white
                    label!.fontSize = 80
                    label!.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
                    label!.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
                    label!.text = String("\(arr[i*9+j])")
                    cell.addChild(label!)
                    self.addChild(cell)
                    cellArr.append(cell)
                }
                //添加line
                if j+i*8 == 20{
                    let lineNode = SKSpriteNode(imageNamed: "line")
                    lineNode.position = CGPoint(x: cell.position.x, y: cell.position.y-cell.size.width/2-margin)
                    lineNode.size.width = 9*cellWidth+10*margin
                    self.addChild(lineNode)
                }
                if j+i*8 == 44{
                    let lineNode = SKSpriteNode(imageNamed: "line")
                    lineNode.position = CGPoint(x: cell.position.x, y: cell.position.y-cell.size.width/2-margin)
                    lineNode.size.width = 9*cellWidth+10*margin
                    self.addChild(lineNode)
                }
                if j+i*8 == 34{
                    let lineNode = SKSpriteNode(imageNamed: "line")
                    lineNode.zRotation = CGFloat(M_PI/2)
                    lineNode.position = CGPoint(x: cell.position.x+cell.size.width/2+margin, y: cell.position.y)
                    lineNode.size.width = 9*cellWidth+10*margin
                    self.addChild(lineNode)
                }
                if j+i*8 == 37{
                    let lineNode = SKSpriteNode(imageNamed: "line")
                    lineNode.zRotation = CGFloat(M_PI/2)
                    lineNode.position = CGPoint(x: cell.position.x+cell.size.width/2+margin, y: cell.position.y)
                    lineNode.size.width = 9*cellWidth+10*margin
                    self.addChild(lineNode)
                }
                
                
                
            }
            
        }
        self.enumerateChildNodes(withName: "cell", using: {
            node,stop in
            let cellNode = node as! SKSpriteNode
            let zoomAction = SKAction.scale(to: 1.1, duration: 0.4)
            let scaleAction = SKAction.scale(to: 1.0, duration: 0.1)
            
            
            let rotationAction = SKAction.rotate(byAngle: -.pi*2, duration: 0.5)
            let scene = SKAction.sequence([zoomAction,rotationAction,scaleAction])
            
            cellNode.run(scene)
            
        })
        
        
        
        for k in 0...11 {
            //            let selectCell  = SKSpriteNode(imageNamed: dataSource.gameBlockImg)
            selectCell = SKSpriteNode()
            selectCell.texture = SKTexture(imageNamed: dataSource.gameBlockImg)
            let marginL =  (playRect.width - 5*margin - 6*selectCellW)/2
            selectCell.position = CGPoint(x: selectCellW/2+playRect.minX+marginL + CGFloat(k%6) * (selectCellW+margin), y: self.size.height/7*2 - CGFloat(k/6)*(selectCellW+margin))
            selectCell.size = CGSize(width: 180, height: 180)
            if k>=0&&k<=2{
                switch k {
                case 0:
                    let cancelNode = SKSpriteNode(imageNamed: "chexiao")
                    cancelNode.name = "cancel"
                    
                    selectCell.addChild(cancelNode)
                case 1:
                    let tipsNode = SKSpriteNode(imageNamed: "tishi")
                    tipsNode.name = "tips"
                    selectCell.addChild(tipsNode)
                case 2:
                    let settingNode = SKSpriteNode(imageNamed: "shezhi")
                    settingNode.name = "setting"
                    selectCell.addChild(settingNode)
                default:break
                }
                
                self.addChild(selectCell)
                selectCellArr.append(selectCell)
            }else{
                
                selectCell.name = "selectCell"
                
                
                label = SKLabelNode(fontNamed: "AaxiaoNangua")
                label!.name = "selectLabel"
                label!.text = String("\(k-2)")
                label!.fontColor = .white
                label!.fontSize = 120
                label!.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
                label!.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
                
                selectCell.addChild(label!)
                
                self.addChild(selectCell)
                selectCell.isUserInteractionEnabled = false
                selectCellArr.append(selectCell)
            }
            
            
        }
    }
    
    func selectTop(location:CGPoint) -> SKSpriteNode{
        
        outline = SKSpriteNode(imageNamed: "light")
        outline.name = "outline"
        outline.position = location
        outline.size = CGSize(width: cellWidth+5, height: cellWidth+5)
        return outline
    }
   

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in (touches){
            
            let location = touch.location(in: self)
            
            var resolveStr = String()
            
            let node = self.nodes(at: location).first
            if let sp =  node as? SKSpriteNode{
                //判断点击是否是格子
              
                if sp.name == "cell" || sp.name == "emptyCell"{
                    
                    
                    self.childNode(withName: "outline")?.run(SKAction.removeFromParent())
                    
                    let selectTop = self.selectTop(location: sp.position)
                    
                    self.addChild(selectTop)
                    
                    lastPosition  = sp.position
                }
                //判断点击是否是底部格子
                if sp.name == "selectCell"{
                    
                    //                    sp.isUserInteractionEnabled = false
                    let rightLabel = sp.childNode(withName: "selectLabel") as! SKLabelNode
                    if outline.position != CGPoint(x: 0, y: 0){
                        let lastPositionNode = self.nodes(at: lastPosition)
                        
                        for allNode in lastPositionNode{
                            
                            if allNode.name == "label"{
                                
                                let label  = allNode as! SKLabelNode
                                
                                if(label.text == ""){
                                    
                                    if lastPositionNode.count<5{
                                        if !backBlock.isEmpty {
                                             lastNode = SKSpriteNode(imageNamed: backBlock)
                                        }else{
                                             lastNode = SKSpriteNode(imageNamed: dataSource.gameBlockImg)
                                        }
                                        
                                       
                                        lastNode.name = "lastNode"
                                        
                                        
                                        lastNode.position = sp.position;
                                        lastNode.size = CGSize(width: cellWidth, height: cellWidth)
                                        lastNode.color = sp.color
                                        let onlineLabel = SKLabelNode(fontNamed: "AaxiaoNangua")
                                        onlineLabel.text = rightLabel.text
                                        onlineLabel.name = "label"
                                        onlineLabel.fontColor = .white
                                        onlineLabel.fontSize = 80
                                        onlineLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
                                        onlineLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
                                        
                                        lastNode.addChild(onlineLabel)
                                        //判断是否能填进空格
                                        
                                        if self.isRepeatWithRow(text: rightLabel.text!) && self.inGridViewRect(text: rightLabel.text!){
                                            self.lastNode.name = "cell"
                                            
                                            let moveAction = SKAction.move(to: self.lastPosition, duration: 0.3)
                                            let musicActiong = SKAction.playSoundFileNamed("fillsuccess.mp3", waitForCompletion: true)
                                            
                                            
                                            self.lastNode.run(SKAction.sequence([moveAction,musicActiong])){
                                                sp.isUserInteractionEnabled = false
                                               
                                            }
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                               self.creatEmitterNode()
                                            }
                                            
                                            self.cancelArr.append(self.lastNode)
                                            self.popSuccess()
                                        }else{
                                            let moveAction = SKAction.move(to: lastPosition, duration: 0.3)
                                            
                                            let stayAction = SKAction.scale(to: 1.5, duration: 0.1)
                                            let scaleAction = SKAction.scale(to: 1.0, duration: 0.1)
                                            let backAction = SKAction.move(to: sp.position, duration: 0.3)
                                            let removeAction = SKAction.removeFromParent()
                                            
                                            
                                            lastNode.run(SKAction.sequence([moveAction,stayAction,scaleAction,backAction,removeAction]))

                                            
                                            var maxFailNumber = Int()
                                            
                                            switch self.difficultyLevel {
                                            case 0:
                                                maxFailNumber = 10
                                            case 1:
                                                maxFailNumber = 9
                                            case 2:
                                                maxFailNumber = 8
                                            case 3:
                                                maxFailNumber = 7
                                            case 4:
                                                maxFailNumber = 6
                                                
                                            default:
                                                break
                                            }
                                            
                                            if failNumber<maxFailNumber{
                                                failNumber += 1
                                                print("-------\(failNumber)")
                                            }else{
                                                self.popFailView()
                                            }
                                            
                                            
                                        }
                                        self.addChild(lastNode)
                                    }
                                }
                            }
                        }
                        
                        
                    }
                }
                
                if sp.name == "lastNode" {
                    
                    
                    
                    self.childNode(withName: "outline")?.run(SKAction.removeFromParent())
                    
                    let selectTop = self.selectTop(location: sp.position)
                    self.addChild(selectTop)
                    
                    lastPosition  = sp.position
                }
                if sp.name == "tips"{
                    
                    if outline.position != CGPoint(x: 0, y: 0){
                        let lastNode = self.nodes(at: lastPosition)
                        
                        for allNode in lastNode{
                            for i in 0...resolveArr.count-1{
                                
                                let cellNode = cellArr[i]
                                if allNode.position == cellNode.position{
                                    
                                resolveStr = resolveArr[i]
                                    
                                }
                                
                            }
                            
                            if allNode.name == "label"{
                                
                                let label  = allNode as! SKLabelNode
                                
                                if(label.text == ""){
                                    
                                    if lastNode.count<5{
                                        let lastNode = SKSpriteNode(imageNamed:dataSource.gameBlockImg)
                                        lastNode.name = "cell"
                                        lastNode.size = CGSize(width: cellWidth, height: cellWidth)
                                        lastNode.position = outline.position;
                                        
                                        
                                        let onlineLabel = SKLabelNode(fontNamed: "AaxiaoNangua")
                                        onlineLabel.name = "label"
                                        onlineLabel.text = resolveStr
                                        onlineLabel.fontColor = .white
                                        onlineLabel.fontSize = 80
                                        
                                        
                                        onlineLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
                                        onlineLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
                                        
                                        lastNode.addChild(onlineLabel)
                                        self.addChild(lastNode)
                                        cancelArr.append(lastNode)
                                        self.popSuccess()
                                        print("\(cancelArr.count)")
                                        
                                    }
                                }
                            }
                        }
                    }
                    
                }
                if sp.name == "cancel"{
                    if cancelArr.count == 0{
                        print("cancelArr has no Node")
                    }else{
                        cancelArr.last!.removeFromParent()
                        cancelArr.removeLast()
                    }
                }
                if sp.name == "setting"{
                    
                    let settingNode = SettingNode()
                    settingNode.settingDelegate = self
                    settingNode.name = "settingNode"
                    settingNode.position = CGPoint.zero
                    self.appDelegate.soud.stopBgMusic()
                    self.addChild(settingNode)
                    self.enumerateChildNodes(withName: "settingNode", using: {
                        node,stop in
                        let setnode = node as! SettingNode
                        setnode.isUserInteractionEnabled = true
                    })
                    
                    
                }
                if sp.name == "backNode"{
                    
                    if page == 1 {
                        let scene = SceneManager.sharedSceneManager().selectScene(name: "select") as! SelectLevel
                        
                        scene.level = self.difficultyLevel
                        let door = SKTransition.push(with: SKTransitionDirection.right, duration: 0.5)
                         appDelegate.soud.creatBackMusic()
                        
                        self.view?.presentScene(scene, transition: door)
                        
                    }else{
                        let scene = SceneManager.sharedSceneManager().selectScene(name: "select2") as! SelectLevel2
                        
                        scene.level = self.difficultyLevel
                        let door = SKTransition.push(with: SKTransitionDirection.right, duration: 0.5)
                        appDelegate.soud.creatBackMusic()
                        self.view?.presentScene(scene, transition: door)
                        
                    }
                    
                    
                }
                if sp.name == "paused" {
                    
                    self.popPaused()
                    
                }
                
                
                
            }else if (node as? SKLabelNode) != nil{//判断是否点击的是否是label
                
                if node?.name == "selectLabel"{
                    
                    let sp = node!.parent as? SKSpriteNode
                    
                    if sp!.name == "cell"{
                        
                        self.childNode(withName: "outline")?.run(SKAction.removeFromParent())
                        
                        let selectTop = self.selectTop(location: sp!.position)
                        
                        self.addChild(selectTop)
                        
                        lastPosition  = sp!.position
                        
                    }else{
                        
                        if outline.position != CGPoint(x: 0, y: 0){
                            let lastPositionNode = self.nodes(at: lastPosition)
                            
                            for allNode in lastPositionNode{
                                
                                
                                
                             
                                
                                if allNode.name == "label"{
                                    
                                    let label  = allNode as! SKLabelNode
                                    if(label.text == ""){
                                        
                                        if lastPositionNode.count<5{
                                            if !backBlock.isEmpty {
                                                lastNode = SKSpriteNode(imageNamed: backBlock)
                                            }else{
                                                lastNode = SKSpriteNode(imageNamed: dataSource.gameBlockImg)
                                            }
                                            
                                            lastNode.name = "lastNode"
                                            lastNode.position = sp!.position;
                                            lastNode.size = CGSize(width: cellWidth, height: cellWidth)
                                            lastNode.color = sp!.color
                                            let label = sp!.children.first as? SKLabelNode
                                            
                                            let onlineLabel = SKLabelNode(fontNamed: "AaxiaoNangua")
                                            onlineLabel.name = "label"
                                            onlineLabel.text = label?.text
                                            onlineLabel.fontColor = .white
                                            onlineLabel.fontSize = 80
                                            
                                            onlineLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
                                            onlineLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
                                            
                                            lastNode.addChild(onlineLabel)
                                            self.addChild(lastNode)
                                            
                                            if self.isRepeatWithRow(text: (label?.text)!) && self.inGridViewRect(text: (label?.text)!){
                                                self.lastNode.name = "cell"
                                                
                                                let moveAction = SKAction.move(to: self.lastPosition, duration: 0.3)
                                                 let musicActiong = SKAction.playSoundFileNamed("fillsuccess.mp3", waitForCompletion: true)
                                                
                                                self.lastNode.run(SKAction.sequence([moveAction,musicActiong]))
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                                    self.creatEmitterNode()
                                                }
                                                self.cancelArr.append(self.lastNode)
                                                
                                                self.popSuccess()
                                            }else{
                                                let moveAction = SKAction.move(to: lastPosition, duration: 0.3)
                                                
                                                let stayAction = SKAction.scale(to: 1.5, duration: 0.1)
                                                let scaleAction = SKAction.scale(to: 1.0, duration: 0.1)
                                                let backAction = SKAction.move(to: sp!.position, duration: 0.3)
                                                let removeAction = SKAction.removeFromParent()
                                                lastNode.run(SKAction.sequence([moveAction,stayAction,scaleAction,backAction,removeAction]))
                                                var maxFailNumber = Int()
                                                
                                                switch self.difficultyLevel {
                                                case 0:
                                                    maxFailNumber = 10
                                                case 1:
                                                    maxFailNumber = 9
                                                case 2:
                                                    maxFailNumber = 8
                                                case 3:
                                                    maxFailNumber = 7
                                                case 4:
                                                    maxFailNumber = 6
                                                    
                                                default:
                                                    break
                                                }
                                                
                                                if failNumber<maxFailNumber{
                                                    failNumber += 1
                                                    print("-------\(failNumber)")
                                                }else{
                                                    self.popFailView()
                                                }
                                                
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        
                        
                    }
                    
                }
                
            }
            
        }
      
    }
    //MARK:- 弹出暂停界面
    func popPaused(){
        let paused = PauseNode()
        paused.pausedDelegate = self
        paused.timeCount = self.timeCount!
        paused.name = "pausedNode"
        paused.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        paused.isUserInteractionEnabled = true
        self.addChild(paused)
        self.timeCount?.fireDate = Date.distantFuture

    }
    //MARK:- 弹出成功界面
    func popSuccess(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let NODEArr = self.children
            var j = 0
            
            
            for i in 0...NODEArr.count-1 {
                if NODEArr[i].name == "cell"{
                    j=j+1
                    print("\(j)")
                }
            }
            if j == 81 {
              
                
                self.success = SuccessNode()
                let str = "Level".localized
                self.success.levelLabel.text = "\(str) \(self.currentLevel)"
                self.success.successDelegate = self
                let date = Date(timeIntervalSince1970: self.second)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "mm:ss"
                
                let nowDate = dateFormatter.string(from: date)
                let totalStr = "Total Time".localized
                
                self.success.timeLabel.text = "\(totalStr) ：\(nowDate)"
                self.success.timeLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
                self.success.timeLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
                self.success.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
                self.success.isUserInteractionEnabled = true
                
                self.saveLevel(nowDate: nowDate)
                
                self.isWin = true
                if AdManager.sharedAdManager().interstitial.isReady {
                    AdManager.sharedAdManager().interstitial.delegate = self
                    AdManager.sharedAdManager().interstitial.present(fromRootViewController: AdManager.sharedAdManager().gameVC!)
                } else {
                    
                     DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.addChild(self.success)
                    }
                }
                
                
//                DispatchQueue.main.asyncAfter(deadline:.now() + 2.0, execute: {
//
//                })
              
                self.timeCount?.invalidate()
                self.appDelegate.soud.stopBgMusic()
            
                
            }
        }
    }
    
    //MARK:- 存储关卡
    func saveLevel(nowDate:String){
        
        var levelArrModel = LevelArrModel()
        var saveStr = String()
        
        switch self.difficultyLevel {
        case 0:
            levelArrModel =  NSKeyedUnarchiver.unarchiveObject(withFile:InfoManager.sharedInfoManager().saveSuccessEasy())as! LevelArrModel
            saveStr = InfoManager.sharedInfoManager().saveSuccessEasy()
        case 1:
            levelArrModel = NSKeyedUnarchiver.unarchiveObject(withFile:InfoManager.sharedInfoManager().saveSuccessAdvanced())as! LevelArrModel
            saveStr = InfoManager.sharedInfoManager().saveSuccessAdvanced()
        case 2:
            levelArrModel = NSKeyedUnarchiver.unarchiveObject(withFile:InfoManager.sharedInfoManager().saveSuccessDifficulty())as! LevelArrModel
            saveStr = InfoManager.sharedInfoManager().saveSuccessDifficulty()
        case 3:
            levelArrModel = NSKeyedUnarchiver.unarchiveObject(withFile:InfoManager.sharedInfoManager().saveSuccessExpert())as! LevelArrModel
            saveStr = InfoManager.sharedInfoManager().saveSuccessExpert()
        case 4:
            levelArrModel = NSKeyedUnarchiver.unarchiveObject(withFile:InfoManager.sharedInfoManager().saveSuccessCrazy())as! LevelArrModel
            saveStr = InfoManager.sharedInfoManager().saveSuccessCrazy()
        default:break
        }
        print("\(levelArrModel.ModelArr)")
        let model = LevelModel()
        model.successTime = nowDate
        model.currentLevel = self.currentLevel
        model.difficulLevel = self.difficultyLevel
        model.whetherSuccess = true

        if levelArrModel.ModelArr.count == 0 {
            levelArrModel.ModelArr.append(model)
        }else{
        var replaced = false
        for i in 0...levelArrModel.ModelArr.count-1 {
            
            let compareModel = levelArrModel.ModelArr[i]
            if compareModel.currentLevel == model.currentLevel {
                
                levelArrModel.ModelArr[i] = model
                replaced = true
            }
        }
            if !replaced{
                levelArrModel.ModelArr.append(model)
            }
            
        }
        
        NSKeyedArchiver.archiveRootObject(levelArrModel, toFile: saveStr)
        
        
        
        print("\(levelArrModel.ModelArr)")
        
    }
    
    //MARK:- 弹出失败界面
    func popFailView(){
        
        
        self.fail = FailNode()
        let str = "Level".localized
        self.fail.levelLabel.text = "\(str) \(self.currentLevel)"
        self.fail.failBtnClick = self
        self.fail.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.fail.isUserInteractionEnabled = true
        self.timeCount?.invalidate()
        self.appDelegate.soud.stopBgMusic()
        
        
        self.isWin = false
        
        if AdManager.sharedAdManager().interstitial.isReady {
             AdManager.sharedAdManager().interstitial.delegate = self
            AdManager.sharedAdManager().interstitial.present(fromRootViewController: AdManager.sharedAdManager().gameVC!)
        } else {
            print("Ad wasn't ready")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
               self.addChild(self.fail)
            }
            
        }
        
     
    }
    
    //MARK:- 判断横竖列是否跟选择cell数字重复
    func isRepeatWithRow(text:String) -> Bool {
        
        var bool = true
        self.enumerateChildNodes(withName: "cell", using: {
            node,stop in
            let compareNode = node as! SKSpriteNode
            if compareNode.position.x == self.lastPosition.x || compareNode.position.y == self.lastPosition.y{
                let compareLabel = compareNode.childNode(withName: "label") as! SKLabelNode
                if text == compareLabel.text{
          
                    bool = false
                    
                }
                
            }
            
            
        })
        return bool
    }
    
    
    //MARK:- 判断是否跟九宫格中数字重复
    func inGridViewRect(text:String) -> Bool {
        var bool = true
        
        for m in 0...self.gridViewRectArr.count-1{
            if self.gridViewRectArr[m].contains(self.lastPosition){
                self.enumerateChildNodes(withName: "cell", using: {
                    node,stop in
                    let compareNode = node as! SKSpriteNode
                    let compareLabel = compareNode.childNode(withName: "label") as! SKLabelNode
                    if self.gridViewRectArr[m].contains(compareNode.position){
                        if text == compareLabel.text{
                            bool = false
                            
                        }
                    }
                })
                
            }
            
        }
        return bool
    }
    
    
    @objc func updateTimerCount(){
        
        second += 1
        
    }
    
    func stopTimer() {
        if timeCount != nil{
            timeCount!.invalidate()
            timeCount = nil
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        
        
        let date = Date(timeIntervalSince1970: second)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm:ss"
        
        let nowDate = dateFormatter.string(from: date)
        
        
        
        timer.text = String("\(nowDate)")
        
    
        
    }
    //MARK:- 设置界面代理方法
    func returnBackground(background: String, Block: String, Diamonds: String,StopBtn:String) {
        
        backBlock = Block
        if !StopBtn.isEmpty {
            pauseNode.texture = SKTexture(imageNamed: StopBtn)
        }
        
        for i in 0...8 {
            
            for j in 0...8 {
                let arr = self.itemArr
                if arr[i*9+j] == "0"{
                    
                    cell = cellArr[i*9+j]
                    if !Block.isEmpty || !Diamonds.isEmpty {
                        cell.texture = SKTexture(imageNamed:Diamonds)
                        
                    }
                    
                }
            }
        }
        for k in 0...11 {
            selectCell =  selectCellArr[k]
            if !Block.isEmpty || !Diamonds.isEmpty {
                
                selectCell.texture = SKTexture(imageNamed:Block)
            }
        }
        
        self.enumerateChildNodes(withName: "cell", using: {
            node,stop in
            let selectNode = node as! SKSpriteNode
            if !Block.isEmpty || !Diamonds.isEmpty {
                
                selectNode.texture = SKTexture(imageNamed: Block)
                
            }
        })
      
     
            if background.contains(".mp4") {
                video.removeFromParent()
                back.removeFromParent()
                
                let url = URL(fileURLWithPath: background, relativeTo: Bundle.main.resourceURL)
                let item = AVPlayerItem(url: url)
                self.player = AVPlayer(playerItem: item)
                video = SKVideoNode(avPlayer:self.player)
                
                NotificationCenter.default.addObserver(forName:.AVPlayerItemDidPlayToEndTime,object:player.currentItem,queue:nil)
                {
                    notification in
                    let targetTime = CMTimeMake(value: 0, timescale: Int32(NSEC_PER_SEC))
                    self.player.seek(to: targetTime)
                    self.player.play()
                }
                
                video.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
                video.size = CGSize(width: self.size.width*2, height: self.size.width*16/9)
                
                
                video.zPosition = -200
                video.play()
                
                
                self.addChild(video)
                
                
            }else{
                video.removeFromParent()
                back.removeFromParent()
                back = SKSpriteNode()
                back.texture = SKTexture(imageNamed: background)
                back.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
                back.size = CGSize(width: self.size.width, height: self.size.height)
                back.zPosition = -200
                self.addChild(back)
            }
        if background.contains("snow"){

            timer.fontColor = .blue
        }else{
            timer.fontColor = .white
        }
        dataSource = NSKeyedUnarchiver.unarchiveObject(withFile:InfoManager.sharedInfoManager().userDataSource) as! DataSource
        if dataSource.BackMusic{
            appDelegate.soud.creatBgMusic()
        }
        
       self.reloadInputViews()
    }
    //MARK:- 暂停界面代理方法
    func returnPausedViewBtnClick(buttonName: String) {
        
        print("\(buttonName)")
        switch buttonName {
        case "start":
//            self.timeCount!.fireDate = Date.distantPast
          print("123")
       
        case "restart":
            let gameScene = SceneManager.sharedSceneManager().selectScene(name: "game") as! GameScene
            gameScene.difficultyLevel = self.difficultyLevel
            gameScene.currentLevel = self.currentLevel
            gameScene.itemArr = self.itemArr
            gameScene.resolveArr = self.resolveArr
            gameScene.page = self.page
            self.view?.presentScene(gameScene)
            
        case "menu":
            let selectScene = SceneManager.sharedSceneManager().selectScene(name: "select") as! SelectLevel
            selectScene.level = difficultyLevel
            self.view?.presentScene(selectScene)
          
        default: break
        }
        
    }
    //MARK:- 成功界面代理
    func returnSuccessBtnClick(btnName: String) {
        
        switch btnName {
        case "next":
            let gameScene = SceneManager.sharedSceneManager().selectScene(name: "game") as! GameScene
            gameScene.difficultyLevel = self.difficultyLevel
            gameScene.currentLevel = self.currentLevel+1
            gameScene.itemArr = self.questionArr[self.currentLevel]
            gameScene.resolveArr = self.questionResolveArr[self.currentLevel]
            gameScene.questionArr = self.questionArr
            gameScene.questionResolveArr = self.questionResolveArr
            gameScene.page = self.page
            self.view?.presentScene(gameScene)
        case "menu":
            let selectScene = SceneManager.sharedSceneManager().selectScene(name: "select") as! SelectLevel
            selectScene.level = difficultyLevel
            self.view?.presentScene(selectScene)
            
        default:
            break
        }
    }
    //MARK:- 失败界面代理方法
    func returnFailBtnClick(btnName: String) {
        switch btnName {
        case "restart":
            let gameScene = SceneManager.sharedSceneManager().selectScene(name: "game") as! GameScene
            gameScene.difficultyLevel = self.difficultyLevel
            gameScene.currentLevel = self.currentLevel
            gameScene.itemArr = self.itemArr
            gameScene.resolveArr = self.resolveArr
            gameScene.page = self.page
            self.view?.presentScene(gameScene)
        case "menu":
            let selectScene = SceneManager.sharedSceneManager().selectScene(name: "select") as! SelectLevel
            selectScene.level = difficultyLevel
            self.view?.presentScene(selectScene)
            
        default:
            break
        }
    }
    //MARK: 粒子效果
    func creatEmitterNode(){
        let skemeterNode = SKEmitterNode(fileNamed: "MyParticle.sks")
        
        skemeterNode?.particleSize=self.lastNode.size
        skemeterNode!.position = self.lastPosition
        skemeterNode?.zPosition = -5
        self.addChild(skemeterNode!)
        
        skemeterNode?.run(SKAction.sequence([SKAction.wait(forDuration: 1.0),SKAction.removeFromParent()]))
    }
    //MARK: 插屏广告代理方法
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        print("------123")
        if isWin {
            self.addChild(self.success)
        }else{
       
            self.addChild(self.fail)
        }
        
       
    }
    
    override func willMove(from view: SKView) {
       
        timeCount?.invalidate()
        appDelegate.soud.stopBgMusic()
        appDelegate.soud.stopBackMusic()
    }
}
