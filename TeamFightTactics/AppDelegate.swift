//
//  AppDelegate.swift
//  TeamFightTactics
//
//  Created by Alexander James Cooper on 22/07/2019.
//  Copyright © 2019 Alexander James Cooper. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        Auth.auth().signInAnonymously { [weak self] result, error in
            if let error = error { fatalError("Anon Sign In Failed: \(error)") }
            guard let self = self else { return }
            
            SetDataManager().setCurrentPatchVersion()
            self.isFirstTimeLaunchingApp()
            self.setGlobalCustomisations()
            
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.makeKeyAndVisible()
            self.window?.rootViewController = TabBarController()
        }
        
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


}


extension AppDelegate {
    //MARK: Is First Time Launching?
    private func isFirstTimeLaunchingApp() {
        let defaults = UserDefaults.standard
        let isFirstLaunch = !defaults.bool(forKey: UDKey.launchKey)
        if isFirstLaunch  {
            defaults.set(true, forKey: UDKey.launchKey)
            defaults.set(Tab.teamComps.rawValue, forKey: UDKey.tabKey)
            defaults.set(TFTSet.latest.rawValue, forKey: UDKey.setKey)
            defaults.set(true, forKey: UDKey.skinsKey)
            defaults.set(false, forKey: UDKey.sleepKey)
        }
    }
    
    //MARK: Set Global Customisation
    private func setGlobalCustomisations() {
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = ThemeColor.platinum
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: ThemeColor.platinum]
    }
}


