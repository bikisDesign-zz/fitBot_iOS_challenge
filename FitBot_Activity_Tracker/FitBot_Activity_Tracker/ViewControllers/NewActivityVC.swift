//
//  NewActivityVC.swift
//  FitBot_Activity_Tracker
//
//  Created by Aaron bikis on 4/8/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit
import DeviceKit

protocol NewActivityViewControllerDelegate: class {
  
}

final class NewActivityViewController: CoordinatableViewController {
  weak var delegate: NewActivityViewControllerDelegate?
  
  private lazy var dismissButton = PopButton()
  
  override func loadView() {
    view = NewActivityBackgroundView()
    
    // addButton to view
    let device = Device()
    let dismissButtonSize = CGFloat(device.diagonal * 8)
    
    dismissButton.translatesAutoresizingMaskIntoConstraints = false
    dismissButton.addTapRecognizer(with: self, selector: #selector(dismissNewActivity))
    dismissButton.iconImage = #imageLiteral(resourceName: "Icons_Dismiss")
    view.addSubview(dismissButton)
    
    let margins = view.layoutMarginsGuide
    
    //Set button constraints
    dismissButton.heightAnchor.constraint(equalToConstant: dismissButtonSize).isActive = true
    dismissButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
    dismissButton.widthAnchor.constraint(equalToConstant: dismissButtonSize).isActive = true
    dismissButton.topAnchor.constraint(equalTo: margins.topAnchor, constant: 10).isActive = true
  }
  
  
  @objc func dismissNewActivity(){
    
  }
}
