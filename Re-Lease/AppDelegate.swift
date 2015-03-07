//
//  AppDelegate.swift
//  Re-Lease
//
//  Created by Josip Injic on 3/6/15.
//  Copyright (c) 2015 Josip Injic. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UITabBarControllerDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // DON'T put anything above this line!!
        Parse.setApplicationId("Rk1d1SEHNmOUlwT76B2uQW6QslXguSw4KbmM6PHk", clientKey: "IQYqfqgdyJaADL7WWhIxskOWyLBN8N7GccJd1oRi")
        
        let aWindow = UIWindow(frame: UIScreen.mainScreen().bounds)
        window = aWindow
        
        let tabBarController: UITabBarController = UITabBarController()
        
        // Map View Setup
        let homeScreen = ViewController()
        let navController = UINavigationController(rootViewController: homeScreen)
        navController.setNavigationBarHidden(false, animated: true)
        
        // My Posts Setup
        let myPostsTableViewController = MyPostsTableViewController()
        let myPostsNavController = UINavigationController(rootViewController: myPostsTableViewController)
        
        let notificationViewController = NotificationsViewController()
        let navigationViewController = UINavigationController(rootViewController: notificationViewController)
        
        // current order or tab bar items should be
        // 1. Map View Controller
        // 2. My Posts View Controller
        // 3. Profile??
        // REMEMBER to put the nav controller in the array, not the contrllers themselves
        tabBarController.viewControllers = [navController, myPostsNavController, navigationViewController]
        
        // set the windown make it visible
        aWindow.rootViewController = tabBarController
        aWindow.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

