//
//  NewActivityBackgroundView.swift
//  FitBot_Activity_Tracker
//
//  Created by Aaron bikis on 4/8/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit

final class NewActivityBackgroundView: UIView {
  
  lazy var triangleShape: CAShapeLayer = {
    let shape = CAShapeLayer()
    shape.fillColor = UIColor.white.cgColor
    layer.addSublayer(shape)
    return shape
  }()
  
  private func trianglePathFactory() -> UIBezierPath {
    let trianglePath = UIBezierPath()
    trianglePath.move(to: CGPoint(x: 0, y: bounds.height))
    trianglePath.addLine(to: CGPoint(x: bounds.width, y: bounds.height - bounds.height / 3 ))
    trianglePath.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
    trianglePath.close()
    return trianglePath
  }
  
 
  override func draw(_ rect: CGRect) {
    triangleShape.path = trianglePathFactory().cgPath
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = Theme.Colors.fitBotRed.color
  }
  required init?(coder aDecoder: NSCoder) { fatalError() }
}
