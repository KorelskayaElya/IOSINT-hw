//
//  AppDelegate.swift
//  IOSINT
//
//  Created by Эля Корельская on 06.12.2022.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {


        // здесь пытаюсь подключить запуск первого launch screen - пока не работает
        let passwordView = PasswordViewController(updatePassword: false)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = passwordView
        window?.makeKeyAndVisible()
        return true
    }
    
    
    // это не нужно
    //        FirebaseApp.configure()
//    // когда приложение закрывается - пользователь разлогинен
//    func applicationWillTerminate(_ application: UIApplication) {
//         do {
//             try Auth.auth().signOut()
//         } catch let signOutError as NSError {
//             print ("Error signing out: %@", signOutError)
//         }
//    }

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

