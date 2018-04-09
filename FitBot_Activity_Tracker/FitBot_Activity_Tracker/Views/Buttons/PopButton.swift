//
//  AddButton.swift
//  FitBot_Activity_Tracker
//
//  Created by Aaron bikis on 4/7/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit

protocol AddButtonDelegate: class {
  func animationFinished()
}

final class PopButton: UIView, CAAnimationDelegate {
  
  enum PopButtonAnimationState {
    case isHidden
    case isVisible
  }
  
  var animationState: PopButtonAnimationState = .isVisible
  
  weak var delegate: AddButtonDelegate?
  
  var iconImage: UIImage?
  
  private lazy var circleLayer: CAShapeLayer = {
    let cLayer = CAShapeLayer()
    cLayer.fillColor = Theme.Colors.fitBotRed.color.cgColor
    return cLayer
  }()
  
  private var darkCircleLayer = CAShapeLayer()
  
  private lazy var iconImageLayer: CALayer = {
    let iconLayer = CALayer()
    iconLayer.backgroundColor = UIColor.clear.cgColor
    iconLayer.contentsGravity = kCAGravityResizeAspect
    iconLayer.contents = iconImage?.cgImage
    circleLayer.addSublayer(iconLayer)
    return iconLayer
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    layer.addSublayer(darkCircleLayer)
    layer.addSublayer(circleLayer)
  }
  required init?(coder aDecoder: NSCoder) { fatalError() }
  
  
  override func layoutSubviews() {
    super.layoutSubviews()
    // create the shape layer set to the circle's path
    let circlePath = UIBezierPath(ovalIn: bounds)
    circleLayer.path = circlePath.cgPath
    circleLayer.bounds = bounds
    
    darkCircleLayer.path = circlePath.cgPath
    darkCircleLayer.bounds = bounds
    darkCircleLayer.fillColor = UIColor.black.cgColor
    darkCircleLayer.opacity = 0
    
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
  
  
  //MARK: Action Items
  func shrink(){
    animateCircle(forProperties: setShrinkAnimationProperties(isFirstAnim:)) {
      self.delegate?.animationFinished()
      self.animationState = .isHidden
    }
  }
  
  func lightenExpand(){
    animateCircle(forProperties: setLightenExpandProperties(isFirstAnim:)) {
      self.animationState = .isVisible
    }
  }
  
  func darkenExpand(){
    darkCircleLayer.opacity = 1
    animateCircle(forProperties: setDarkenExpandProperties(isFirstAnim:)) {
      self.delegate?.animationFinished()
      self.animationState = .isHidden
    }
  }
  
  // Helper animation method
  private func animateCircle(forProperties properties: @escaping (Bool) -> (), with callback: @escaping() -> ()){
    
    CATransaction.begin()
    CATransaction.setAnimationDuration(0.25)
    CATransaction.setCompletionBlock { // need to set the completion handler BEFORE setting the animation
      
      CATransaction.begin()
      CATransaction.setAnimationDuration(0.25)
      CATransaction.setCompletionBlock({
        callback()
      })
      
      properties(false)
      CATransaction.commit()
    }
    
    properties(true)
    CATransaction.commit()
  }
  
  //MARK: Animations
  private func setShrinkAnimationProperties(isFirstAnim: Bool){
    if isFirstAnim {
      CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault))
      circleLayer.transform = CATransform3DMakeScale(1.15, 1.15, 1)
      return
    }
    CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn))
    self.circleLayer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
    self.circleLayer.opacity = 0
  }
  
  
  private func setDarkenExpandProperties(isFirstAnim: Bool){
    if isFirstAnim {
      CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn))
      circleLayer.transform = CATransform3DMakeScale(1.15, 1.15, 1)
      return
    }
    CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn))
    circleLayer.opacity = 0
    darkCircleLayer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
  }
  
  private func setLightenExpandProperties(isFirstAnim: Bool){
    if isFirstAnim {
      CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault))
      circleLayer.transform = CATransform3DMakeScale(1.15, 1.15, 1)
      circleLayer.opacity = 1
    }
    CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn))
    circleLayer.transform = CATransform3DIdentity
  }
}

