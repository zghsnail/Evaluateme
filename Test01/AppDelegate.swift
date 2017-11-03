//
//  AppDelegate.swift
//  Test01
//
//  Created by IOS App on 17/1/27.
//  Copyright © 2017年 nova. All rights reserved.
//

import UIKit
import StoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var BeginTime : Double!
    private var EndTime   : Double!
    private let name = "AdJusetMe.me"
    private var longTime = 15.0
    private var AppID = ""
    private let IsPingStr = "wqjpqwekqwkeq"
    private var IsPing = UserDefaults.standard.bool(forKey: "wqjpqwekqwkeq")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        BeginTime = NSDate().timeIntervalSince1970
        if !UserDefaults.standard.bool(forKey: IsPingStr) {
            judgeMe()
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        EndTime   = NSDate().timeIntervalSince1970
        saveTime()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        EndTime   = NSDate().timeIntervalSince1970
        saveTime()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        BeginTime = NSDate().timeIntervalSince1970
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        BeginTime = NSDate().timeIntervalSince1970
    }

    func applicationWillTerminate(_ application: UIApplication) {
        EndTime   = NSDate().timeIntervalSince1970
        saveTime()
    }
    
    private func saveTime(){
        let userdef = UserDefaults.standard
        let before = userdef.double(forKey: name)
        userdef.set(before + EndTime - BeginTime, forKey: name)
        userdef.synchronize()
        
    }

    private func judgeMe() {
        if UserDefaults.standard.double(forKey: name) >= longTime {
            //评价
            if #available(iOS 10.3, *) {
                SKStoreReviewController.requestReview()
                isPingStr()
            } else {
                // Fallback on earlier versions
                let url = "itms-apps://itunes.apple.com/app/id" + AppID + "?action=write-review"
                UIApplication.shared.openURL(URL(string: url)!)
                isPingStr()
            }
        }
    }
    
    private func isPingStr(){
        UserDefaults.standard.set(true, forKey: IsPingStr)
    }

}

