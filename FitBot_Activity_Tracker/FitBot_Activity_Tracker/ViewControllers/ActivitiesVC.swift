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
  func dismissNewActivityForm()
}

final class ActivitiesViewController: CoordinatableViewController, AddButtonDelegate {
  
  weak var delegate: ActivitiesViewControllerDelegate?
  
  private lazy var addButton = PopButton()
  
  override func loadView() {
    view = UIView()
    view.backgroundColor = UIColor.white
    
    // addButton to view
    let device = Device()
    let addButtonSize = CGFloat(device.diagonal * 8)
    addButton.iconImage = #imageLiteral(resourceName: "Icons_Add")
    addButton.translatesAutoresizingMaskIntoConstraints = false
    addButton.addTapRecognizer(with: self, selector: #selector(addNewActivity))
    addButton.delegate = self
    view.addSubview(addButton)
    
    let margins = view.layoutMarginsGuide
    
    //Set button constraints
    addButton.heightAnchor.constraint(equalToConstant: addButtonSize).isActive = true
    addButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
    addButton.widthAnchor.constraint(equalToConstant: addButtonSize).isActive = true
    addButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -10).isActive = true
  }
  
  
  //MARK: AddButton Delegates
  @objc private func addNewActivity(){
    addButton.shrink()
  }
  
  // add button delegate
  func addButtonDidFinishShrinking() {
    DispatchQueue.main.async {
      self.delegate?.presentNewActivityForm()
    }
  }
}

