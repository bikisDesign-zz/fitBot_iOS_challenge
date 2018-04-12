//
//  ActivityDetailsVC.swift
//  FitBot_Activity_Tracker
//
//  Created by Aaron bikis on 4/11/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit

final class ActivityDetailsViewController: CoordinatableViewController {
  
  private var activity: Activity
  
  private lazy var timeDetailsView: ActivityDetailsView = {
    let v = ActivityDetailsView(title: LocalFormFieldType.time.fieldData.placeholder, details: "\(activity.time)")
    view.addSubview(v)
    return v
  }()
  
  private lazy var distanceDetailsView: ActivityDetailsView = {
    let v = ActivityDetailsView(title: LocalFormFieldType.distance.fieldData.placeholder, details: "\(activity.distance)")
    view.addSubview(v)
    return v
  }()
  
  init(activity: Activity){
    self.activity = activity
    super.init()
  }
  required init?(coder aDecoder: NSCoder) { fatalError() }
  
  override func loadView() {
    
    view = UIView()
    view.backgroundColor = UIColor.white
    
    title = activity.date
    timeDetailsView.translatesAutoresizingMaskIntoConstraints = false
    distanceDetailsView.translatesAutoresizingMaskIntoConstraints = false
    
    let margins = view.layoutMarginsGuide
    
    timeDetailsView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
    timeDetailsView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
    timeDetailsView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
    timeDetailsView.heightAnchor.constraint(equalToConstant: 65).isActive = true
    
    distanceDetailsView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
    distanceDetailsView.topAnchor.constraint(equalTo: timeDetailsView.bottomAnchor).isActive = true
    distanceDetailsView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
    distanceDetailsView.heightAnchor.constraint(equalToConstant: 65).isActive = true
  }
}
