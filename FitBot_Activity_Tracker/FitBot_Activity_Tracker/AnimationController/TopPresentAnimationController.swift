//
//  TopPresentAnimationController.swift
//  FitBot_Activity_Tracker
//
//  Created by Aaron bikis on 4/8/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit

class TopPresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
  
  private let originFrame: CGRect
  
  init(originFrame: CGRect) {
    self.originFrame = originFrame
  }
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 2.0
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    guard let fromVC = transitionContext.viewController(forKey: .from),
          let toVC = transitionContext.viewController(forKey: .to),
          let snapshot = toVC.view.snapshotView(afterScreenUpdates: true) else { return }
    
    let containerView = transitionContext.containerView
    let finalFrame = transitionContext.finalFrame(for: toVC)
    
    snapshot.frame = originFrame
    snapshot.layer.masksToBounds = true
    containerView.addSubview(toVC.view)
    containerView.addSubview(snapshot)
    toVC.view.isHidden = true
    
    let duration = transitionDuration(using: transitionContext)
    
    UIView.animateKeyframes(
      withDuration: duration,
      delay: 0,
      options: .calculationModeCubic,
      animations: {
        
        UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/3) {
          snapshot.frame = CGRect(x: 0, y: 0 - finalFrame.height, width: finalFrame.width, height: finalFrame.height)
        }
    
      
        UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3) {
          snapshot.frame = finalFrame
        }
    },
      // 5
      completion: { _ in
        toVC.view.isHidden = false
        snapshot.removeFromSuperview()
        
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
    })
  }
  
  
}
