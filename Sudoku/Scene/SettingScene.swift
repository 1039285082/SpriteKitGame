//
//  SettingScene.swift
//  Sudoku
//
//  Created by Mac on 28/11/2018.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import SpriteKit
import AVKit

class SettingScene: SKScene {
    
    private var backImgW:CGFloat = 300
    
    private var videoNameArr = Array<String>()
    
    private var selected = SKSpriteNode()
    private var selectViewBgArr = Array<String>()
    private var wallpaper = SKSpriteNode()
    private var wallpaperStrArr = Array<String>()
    private var background = SKSpriteNode()
    private var mainBtnArr = Array<String>()
    private var lockBtnArr = Array<String>()
    private var unlockBtnArr = Array<String>()
    private var gameBlcokArr = Array<String>()
    private var gameDiamondsArr = Array<String>()
    
    private var gameSuccessMenuBtnArr = Array<String>()
    private var gameSuccessNextBtnArr = Array<String>()
    private var gameFailureRestartBtnArr = Array<String>()
    private var stopBtnImgArr = Array<String>()
    
    private var pausedViewStartArr = Array<String>()
    private var pausedViewRestartArr = Array<String>()
    private var pausedViewMenuArr = Array<String>()
    
    private var backGroundMusicArr = Array<String>()
 
    let playRect = InfoManager.sharedInfoManager().playRect
    
    var margin:CGFloat = 50
    
    private var marginLeft:CGFloat = 100
    
    private var xieyiNode=SKSpriteNode()
    
    private var xieyiLabelNode = SKLabelNode()
    
    private var yinsiNode = SKSpriteNode()
    
    private var yinsiLabelNode = SKLabelNode()
    
    let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
    
    override func didMove(to view: SKView) {
        
        marginLeft = playRect.size.width/10
        
        
        backImgW = (playRect.width - 2 * marginLeft - margin)/3
        
        
        
        videoNameArr = ["1543199844293713.mp4","1543199844304770.mp4","1543199844313907.mp4","bj_1_fugu","bj_2_snow_view"]
        selectViewBgArr = ["select_bj_1","select_bj_3","select_bj_2","bj_1_fugu","bj_2_snow_view"]
        wallpaperStrArr = ["Retro".localized,"Snow".localized]
        mainBtnArr = ["button_rain_mian","button_mountain_main","button_stone_main","shouye_mukuai_fugu","button_snow_main"]
        lockBtnArr = ["suo_rain_select","suo_mountain_select","suo_stone_select","suo_select_fugu","suo_snow_select"]
        unlockBtnArr = ["button_rain_select","button_mountain_select","button_stone_select","zhengchang_select_fugu","button_snow_select"]
        gameBlcokArr = ["button_rain_view","button_mountain_view","button_stone_view","mukuai_fugu_view","button_snow_view"]
        gameDiamondsArr = ["juxing_rain_view","juxing_mountain_view","juxing_stone_view","juxing_fugu_view","juxing_snow_view"]
        
        gameSuccessMenuBtnArr = ["caidan_rain","caidan_mountain","caidan_stone","caidan_fugu","caidan_snow"]
        gameSuccessNextBtnArr = ["next_rain","next_mountain","next_stone","next_fugu","next_snow"]
        gameFailureRestartBtnArr = ["chong_rain","chongxin_mountain","chongxin_stone","chong_fugu","chong_snow"]
        stopBtnImgArr = ["stop_4","stop_2","stop_3","stop_1","stop_5"]
        
        pausedViewMenuArr = ["caidan_Leaf","caidan_hill","caidan_water","caidan_wood","caidan_ice"]
        pausedViewStartArr = ["kaishi_Leaf","kaishi_hill","kaishi_water","kaishi_wood","kaishi_ice"]
        pausedViewRestartArr = ["chongwan_Leaf","chongwan_hill","chongwan_water","chongwan_wood","chongwan_ice"]
        backGroundMusicArr = ["rain.m4a","river.m4a","birdsinging.m4a","fugu.mp3","winter.mp3"]
        creatUI()
        creatTitle()
        
    }
    
    
    func creatTitle(){
        
        
         let dataSource = NSKeyedUnarchiver.unarchiveObject(withFile:InfoManager.sharedInfoManager().userDataSource)as? DataSource
        
        let title = SKLabelNode(fontNamed: "Helvetica-BoldOblique")
        title.text = "Setting".localized
        title.fontSize = 80
        title.fontColor = .white
        title.position = CGPoint(x: self.size.width/2, y: self.size.height-150)
        
        title.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        title.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        
        self.addChild(title)
        
        let back = SKSpriteNode(imageNamed: "fanhui")
        back.name = "back"
        
        back.position = CGPoint(x: playRect.minX+back.size.width/2+100, y: playRect.maxY-150)
        
//        back.size = CGSize(width: 44, height: 44)
        
        self.addChild(back)
        
        
        let backAnimateImg = SKLabelNode(fontNamed: "Helvetica-BoldOblique")
        backAnimateImg.text = "Live Wallpaper".localized
        backAnimateImg.fontSize = 48
        backAnimateImg.position = CGPoint(x: playRect.minX+100, y: self.size.height/8*7)
        
        backAnimateImg.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        backAnimateImg.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        
        self.addChild(backAnimateImg)
        
        let sceneWallpaper = SKLabelNode(fontNamed: "Helvetica-BoldOblique")
        
        sceneWallpaper.text = "Scene Wallpaper".localized
        sceneWallpaper.fontSize = 48
        sceneWallpaper.position = CGPoint(x: playRect.minX+100, y: self.size.height/8*5)
        
        sceneWallpaper.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        sceneWallpaper.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        self.addChild(sceneWallpaper)
        
        let soundMusic = SKLabelNode(fontNamed: "Helvetica-BoldOblique")
        
        soundMusic.text = "Sound Setting".localized
        soundMusic.fontSize = 48
        soundMusic.position = CGPoint(x: playRect.minX+100, y: self.size.height/8*3)
        soundMusic.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        soundMusic.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        self.addChild(soundMusic)
        
        let backgroundMusicLabel = SKLabelNode(fontNamed: "Helvetica-BoldOblique")
        
        backgroundMusicLabel.text = "Background Music".localized
        backgroundMusicLabel.fontSize = 48
        backgroundMusicLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        backgroundMusicLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        
        backgroundMusicLabel.position = CGPoint(x:playRect.minX+120, y: self.size.height/8*3-200)
        
        
        backgroundMusicLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        backgroundMusicLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        
        self.addChild(backgroundMusicLabel)
        
        let backMusic = SKSpriteNode()
        
        
        
        let aboutUS = SKLabelNode(fontNamed: "Helvetica-BoldOblique")
        
        aboutUS.text = "About Us".localized
        aboutUS.fontSize = 48
        aboutUS.position = CGPoint(x: playRect.minX+100, y: self.size.height/8*3-400)
        aboutUS.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        aboutUS.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        self.addChild(aboutUS)
        
        xieyiNode = SKSpriteNode(imageNamed: "xieyi")
        xieyiNode.name = "xieyi"
        xieyiNode.position =  CGPoint(x: playRect.minX+100+xieyiNode.size.width/2, y: self.size.height/8*3-600)
        
       
        
        xieyiLabelNode = SKLabelNode(fontNamed: "Helvetica-BoldOblique")
        xieyiLabelNode.name = "xieyiLabel"
        xieyiLabelNode.text = "Terms Of Service".localized
        xieyiLabelNode.fontSize = 48
        xieyiLabelNode.position = CGPoint(x: xieyiNode.position.x+xieyiNode.size.width/2+20, y: self.size.height/8*3-600)
        xieyiLabelNode.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        xieyiLabelNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        
//        backgroundVideoName
        
        yinsiNode = SKSpriteNode(imageNamed: "yinsi")
        yinsiNode.texture = SKTexture(imageNamed: "yinsi1")
        yinsiNode.name = "yinsi"
        yinsiNode.position =  CGPoint(x: self.size.width/2+yinsiNode.size.width/2, y: self.size.height/8*3-600)
        
        
        
        yinsiLabelNode = SKLabelNode(fontNamed: "Helvetica-BoldOblique")
        yinsiLabelNode.name = "yinsiLabel"
        yinsiLabelNode.text = "Privacy Policy".localized
        yinsiLabelNode.fontSize = 48
        yinsiLabelNode.position = CGPoint(x: yinsiNode.position.x+yinsiNode.size.width/2+20, y: self.size.height/8*3-600)
        yinsiLabelNode.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        yinsiLabelNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        
        if dataSource!.backgroundVideoName.contains("snow") {
            
            yinsiNode.texture = SKTexture(imageNamed: "yinsi1")
            yinsiLabelNode.fontColor = .blue
            xieyiNode.texture = SKTexture(imageNamed: "xieyi1")
            xieyiLabelNode.fontColor = .blue
            
        }else{
            yinsiNode.texture = SKTexture(imageNamed: "yinsi")
            yinsiLabelNode.fontColor = .white
            xieyiNode.texture = SKTexture(imageNamed: "xieyi")
            xieyiLabelNode.fontColor = .white
            
        }
        
        
        
        self.addChild(xieyiNode)
        
        self.addChild(xieyiLabelNode)
        
        self.addChild(yinsiNode)
        
        self.addChild(yinsiLabelNode)
        
        
        
        if NSKeyedUnarchiver.unarchiveObject(withFile:InfoManager.sharedInfoManager().userDataSource) != nil {
            let dataSource = NSKeyedUnarchiver.unarchiveObject(withFile:InfoManager.sharedInfoManager().userDataSource)as? DataSource
            if dataSource!.BackMusic{
                backMusic.texture = SKTexture(imageNamed: "kaiqi")
                
            }else{
                backMusic.texture = SKTexture(imageNamed: "guanbi")
            }
            
        }
        
        backMusic.name = "backMisic"
        
        
        backMusic.position = CGPoint(x: playRect.minX+800, y: self.size.height/8*3-200)
        backMusic.size = CGSize(width: 82, height: 82)
        
        
        self.addChild(backMusic)
        
        
    }
    
    func creatUI(){
        
        let dataSource = NSKeyedUnarchiver.unarchiveObject(withFile:InfoManager.sharedInfoManager().userDataSource)as? DataSource
       
     
        selected = SKSpriteNode(imageNamed: "xuanze")
        selected.name = "selected"
        selected.zPosition = 2
        for i in 0...4 {
            if i<3{
                let url = URL(fileURLWithPath: videoNameArr[i], relativeTo: Bundle.main.resourceURL)
                let item = AVPlayerItem(url: url)
                
                let player = AVPlayer(playerItem: item)
                let backImg = SKVideoNode(avPlayer:player)
                
                
            NotificationCenter.default.addObserver(forName:.AVPlayerItemDidPlayToEndTime,object:player.currentItem,queue:nil)
                {
                    notification in
                    let targetTime = CMTimeMake(value: 0, timescale: Int32(NSEC_PER_SEC))
                    player.seek(to: targetTime)
                    player.play()
                }
                
                backImg.name = videoNameArr[i]
                backImg.size = CGSize(width: backImgW , height: backImgW)
                
                backImg.position = CGPoint(x:playRect.minX + marginLeft + backImg.size.width/2 + CGFloat(i) * (margin + backImg.size.width), y:self.size.height/8*6)


                print("\(backImg.position)")
                self.addChild(backImg)
                
            }else{
      
                    wallpaper = SKSpriteNode(imageNamed: videoNameArr[i])
                    wallpaper.name =  videoNameArr[i]
                     wallpaper.size = CGSize(width: backImgW , height: backImgW)
                    wallpaper.position = CGPoint(x:playRect.minX + marginLeft + wallpaper.size.width/2 + CGFloat(i-3) * (margin + wallpaper.size.width), y:self.size.height/8*4)
               
                    let classicalLabel = SKLabelNode(fontNamed: "Helvetica-BoldOblique")
                    
                    classicalLabel.text = wallpaperStrArr[i-3]
                    classicalLabel.fontSize = 80
                    classicalLabel.color = .white
                    
                    classicalLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
                    classicalLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
                    
                    wallpaper.addChild(classicalLabel)
                    
                    self.addChild(wallpaper)
            }
            
         
            if dataSource!.backgroundVideoName == videoNameArr[i] {
                if i < 3 {
                    selected.size = CGSize(width: backImgW/4, height: backImgW/4)
                    selected.position = CGPoint(x:  backImgW/4+selected.size.width/2 + playRect.minX + marginLeft + backImgW/2 + CGFloat(i) * (margin + backImgW), y:self.size.height/8*6 + backImgW/4+selected.size.width/2  )
                    
                }else{
                    selected.size = CGSize(width: backImgW/4, height: backImgW/4)
//                    selected.position =  CGPoint(x:  backImgW/3+15 + playRect.minX + marginLeft + backImgW/2 + CGFloat(i-3) * (margin + backImgW), y:self.size.height/8*4 + backImgW/3+15 )
                    selected.position =  CGPoint(x:  backImgW/4+selected.size.width/2  + playRect.minX + marginLeft + backImgW/2 + CGFloat(i-3) * (margin + backImgW), y:self.size.height/8*4 + backImgW/4+selected.size.width/2  )
                    
                }
                background = SKSpriteNode(imageNamed:selectViewBgArr[i])
                
                background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
                background.size = CGSize(width: self.size.width, height: self.size.height)
                background.zPosition = -5
                
                self.addChild(background)
                    
                }
                
            
            
            
        }
        self.addChild(selected)
        
      
        
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
                if node.name == "backMisic"{
                    
                    let sknode = node as! SKSpriteNode
                    
                    
                        let dataSource = NSKeyedUnarchiver.unarchiveObject(withFile:InfoManager.sharedInfoManager().userDataSource)as? DataSource
                        if dataSource!.BackMusic {
                            sknode.texture = SKTexture(imageNamed: "guanbi")
                            dataSource!.BackMusic = false
                            NSKeyedArchiver.archiveRootObject(dataSource!, toFile:InfoManager.sharedInfoManager().userDataSource)
                            

                        }else{
                            sknode.texture = SKTexture(imageNamed: "kaiqi")
                            dataSource!.BackMusic = true
                            NSKeyedArchiver.archiveRootObject(dataSource!, toFile:InfoManager.sharedInfoManager().userDataSource)

                        }
                        
                    
                    
                    
                    
                }
                let dataSource = NSKeyedUnarchiver.unarchiveObject(withFile:InfoManager.sharedInfoManager().userDataSource)as? DataSource
                for i in 0...4{
                    
                    
                    if node.name == videoNameArr[i]{
                        
                        if i < 3{
                            selected.position = CGPoint(x: backImgW/4+selected.size.width/2   + node.position.x , y:self.size.height/8*6 + backImgW/4+selected.size.width/2  )
                            
                            background.texture = SKTexture(imageNamed: selectViewBgArr[i])
                            
                            appDelegate.soud.creatBackMusic()
                          
                        }else{
                              selected.position = CGPoint(x:  backImgW/4+selected.size.width/2   + node.position.x , y:self.size.height/8*4 +  backImgW/4+selected.size.width/2  )
                             background.texture = SKTexture(imageNamed: selectViewBgArr[i])
                             appDelegate.soud.creatBackMusic()
                         
                         
                        }
                        if videoNameArr[i].contains("snow"){
                            
                            yinsiNode.texture = SKTexture(imageNamed: "yinsi1")
                            yinsiLabelNode.fontColor = .blue
                            xieyiNode.texture = SKTexture(imageNamed: "xieyi1")
                            xieyiLabelNode.fontColor = .blue
                            
                            
                        }else{
                            yinsiNode.texture = SKTexture(imageNamed: "yinsi")
                            yinsiLabelNode.fontColor = .white
                            xieyiNode.texture = SKTexture(imageNamed: "xieyi")
                            xieyiLabelNode.fontColor = .white
                        }
                      
                        dataSource?.backgroundVideoName = node.name!
                        dataSource?.selectViewBg = selectViewBgArr[i]
                        dataSource?.mainBtnImg = mainBtnArr[i]
                        dataSource?.lockBtnImg = lockBtnArr[i]
                        dataSource?.unlockBtnImg = unlockBtnArr[i]
                        dataSource?.gameBlockImg = gameBlcokArr[i]
                        dataSource?.gameDiamondsImg = gameDiamondsArr[i]
                        
                        dataSource?.gameSuccessMenuBtn = gameSuccessMenuBtnArr[i]
                        dataSource?.gameSuccessNextBtn = gameSuccessNextBtnArr[i]
                        dataSource?.gameFailureRestartBtn = gameFailureRestartBtnArr[i]
                        
                        dataSource?.stop = stopBtnImgArr[i]
                        
                        dataSource?.pausedViewMenu = pausedViewMenuArr[i]
                        dataSource?.pausedViewRestart = pausedViewRestartArr[i]
                        dataSource?.pausedViewStart = pausedViewStartArr[i]
                        dataSource?.backGroundMusic = backGroundMusicArr[i]
                        
                        NSKeyedArchiver.archiveRootObject(dataSource!, toFile:InfoManager.sharedInfoManager().userDataSource)
                    }
                }
                if node.name == "xieyi" || node.name == "xieyiLabel"{
                    let urlStr = "http://games.marvsites.com/terms/terms.html"
                    
                    
                    UIApplication.shared.openURL(URL(string: urlStr)!)
                    print("123")
                    
                }
                if node.name == "yinsi" || node.name == "yinsiLabel"{
                    let urlStr = "http://games.marvsites.com/terms/privacypolicy.html"
                    
                    
                    UIApplication.shared.openURL(URL(string: urlStr)!)
                    print("123")
                    
                }
                
            }
           
            
        }
        
        
    }
    override func willMove(from view: SKView) {
        appDelegate.soud.stopBackMusic()
    }
    
}
