//
//  SVNToggleType.swift
//  LendWallet
//
//  Created by Aaron Dean Bikis on 6/22/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import UIKit

protocol SVNToggleType {
  var data: SVNToggleDataSource { get }
}

protocol SVNToggleDataSource {
  var titles: (String, String) { get }
  
  var font: UIFont { get }
  
  var selectedColor: UIColor { get }
  
  var unselectedColor: UIColor { get }
}
