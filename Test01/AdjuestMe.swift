//
//  Evaluateme.swift
//  Test01
//
//  Created by IOS App on 17/1/2.
//  Copyright © 2017年 zghsnail. All rights reserved.
//

import UIKit
import StoreKit

class Evaluateme: NSObject {
    
    private var BeginTime : Double!
    private var EndTime   : Double!
    private let name = "AdJusetMe.me"
    private var longTime = 2 * 3600.00
    private var AppID = ""
    private let IsPingStr = "wqjpqwekqwkeq"
    private var IsPing = UserDefaults.standard.bool(forKey: "wqjpqwekqwkeq")

    func weakMeUp(appid:String,time:Double) {
        AppID = appid
        longTime = time
        
        judgeMe()
        
        //程序启动并进行初始化
        getUIApplicationDidFinishLaunchingNotification()
        //程序进入前台并处于活动状态
        NotificationCenter.default.addObserver(self, selector: #selector(getUIApplicationDidBecomeActiveNotification), name: NSNotification.Name(rawValue: "UIApplicationDidBecomeActiveNotification"), object: nil)
        //从活动状态进入非活动
        NotificationCenter.default.addObserver(self, selector: #selector(getUIApplicationWillResignActiveNotification), name: NSNotification.Name(rawValue: "UIApplicationWillResignActiveNotification"), object: nil)
        //程序进入后台时调用
        NotificationCenter.default.addObserver(self, selector: #selector(getUIApplicationDidEnterBackgroundNotification), name: NSNotification.Name(rawValue: "UIApplicationDidEnterBackgroundNotification"), object: nil)
        //程序进入前台
        NotificationCenter.default.addObserver(self, selector: #selector(getUIApplicationWillEnterForegroundNotification), name: NSNotification.Name(rawValue: "UIApplicationWillEnterForegroundNotification"), object: nil)
        //程序被杀死时调用
        NotificationCenter.default.addObserver(self, selector: #selector(getUIApplicationWillTerminateNotification), name: NSNotification.Name(rawValue: "UIApplicationWillTerminateNotification"), object: nil)
        
    }
    
    private func getUIApplicationDidFinishLaunchingNotification() {
        BeginTime = NSDate().timeIntervalSince1970
        print("...............")
    }
    
    @objc private func getUIApplicationDidBecomeActiveNotification() {
        BeginTime = NSDate().timeIntervalSince1970
        print("...............")
    }
    
    @objc private func getUIApplicationWillResignActiveNotification() {
        EndTime   = NSDate().timeIntervalSince1970
        saveTime()
        print("...............")
    }
    
    @objc private func getUIApplicationDidEnterBackgroundNotification() {
        EndTime   = NSDate().timeIntervalSince1970
        saveTime()
        print("...............")
    }
    
    @objc private func getUIApplicationWillEnterForegroundNotification() {
        BeginTime = NSDate().timeIntervalSince1970
        print("...............")
    }
    
    @objc private func getUIApplicationWillTerminateNotification() {
        EndTime   = NSDate().timeIntervalSince1970
        saveTime()
        print("...............")
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
