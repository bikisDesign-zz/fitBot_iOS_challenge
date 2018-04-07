//
//  PastActivitiesVC.swift
//  FitBot_Activity_Tracker
//
//  Created by Aaron bikis on 4/7/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit
import DeviceKit

final class PastActivitiesViewController: UIViewController {
  
  private lazy var addButton: AddButton = AddButton()
  
  override func loadView() {
    let background = UIView(frame: navigationController!.view.bounds)
    background.backgroundColor = UIColor.white
    view = background
    
    addButton.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(addButton)
    
    let margins = view.layoutMarginsGuide
    let device = Device()
    let addButtonSize = CGFloat(device.diagonal * 8)
    print(addButtonSize)
    
    addButton.heightAnchor.constraint(equalToConstant: addButtonSize).isActive = true
    addButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
    addButton.widthAnchor.constraint(equalToConstant: addButtonSize).isActive = true
    addButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -20).isActive = true
  }
}

