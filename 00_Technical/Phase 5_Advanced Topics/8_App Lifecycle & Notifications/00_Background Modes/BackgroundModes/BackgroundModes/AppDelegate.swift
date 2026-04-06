//🚀 1. Background Fetch
//
//ใช้ให้แอป “โหลดข้อมูลเบื้องหลัง” เป็นระยะ
//เช่น อัปเดตข่าว, ดึง feed ล่าสุด โดยระบบจะเรียกอัตโนมัติ
//
//✅ เปิดใช้งาน
//
//เปิด Background Modes → ติ๊ก Background fetch
//เพิ่มใน AppDelegate:

import UIKit
import BackgroundTasks

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // โหลดข้อมูลใหม่
//            fetchLatestNews { success in
//                if success {
//                    completionHandler(.newData)
//                } else {
//                    completionHandler(.failed)
//                }
//            }
        
        UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplication.backgroundFetchIntervalMinimum)
        
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
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler:
                     @escaping (UIBackgroundFetchResult) -> Void) {
        
        //        🔔 5. Remote Notifications (Push)
        //        ใช้สำหรับให้แอป “ตื่นขึ้น” เพื่ออัปเดตข้อมูลเบื้องหลังเมื่อได้รับ notification
        //        เปิด “Background Modes → Remote notifications”
        //        เมื่อมี push มาถึง:
        
        // ดึงข้อมูลใหม่จาก server
        completionHandler(.newData)
    }

//    ⚙️ 6. Background Processing (iOS 13+)
//
//    สำหรับงานที่ “ใช้เวลานาน” เช่น AI model training, file cleanup ฯลฯ
//    ทำผ่าน BGTaskScheduler
//    ต้อง register identifier ใน Info.plist ด้วย key
//    Permitted background task scheduler identifiers
    
    func scheduleBackgroundTask() {
        let request = BGAppRefreshTaskRequest(identifier: "com.myapp.refresh")
        request.earliestBeginDate = Date(timeIntervalSinceNow: 15 * 60)
        try? BGTaskScheduler.shared.submit(request)
    }

    func handleBackgroundTask(task: BGAppRefreshTask) {
        scheduleBackgroundTask()
//        fetchLatestNews { _ in
//            task.setTaskCompleted(success: true)
//        }
    }


}

