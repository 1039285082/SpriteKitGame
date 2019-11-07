//
//  AppDelegate.swift
//  Sudoku
//
//  Created by Mac on 19/11/2018.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import AVFoundation
import GoogleMobileAds
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var soud = SoundManager.sharedSoundManager()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GADMobileAds.configure(withApplicationID: "ca-app-pub-9894561765365020~5070816940")
        
        creatDataBase()
//        creatBgSound()
        return true
    }
//    func creatBgSound() {
//        let dataSource =  NSKeyedUnarchiver.unarchiveObject(withFile:InfoManager.sharedInfoManager().userDataSource) as! DataSource
//        if dataSource.BackMusic{
//            soud.creatBgMusic()
//        }
//    }
    
    func creatDataBase(){
        if NSKeyedUnarchiver.unarchiveObject(withFile:InfoManager.sharedInfoManager().userDataSource) == nil {
            let dataSource = DataSource()
            NSKeyedArchiver.archiveRootObject(dataSource, toFile:InfoManager.sharedInfoManager().userDataSource)
        }
        if NSKeyedUnarchiver.unarchiveObject(withFile: InfoManager.sharedInfoManager().saveSuccessEasy()) == nil{
            let levelArrModel = LevelArrModel()
            NSKeyedArchiver.archiveRootObject(levelArrModel, toFile: InfoManager.sharedInfoManager().saveSuccessEasy())
            
        }
        if NSKeyedUnarchiver.unarchiveObject(withFile: InfoManager.sharedInfoManager().saveSuccessAdvanced()) == nil{
            let levelArrModel = LevelArrModel()
            NSKeyedArchiver.archiveRootObject(levelArrModel, toFile: InfoManager.sharedInfoManager().saveSuccessAdvanced())
            
        }
        if NSKeyedUnarchiver.unarchiveObject(withFile: InfoManager.sharedInfoManager().saveSuccessDifficulty()) == nil{
            let levelArrModel = LevelArrModel()
            NSKeyedArchiver.archiveRootObject(levelArrModel, toFile: InfoManager.sharedInfoManager().saveSuccessDifficulty())
            
        }
        if NSKeyedUnarchiver.unarchiveObject(withFile: InfoManager.sharedInfoManager().saveSuccessExpert()) == nil{
            let levelArrModel = LevelArrModel()
            NSKeyedArchiver.archiveRootObject(levelArrModel, toFile: InfoManager.sharedInfoManager().saveSuccessExpert())
            
        }
        if NSKeyedUnarchiver.unarchiveObject(withFile: InfoManager.sharedInfoManager().saveSuccessCrazy()) == nil{
            let levelArrModel = LevelArrModel()
            NSKeyedArchiver.archiveRootObject(levelArrModel, toFile: InfoManager.sharedInfoManager().saveSuccessCrazy())
            
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

