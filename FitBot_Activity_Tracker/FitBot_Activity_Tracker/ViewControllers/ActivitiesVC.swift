//
//  PastActivitiesVC.swift
//  FitBot_Activity_Tracker
//
//  Created by Aaron bikis on 4/7/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit
import DeviceKit

final class ActivitiesViewController: CoordinatableViewController, AddButtonDelegate {
  
  private lazy var addButton: AddButton = AddButton()
  
  var activityState: ActivityState = .overview {
    didSet {
      addButton.animateStateChange(for: activityState)
    }
  }
  
  override func loadView() {
    // set background
    let background = UIView(frame: navigationController!.view.bounds)
    background.backgroundColor = UIColor.white
    view = background
    
    // addButton to view
    addButton.translatesAutoresizingMaskIntoConstraints = false
    addButton.addTapRecognizer(with: self, selector: #selector(changeActivityState))
    addButton.delegate = self
    view.addSubview(addButton)
    
    let margins = view.layoutMarginsGuide
    let device = Device()
    let addButtonSize = CGFloat(device.diagonal * 8)
    
    //Set button constraints
    addButton.heightAnchor.constraint(equalToConstant: addButtonSize).isActive = true
    addButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
    addButton.widthAnchor.constraint(equalToConstant: addButtonSize).isActive = true
    addButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -10).isActive = true
  }

  @objc private func changeActivityState(){
    activityState = activityState == .add ? .detail : .add
  }
  
  func transitionAnimationDidFinish() {
    print("complete animation")
  }
}

