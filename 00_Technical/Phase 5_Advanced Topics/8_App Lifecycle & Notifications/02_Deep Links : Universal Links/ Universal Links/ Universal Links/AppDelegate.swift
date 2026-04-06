//
//  AppDelegate.swift
//   Universal Links
//
//  Created by somsak02061 on 6/11/2568 BE.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
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
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print("📩 Deep link:", url.absoluteString)
        
        if url.scheme == "myapp" {
            if url.host == "profile" {
                let userId = url.lastPathComponent
                print("เปิดหน้าโปรไฟล์ของ user:", userId)
                // นำทางไปยังหน้าโปรไฟล์
            }
        }
        return true
        
//    ตัวอย่างลิงก์:
//    👉 myapp://profile/123
//    จะเปิดแอป แล้วพาไปหน้า Profile ของ user 123
    }



}

