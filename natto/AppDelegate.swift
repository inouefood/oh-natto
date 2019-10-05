//
//  AppDelegate.swift
//  natto
//
//  Created by 佐川　晴海 on 2018/03/09.
//  Copyright © 2018年 佐川　晴海. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = NattoViewController()
        self.window?.makeKeyAndVisible()
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) {(granted, error) in
            if granted {
                print("許可する")
            } else {
                print("許可しない")
            }
        }
        setLocalNotification(title:"今日は納豆の日です", message:"oh! natto!で納豆を混ぜてみませんか？",month: 7, day: 10)
        return true
    }
    
    private func setLocalNotification(title:String = "", message:String, month: Int, day: Int,hour:Int = 9, minute:Int = 0, second:Int = 0 ){
        // タイトル、本文、サウンド設定の保持
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = message
        content.sound = UNNotificationSound.default
        
        var notificationTime = DateComponents()
        notificationTime.month = month
        notificationTime.day = day
        notificationTime.hour = hour
        notificationTime.minute = minute
        notificationTime.second = second
        
        let trigger: UNNotificationTrigger = UNCalendarNotificationTrigger(dateMatching: notificationTime, repeats: false)
        
        // 識別子とともに通知の表示内容とトリガーをrequestに内包
        let request = UNNotificationRequest(identifier: "Natto", content: content, trigger: trigger)
        
        // UNUserNotificationCenterにrequestを加える
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.add(request) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
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

extension AppDelegate: UNUserNotificationCenterDelegate{
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // アプリ起動中でもアラートと音で通知
        completionHandler([.alert, .sound])
    }
}

