//
//  AddButton.swift
//  FitBot_Activity_Tracker
//
//  Created by Aaron bikis on 4/7/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit

protocol AddButtonDelegate: class {
  func addButtonDidFinishShrinking()
}

final class PopButton: UIView, CAAnimationDelegate {
  
  weak var delegate: AddButtonDelegate?
  
  var iconImage: UIImage?
  
  private lazy var circleLayer: CAShapeLayer = {
    let cLayer = CAShapeLayer()
    cLayer.fillColor = Theme.Colors.fitBotRed.color.cgColor
    layer.addSublayer(cLayer)
    return cLayer
  }()
  
  private lazy var iconImageLayer: CALayer = {
    let iconLayer = CALayer()
    iconLayer.backgroundColor = UIColor.clear.cgColor
    iconLayer.contentsGravity = kCAGravityResizeAspect
    iconLayer.contents = iconImage?.cgImage
    layer.addSublayer(iconLayer)
    return iconLayer
  }()
  
  override func layoutSubviews() {
    super.layoutSubviews()
    // create the shape layer set to the circle's path
    let circlePath = UIBezierPath(ovalIn: bounds)
    circleLayer.path = circlePath.cgPath
    
    // create an image layer to go over the circle
    let size = min(bounds.width - 15, bounds.height - 15)
    let iconCenter = min(bounds.width / 2, bounds.height / 2)
    
    iconImageLayer.bounds = CGRect(x: 0, y: 0,
                                   width: size, height: size)
    
    iconImageLayer.position = CGPoint(x: iconCenter, y: iconCenter)
  }
  
  
  func addTapRecognizer(with target: Any, selector: Selector){
    let tgr = UITapGestureRecognizer(target: target, action: selector)
    addGestureRecognizer(tgr)
  }
  
  
  // Action Items
  func shrink(){
    animateCircle() {
      self.delegate?.addButtonDidFinishShrinking()
    }
  }
  
  // animate circle shrink or expand
  private func animateCircle(with callback: @escaping() -> ()){
    
    CATransaction.begin()
    CATransaction.setAnimationDuration(0.25)
    CATransaction.setCompletionBlock { // need to set the completion handler BEFORE setting the animation
      
      CATransaction.begin()
      CATransaction.setAnimationDuration(0.25)
      CATransaction.setCompletionBlock({
        callback()
      })
      
      self.setAnimationProperties(isFirstAnim: false)
      CATransaction.commit()
    }
    
    setAnimationProperties(isFirstAnim: true)
    CATransaction.commit()
  }
  
  
  private func setAnimationProperties(isFirstAnim: Bool){
    if isFirstAnim {
      CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault))
      circleLayer.transform = CATransform3DMakeScale(1.15, 1.15, 1)
      return
    }
    CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn))
    self.circleLayer.transform = CATransform3DMakeScale(0, 0, 1)
  }
}
