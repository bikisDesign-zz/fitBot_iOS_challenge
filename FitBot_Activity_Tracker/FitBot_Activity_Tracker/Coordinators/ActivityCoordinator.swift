//
//  ActivityCoordinator.swift
//  FitBot_Activity_Tracker
//
//  Created by Aaron bikis on 4/8/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit

final class ActivityCoordinator: NavigationCoordinator, NeedsDependency, UIViewControllerTransitioningDelegate {
  var dependencies: AppDependency? {
    didSet {
      updateChildCoordinatorDependencies()
      processQueuedMessages()
    }
  }
  
  var activityState: ActivityState = .overview
  
  override func start(with completion: @escaping () -> Void) {
    super.start(with: completion)
    let vc = ActivitiesViewController()
    vc.delegate = self
    show(vc)
  }
  
  //MARK: - UIViewControllerTransitioningDelegate
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    let animator = PresentReverseAnimator()
    animator.isPresenting = true
    return animator
  }
  
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    let animator = PresentReverseAnimator()
    animator.isPresenting = false
    return animator
  }
}

extension ActivityCoordinator: ActivitiesViewControllerDelegate {
  func presentNewActivityForm() {
    let vc = NewActivityViewController()
    
    let nc = UINavigationController(rootViewController: vc)
    nc.setNavigationBarHidden(true, animated: false)
    nc.transitioningDelegate = self
    
    present(nc)
  }
  
  func dismissNewActivityForm() {
    rootViewController.dismiss(animated: true, completion: nil)
  }
}
