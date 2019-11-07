//
//  AdManager.swift
//  Sudoku
//
//  Created by Mac on 18/12/2018.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import SpriteKit
import GoogleMobileAds
class AdManager: NSObject {
    
    var adBanner: GADBannerView?
    var gameVC:UIViewController?
    var interstitial: GADInterstitial!
    
    
    static let instance:AdManager = AdManager()
    class func sharedAdManager() -> AdManager {
    
        
        return instance
    }
    func creatBannerAdView(vc:UIViewController){
        if gameVC==nil {
            self.gameVC = vc
        }
        adBanner = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        adBanner!.tag = 1
        adBanner!.adUnitID = "ca-app-pub-9894561765365020/5497304301"
        adBanner!.rootViewController = gameVC
        adBanner!.load(GADRequest())

        adBanner!.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height - adBanner!.frame.size.height, width: adBanner!.frame.width, height: adBanner!.frame.height)
        gameVC!.view.addSubview(adBanner!)
    }
    
    func creatInterstitial() {
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-9894561765365020/2387214790")
        let request = GADRequest()
        request.testDevices = [ kGADSimulatorID, "2077ef9a63d2b398840261c8221a0c9a" ]

        interstitial.load(request)
        
       
    }
    
   
    func displayAd(on view: SKView) {
        if let banner = adBanner {
            if view.viewWithTag(1) == nil {
                view.addSubview(banner)
            }
        }
    }
    func removeAd(from view: SKView) {
        if let banner = adBanner {
            if view.viewWithTag(1) != nil {
                banner.removeFromSuperview()
            }
        }
    }
   
}
