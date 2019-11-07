//
//  GameViewController.swift
//  Sudoku
//
//  Created by Mac on 19/11/2018.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import GoogleMobileAds
class GameViewController: UIViewController {
   
    var dataArr = Array<String>()


    
    var skView:SKView?
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        let playRect = InfoManager.sharedInfoManager().playRect
       
        
        let sence = SceneManager.sharedSceneManager().selectScene(name: "main")
        
//        let skView:SKView = self.view as! SKView
        skView = self.view as? SKView
        skView?.presentScene(sence)

        
        AdManager.sharedAdManager().creatBannerAdView(vc: self)
    }
 
   
  
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
