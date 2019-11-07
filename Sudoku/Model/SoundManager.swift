//
//  SoundManager.swift
//  Sudoku
//
//  Created by Mac on 12/12/2018.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation
class SoundManager: SKNode {
    var bgMusicPlayer:AVAudioPlayer?
    
    var backSound:AVAudioPlayer?
    static let instance:SoundManager = SoundManager()
    class func sharedSoundManager() -> SoundManager {
        return instance
    }
    
    func creatBgMusic(){
        
         let dataSource = NSKeyedUnarchiver.unarchiveObject(withFile:InfoManager.sharedInfoManager().userDataSource)as? DataSource
        var type:String
        var source:String
        if dataSource!.backGroundMusic.contains(".mp3") {
            let arr = dataSource!.backGroundMusic.components(separatedBy: ".mp3")
            print("\(arr[0])")
            source = arr[0]
            type = ".mp3"
            
        }else{
            let arr = dataSource!.backGroundMusic.components(separatedBy: ".m4a")
            source = arr[0]
            type = ".m4a"
            
        }
        
        
        let bgMusicURL =  Bundle.main.url(forResource: source, withExtension: type)!
        //根据背景音乐地址生成播放器
        //        var bgMusicPlayer = AVAudioPlayer()
        
        do{
            bgMusicPlayer = try AVAudioPlayer(contentsOf: bgMusicURL)
            //设置为循环播放(
            bgMusicPlayer!.numberOfLoops = -1
            
            bgMusicPlayer!.volume = 0.3
            //准备播放音乐
            bgMusicPlayer?.prepareToPlay()
            //播放音乐
            bgMusicPlayer?.play()
            
            
            
        }catch let error{
            print(error.localizedDescription)
        }
    }
    func stopBgMusic(){
        bgMusicPlayer?.stop()
    }
    
    func creatBackMusic()  {
        
        
        
        let backUrl = Bundle.main.url(forResource: "back", withExtension: "mp3")!
        
        do{
            backSound = try AVAudioPlayer(contentsOf: backUrl)
            
            //设置为循环播放(
            backSound!.numberOfLoops = 0
            
            backSound!.volume = 0.4
            //准备播放音乐
            backSound!.prepareToPlay()
            //播放音乐
            backSound!.play()
//            backSound = nil
        }catch let error{
            print(error.localizedDescription)
        }
        
    }
    
    func stopBackMusic() {
//        backSound?.
    }
    
}
