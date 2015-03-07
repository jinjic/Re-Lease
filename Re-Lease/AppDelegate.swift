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
        
        //navigation style stuff
        // styling
        let navigationBarAppearace = UINavigationBar.appearance()
        
        navigationBarAppearace.barTintColor = UIColor(red: 32/255, green: 69/255, blue: 125/255, alpha: 1.0)
        navigationBarAppearace.tintColor = UIColor.whiteColor()
        
        // change navigation item title color
        navigationBarAppearace.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        
        
        let aWindow = UIWindow(frame: UIScreen.mainScreen().bounds)
        window = aWindow
        
        let tabBarController: UITabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 100)
        // My Posts Setup
        let myPostsTableViewController = MyPostsTableViewController(style: UITableViewStyle.Grouped)
        let myPostsNavController = UINavigationController(rootViewController: myPostsTableViewController)
        let myPostsTabBarItem = UITabBarItem(title: "My Post", image: UIImage(named: "my_listings"), tag: 0)
        myPostsNavController.tabBarItem = myPostsTabBarItem
        myPostsTabBarItem.title = "My Posts"
        
        // Notifications SetUp
        let myNotifications = NotificationsViewController(style: UITableViewStyle.Plain)
        let myNotificationNavController = UINavigationController(rootViewController: myNotifications)
        let myNotificationTabBarItem = UITabBarItem(title: "Notifications", image:UIImage(named: "notifications"), tag: 0 )
        myNotificationNavController.tabBarItem = myNotificationTabBarItem
        myNotificationTabBarItem.title = "Notifications"
        
        // My Profile Setup
        let myProfile = ProfileViewController(style: UITableViewStyle.Grouped)
        let myProfileNavController = UINavigationController(rootViewController: myProfile)
        let myProfileTabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile"), tag: 0)
        myProfileNavController.tabBarItem = myProfileTabBarItem
        myProfileTabBarItem.title = "Profile"
        
        // my Listing setup
        let myListings = ListingsViewController(style: UITableViewStyle.Plain)
        let myListingNavController = UINavigationController(rootViewController: myListings)
        let myListingTabBarItem = UITabBarItem(title: "Listings", image: UIImage(named: "listings"), tag: 0)
        myListingNavController.tabBarItem = myListingTabBarItem
        myListingTabBarItem.title = "Rooms"
        
        // current order or tab bar items should be
        // 1. Map View Controller
        // 2. My Posts View Controller
        // 3. Profile??
        // REMEMBER to put the nav controller in the array, not the contrllers themselves
        tabBarController.viewControllers = [ myListingNavController, myNotificationNavController, myPostsNavController, myProfileNavController]
        
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

