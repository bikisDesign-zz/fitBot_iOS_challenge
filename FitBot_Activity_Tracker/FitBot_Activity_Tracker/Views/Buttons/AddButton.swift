//
//  AddButton.swift
//  FitBot_Activity_Tracker
//
//  Created by Aaron bikis on 4/7/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit

protocol AddButtonDelegate: class {
  func transitionAnimationDidFinish()
}

final class AddButton: UIView, CAAnimationDelegate {
  
  private enum AnimationState {
    case isShrinking
    case isExpanding
    case none
  }
  
  private var animationState: AnimationState = .none
  
  weak var delegate: AddButtonDelegate?
  
  private lazy var circleLayer: CAShapeLayer = {
    let cLayer = CAShapeLayer()
    layer.addSublayer(cLayer)
    return cLayer
  }()
  
  private lazy var iconImageLayer: CALayer = {
    let iconLayer = CALayer()
    self.circleLayer.addSublayer(iconLayer)
    return iconLayer
  }()
  
  private func circlePathFactory(isZero: Bool) -> UIBezierPath {
    let center: CGFloat = min( bounds.size.width/2, bounds.size.height/2)
    return UIBezierPath(
      arcCenter: CGPoint(x:center,y:center),
      radius: isZero ? CGFloat(0) : center,
      startAngle: CGFloat(0),
      endAngle:CGFloat(Double.pi * 2),
      clockwise: true)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor.clear
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  
  override func draw(_ rect: CGRect) {
    createCircle()
  }
  
  
  private func createCircle(){
    
    // create the shape layer set to the circle's path
    let circlePath = circlePathFactory(isZero: false)
    circleLayer.path = circlePath.cgPath
    circleLayer.bounds = circlePath.bounds // if this isn't set it won't animate properly
    circleLayer.fillColor = Theme.Colors.fitBotRed.color.cgColor
    
    // create an image layer to go over the circle
    iconImageLayer.backgroundColor = UIColor.clear.cgColor
    
    let size = min(circlePath.bounds.width - 15, circlePath.bounds.height - 15)
    let iconCenter = min(circlePath.bounds.width / 2, circlePath.bounds.height / 2)
    
    iconImageLayer.bounds = CGRect(x: iconCenter, y: iconCenter,
                                     width: size, height: size)
    
    iconImageLayer.position = CGPoint(x: iconCenter, y: iconCenter)
    iconImageLayer.contentsGravity = kCAGravityResizeAspect
    setIconImage(for: .add)
  }
  
  
  func addTapRecognizer(with target: Any, selector: Selector){
    let tgr = UITapGestureRecognizer(target: target, action: selector)
    addGestureRecognizer(tgr)
  }
  
  
  //AddButton Delegate
  func animateStateChange(for state: ActivityState){
    print(state)
    animateCircle(shouldShrink: state == .add) {
      
    }
  }

  // animate circle shrink or expand
  private func animateCircle(shouldShrink: Bool, with callback: @escaping() -> ()){
    
    CATransaction.begin()
    CATransaction.setAnimationDuration(0.25)
    CATransaction.setCompletionBlock { // need to set the completion handler BEFORE setting the animation
      
      CATransaction.begin()
      CATransaction.setAnimationDuration(0.25)
      CATransaction.setCompletionBlock({
        callback()
      })
      
      self.setAnimationProperties(shouldShrink: shouldShrink, isFirstAnim: false)
      CATransaction.commit()
    }

    setAnimationProperties(shouldShrink: shouldShrink, isFirstAnim: true)
    CATransaction.commit()
  }
  
  
  private func setAnimationProperties(shouldShrink: Bool, isFirstAnim: Bool){
    if shouldShrink {
      if isFirstAnim {
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault))
        circleLayer.transform = CATransform3DMakeScale(1.15, 1.15, 1)
        return
      }
      CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn))
      self.circleLayer.transform = CATransform3DMakeScale(0, 0, 1)
      return
    }
    if isFirstAnim {
      CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault))
      circleLayer.transform = CATransform3DMakeScale(1.15, 1.15, 1)
      return
    }
    CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn))
    circleLayer.transform = CATransform3DMakeScale(1, 1, 1)
  }
  
  
  private func setIconImage(for state: ActivityState){
    if state == .add {
      iconImageLayer.contents = #imageLiteral(resourceName: "Icons_Add").cgImage
    } else {
      iconImageLayer.contents = #imageLiteral(resourceName: "Icons_Runner").cgImage
    }
  }
}
