//
//  AppDelegate.swift
//  njdtmaster
//
//  Created by 尹浩 on 2018/1/12.
//  Copyright © 2018年 尹浩. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        return true
    }
    func loadMainView(){
        
        let sideVC = SideViewController()
        
        let currentMainVC = UITabBarController.init()
        let navResuceTask = UINavigationController(rootViewController: ResuceTaskVC())
        let navMyResuce = UINavigationController(rootViewController: MyResuceVC())
        let navMaintPlan = UINavigationController(rootViewController: MaintPlanVC())
        let navMyMaint = UINavigationController(rootViewController: MyMaintVC())
        
        //设置标签页底部样式
        currentMainVC.self.tabBar.isTranslucent = false
        currentMainVC.self.tabBar.backgroundImage = UIImage(named:"bg_tabbar")
        currentMainVC.self.tabBar.tintColor = UIColor.white
        currentMainVC.self.view.backgroundColor = UIColor.white
        
        navResuceTask.tabBarItem.title = "救援任务"
        navResuceTask.tabBarItem.image = UIImage(named:"icon_task_normal")
        
        
        navMyResuce.tabBarItem.title = "我的救援"
        navMyResuce.tabBarItem.image = UIImage(named:"icon_rescue_normal")
        navMaintPlan.tabBarItem.title = "维保计划"
        navMaintPlan.tabBarItem.image = UIImage(named:"icon_setting_normal")
        navMyMaint.tabBarItem.title = "我的维保"
        navMyMaint.tabBarItem.image = UIImage(named:"icon_rank_normal")
        currentMainVC.viewControllers = [navResuceTask, navMyResuce, navMaintPlan, navMyMaint]
        let rootVC = XYSideViewControllerSwift(sideVC, currentMainVC)
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this   is called instead of applicationWillTerminate: when the user quits.
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

