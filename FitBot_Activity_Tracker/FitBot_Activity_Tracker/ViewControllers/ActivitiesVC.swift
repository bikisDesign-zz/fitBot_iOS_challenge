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
import SVNBootstraper

protocol ActivitiesViewControllerDelegate: class {
  func addNewActivity(sender: ActivitiesViewController)
}

final class ActivitiesViewController: CoordinatableViewController, AddButtonDelegate, Alertable {
  
  weak var delegate: ActivitiesViewControllerDelegate?
  
  var activitiesDatasource: ActivitiesDataSource?
  
  private lazy var addButton = PopButton()
  
  private lazy var activitiesTableView: UITableView = {
    let tv = UITableView(frame: CGRect.zero)
    tv.delegate = self
    tv.dataSource = activitiesDatasource
    tv.register(ActivityMetaTableViewCell.self)
    view.addSubview(tv)
    return tv
  }()
  
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
  
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if addButton.animationState == .isHidden { // if returning after dismissing the new activity VC this button will need to be refreshed
      addButton.lightenExpand()
    }
  }
  
  
  
  //MARK: AddButton Delegates
  @objc private func addNewActivity(){
    addButton.shrink()
  }
  
  // add button delegate
  func animationFinished() {
    DispatchQueue.main.async {
      self.delegate?.addNewActivity(sender: self)
    }
  }
}
extension ActivitiesViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // navigate to details
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 45
  }
}
