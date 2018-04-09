//
//  ActivityCoordinator.swift
//  FitBot_Activity_Tracker
//
//  Created by Aaron bikis on 4/8/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit

final class ActivityCoordinator: NavigationCoordinator, NeedsDependency {
  var dependencies: AppDependency? {
    didSet {
      updateChildCoordinatorDependencies()
      processQueuedMessages()
    }
  }
  
  override func start(with completion: @escaping () -> Void) {
    super.start(with: completion)
    let vc = ActivitiesViewController()
    vc.delegate = self
    show(vc)
  }
  
//  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//    return TopPresentAnimationController(originFrame: view.frame)
//  }
}

extension ActivityCoordinator: ActivitiesViewControllerDelegate {
  func presentNewActivityForm() {
    let vc = NewActivityViewController()
    show(vc)
  }
}
