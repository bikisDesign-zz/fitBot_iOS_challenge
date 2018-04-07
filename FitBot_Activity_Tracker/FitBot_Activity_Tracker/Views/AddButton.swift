//
//  AddButton.swift
//  FitBot_Activity_Tracker
//
//  Created by Aaron bikis on 4/7/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit

final class AddButton: UIButton {
  
  
  override func draw(_ rect: CGRect) {
    print(rect)
    createCircle()
  }
  
  private func createCircle(){
    let center: CGFloat = min( bounds.size.width/2, bounds.size.height/2)
    let lineWidth:CGFloat = 1
    
    //create the path for the circle
    let circlePath = UIBezierPath(
      arcCenter: CGPoint(x:center,y:center),
      radius: CGFloat( center - (lineWidth/2) ),
      startAngle: CGFloat(0),
      endAngle:CGFloat(Double.pi * 2),
      clockwise: true)
    
    // create the shape layer set to the circle's path
    let shapeLayer = CAShapeLayer()
    shapeLayer.path = circlePath.cgPath
    shapeLayer.fillColor = Theme.Colors.fitBotRed.color.cgColor
    shapeLayer.strokeColor = Theme.Colors.fitBotRed.color.cgColor
    shapeLayer.lineWidth = lineWidth
    
    // create an image layer to go over the circle
    let addImageLayer = CALayer()
    addImageLayer.backgroundColor = UIColor.clear.cgColor
    let size = min(bounds.width - 10, bounds.height - 10)
    addImageLayer.bounds = CGRect(x: center, y: center,
                                  width: size, height: size)
    addImageLayer.position = CGPoint(x: center, y: center)
    addImageLayer.contents = #imageLiteral(resourceName: "Icons_Add").cgImage
    
    //add shapes as sublayers
    layer.addSublayer(shapeLayer)
    layer.addSublayer(addImageLayer)
  }
}
