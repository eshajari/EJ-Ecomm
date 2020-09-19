//
//  AppDelegate.swift
//  EcommApp
//
//  Created by apple on 18/09/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let realm = try! Realm()
        let folderPath = realm.configuration.fileURL!.deletingLastPathComponent().path
        print("Realm DB path:\n\(folderPath)")
        // Disable file protection for this directory
        try! FileManager.default.setAttributes([FileAttributeKey(rawValue: FileAttributeKey.protectionKey.rawValue): FileProtectionType.none], ofItemAtPath: folderPath)
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

