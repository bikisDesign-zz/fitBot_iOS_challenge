//
//  PastActivitiesVC.swift
//  FitBot_Activity_Tracker
//
//  Created by Aaron bikis on 4/7/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit
import DeviceKit
import SwiftEssentials

protocol ActivitiesViewControllerDelegate: class {
  func presentNewActivityForm()
}

final class ActivitiesViewController: CoordinatableViewController, AddButtonDelegate {
  
  weak var delegate: ActivitiesViewControllerDelegate?
  
  private lazy var addButton: AddButton = AddButton()
  
  var activityState: ActivityState = .overview
  
  private var newActivityVC: NewActivityViewController?
  
  private func addNewActivityVC(shouldAdd: Bool) {
    newActivityVC = NewActivityViewController()
    embed(controller: newActivityVC!, into: view)
    newActivityVC?.view.frame.origin = CGPoint(x: 0, y: view.frame.height)
  }

  
  
  override func loadView() {
    // set background
    let background = UIView()
    background.backgroundColor = UIColor.white
    view = background
    
    // addButton to view
    addButton.translatesAutoresizingMaskIntoConstraints = false
    addButton.addTapRecognizer(with: self, selector: #selector(addNewActivity))
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

  
  @objc private func addNewActivity(){
    
    switch activityState {
    case .overview:
      addNewActivityVC(shouldAdd: true)
      
    case .add:
      break
    case .detail:
      break
    }
    addButton.isUserInteractionEnabled = false
    addButton.shrink()
  }
  
  
  // add button delegate
  func addButtonDidFinishShrinking() {
    switch activityState {
    case .overview:
      DispatchQueue.main.async {
        self.delegate?.presentNewActivityForm()
      }
      
    case .add:
      break
    case .detail:
      break
      
    }
  }
  
  
  func addButtonDidFinishExpanding() {
    addButton.isUserInteractionEnabled = true
  }
}

