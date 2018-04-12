//
//  AppDelegate.swift
//  FitBot_Activity_Tracker
//
//  Created by Aaron bikis on 4/6/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  lazy var applicationCoord: ApplicationCoordinator = ApplicationCoordinator(rootViewController: UINavigationController())
  
  
  func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = applicationCoord.rootViewController // creates the rootViewController on init
    return true
  }
  
  
  func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
    return true
  }
  
  
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    window?.makeKeyAndVisible()
    applicationCoord.start {
    }
    return true
  }
}

