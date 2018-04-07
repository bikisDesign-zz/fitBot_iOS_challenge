//
//  ApplicationCoordinator.swift
//  FitBot_Activity_Tracker
//
//  Created by Aaron bikis on 4/6/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import Foundation


final class ApplicationCoordinator: NavigationCoordinator, NeedsDependency {
  var dependencies: AppDependency? {
    didSet {
      updateChildCoordinatorDependencies()
      processQueuedMessages()
    }
  }
  
  
  override func start(with completion: @escaping () -> Void) {
    dependencies = AppDependency()
    
    super.start(with: completion)
    
    let vc = PastActivitiesViewController()
    show(vc)
  }
}
