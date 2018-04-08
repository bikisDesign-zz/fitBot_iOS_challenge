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
  
  private lazy var circleLayer = CAShapeLayer()
  private lazy var iconImageLayer = CALayer()
  
  private var cachedBounds: CGRect = CGRect.zero
  
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
    let center: CGFloat = min( bounds.width/2, bounds.height/2)
    let lineWidth:CGFloat = 1
    
    //create the path for the circle
    let circlePath = UIBezierPath(
      arcCenter: CGPoint(x:center,y:center),
      radius: CGFloat(center - (lineWidth/2) ),
      startAngle: CGFloat(0),
      endAngle:CGFloat(Double.pi * 2),
      clockwise: true)
    
    // create the shape layer set to the circle's path
    
    circleLayer.path = circlePath.cgPath
    circleLayer.fillColor = Theme.Colors.fitBotRed.color.cgColor
    circleLayer.strokeColor = Theme.Colors.fitBotRed.color.cgColor
    circleLayer.lineWidth = lineWidth
    
    // create an image layer to go over the circle
    iconImageLayer.backgroundColor = UIColor.clear.cgColor
    
    let size = min(circlePath.bounds.width - 15, circlePath.bounds.height - 15)
    
    let circleCenter: CGFloat = min(circlePath.bounds.width / 2, circlePath.bounds.height / 2)
    
    iconImageLayer.bounds = CGRect(x: circleCenter, y: circleCenter,
                                     width: size, height: size)
    setIconImage(for: .add)
    
    //add shapes as sublayers
    circleLayer.addSublayer(iconImageLayer)
    layer.addSublayer(circleLayer)
  }
  
  
  func addTapRecognizer(with target: Any, selector: Selector){
    let tgr = UITapGestureRecognizer(target: target, action: selector)
    addGestureRecognizer(tgr)
  }
  
  
  //AddButton Delegate
  func animateStateChange(for state: ActivityState){
    animateCircleSize(toShrink: true) {
      //      DispatchQueue.main.async {
      //        self.setIconImage(for: state == .add ? .detail : .add)
      //        self.animateCircleSize(toShrink: false, with: {
      //          self.delegate?.transitionAnimationDidFinish()
    }
  }
  
  // animate circle shrink or expand
  private func animateCircleSize(toShrink shouldShrink: Bool, with  callback: @escaping() -> ()){
    CATransaction.begin()
    
    let sizeAnimation = CABasicAnimation(keyPath: "size")
    
    
    CATransaction.setCompletionBlock{ [weak self] in
      self?.animeExample()
    }
    
    someLayer.add(a, forKey: nil)
    CATransaction.commit()
  }
  
  
  private func setIconImage(for state: ActivityState){
    let center = min( bounds.size.width/2, bounds.size.height/2)
    iconImageLayer.position = CGPoint(x: center, y: center)
    iconImageLayer.contentsGravity = kCAGravityResizeAspect
    
    if state == .add {
      iconImageLayer.contents = #imageLiteral(resourceName: "Icons_Add").cgImage
    } else {
      iconImageLayer.contents = #imageLiteral(resourceName: "Icons_Runner").cgImage
    }
  }
}
