//
//  AppDelegate.swift
//  BolierPlateSample
//
//  Created by Dhruv Govila on 02/11/2017.
//  Copyright © 2017 Dhruv Govila. All rights reserved.
//

import UIKit
import CocoaLumberjack
import Locksmith
import RxCocoa
import RxSwift
import ReachabilitySwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let reachabilityObserval = PublishSubject<Bool>()
    let reachability = Reachability()!
    let disposebag = DisposeBag()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //DDLog
        DDLog.add(DDASLLogger.sharedInstance)
        DDLog.add(DDTTYLogger.sharedInstance)
        
        DDLogDebug("Welcome to DDLog")
        
        //StoreData in keyChain here
        do{try Locksmith.saveData(data:["hello Jayesh":"hii"], forUserAccount: AppConstant.keyChainAccount)
        }catch{DDLogDebug("error handel it")}
        
        //other way to store in keychain securely
        let ketchain = testSmit.init(username: "jayesh", password: "3Embed")
        do{try  ketchain.createInSecureStore()}catch{DDLogVerbose("opps error")}
        
        let readFromKeyChain = ketchain.readFromSecureStore()
        DDLogVerbose("dataHere\(String(describing: readFromKeyChain?.data))")
        
        
        //Reachability check here
        Reachability.rx.isReachable
            .subscribe(onNext: { isReachable in
                if isReachable == true {self.reachabilityChanged(isReachable)}
                else{self.reachabilityChanged(isReachable)}
            }).disposed(by: disposebag)
        
        do{try reachability.startNotifier()}
        catch{DDLogDebug("could not start reachability notifier")}
        
        return true
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
    
    
    
    
    
    func reachabilityChanged(_ isReachability: Bool) {
        if isReachability == true {
            DDLogDebug("Network is rechable now")
        } else {
            DDLogDebug("Network not reachable")
            Helper.showAlertViewOnWindow("Oops", message: "Check your InterNet Connections")
        }
    }
    
}

struct testSmit: CreateableSecureStorable, GenericPasswordSecureStorable,ReadableSecureStorable {
    
    // Required by CreateableSecureStorable
    var data: [String: Any] {
        return ["password": password as Any]
    }
    
    let username: String
    let password: String
    
    // Required by GenericPasswordSecureStorable
    let service = "jayesh"
    var account: String { return username }
    
    
}

