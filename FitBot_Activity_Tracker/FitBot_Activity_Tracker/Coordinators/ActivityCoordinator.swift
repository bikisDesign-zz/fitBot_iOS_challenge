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
  func addNewActivity(sender: ActivitiesViewController) {
    if dependencies?.strava.acessToken == nil { // user is not logged in
      
      sender.show(alertWithType: Content.AuthorizeStravaAlert()) { (shouldAuth) in
        if shouldAuth {
          
          let wv = StravaAuthViewController()
          let nc = UINavigationController(rootViewController: wv)
          wv.delegate = self
          self.present(nc)
        }
      }
      return
    }
    let vc = NewActivityViewController(datasource: .newActivity)
    vc.delegate = self
    let nc = UINavigationController(rootViewController: vc)
    nc.setNavigationBarHidden(true, animated: false)
    nc.transitioningDelegate = self
    present(nc)
  }
}


extension ActivityCoordinator: NewActivityViewControllerDelegate {
  func didValidateAllFields(withCredentials credentials: Credentials) {
    //parse Activity
    guard let activity = Activity(date: credentials[LocalFormFieldType.date]!,
                            time: credentials[LocalFormFieldType.time]!,
                            distance: credentials[LocalFormFieldType.distance]!),
    let token = dependencies?.strava.acessToken else { return }
    
    // post activity
    self.dependencies?.networking.post(activity: activity, token: token, callback: { (success) in
      if success {
        
        // pop top VC
        self.rootViewController.dismiss(animated: true, completion: {
          
          //update actvitiesVC datasource
          guard let vc = self.viewControllers.filter({ $0 is ActivitiesViewController }).first as? ActivitiesViewController else { return }
          
          vc.updateDataSource(newActivity: activity)
        })
      }
    })
  }
  
  func dismissNewActivityVC() {
    rootViewController.dismiss(animated: true, completion: nil)
  }
}

extension ActivityCoordinator: StravaAuthViewControllerDelegate {
  
  func received(code: String) {
    dependencies?.strava.code = code // save the code in temp
    dependencies?.networking.requestAcessToken(code: code, callback: { (accessToken) in
      if let accessToken = accessToken {
        self.dependencies?.strava.acessToken = accessToken // save the token in temp
        self.rootViewController.dismiss(animated: true, completion: nil)
      }
    })
  }
}
