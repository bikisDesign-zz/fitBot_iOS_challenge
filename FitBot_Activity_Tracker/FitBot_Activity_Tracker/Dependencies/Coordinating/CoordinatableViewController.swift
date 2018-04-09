//
//  CoordinatableViewController.swift
//  FitBot_Activity_Tracker
//
//  Created by Aaron bikis on 4/7/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit

open class CoordinatableViewController: UIViewController {
  
  public init(){
    super.init(nibName: nil, bundle: nil)
  }
  public required init?(coder aDecoder: NSCoder) {
    fatalError("init:coder is not supported by Viewcontrollers presented by Coordinators")
  }
  
  deinit {
    #if DEBUG_DEV || PROD_DEV
    print("\(self) deinit")
    #endif
  }
}
