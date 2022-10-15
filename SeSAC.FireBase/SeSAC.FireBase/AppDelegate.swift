//
//  AppDelegate.swift
//  SeSAC.FireBase
//
//  Created by Joonhwan Jeon on 2021/12/06.
//

import UIKit
import Firebase
import AppTrackingTransparency

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //Firebase 초기화, 공유 인스턴스 생성
        FirebaseApp.configure()
        
        //ATT FrameWork
        ATTrackingManager.requestTrackingAuthorization { Status in
            switch Status {
            case .notDetermined:
                print("notDetermined")
                Analytics.setAnalyticsCollectionEnabled(false)
            case .restricted:
                print("restricted")
                Analytics.setAnalyticsCollectionEnabled(false)
            case .denied:
                print("denied")
                Analytics.setAnalyticsCollectionEnabled(false)
            case .authorized:
                print("authorized")
                Analytics.setAnalyticsCollectionEnabled(true)
            @unknown default:
                print("unknown")
                Analytics.setAnalyticsCollectionEnabled(false)
            }
        }
        
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

