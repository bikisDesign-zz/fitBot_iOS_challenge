//
//  LocalButtonDataSource.swift
//  Locked
//
//  Created by Aaron bikis on 1/5/18.
//  Copyright © 2018 Bikis Design. All rights reserved.
//

import UIKit

//The datasource for the button at the bottom of the form
enum LocalButtonDataSource: SVNLargeButtonDataSource {
  case newActivity
  
  var backgroundColor: UIColor {
    switch self {
    case .newActivity:
      return Theme.Colors.teal.color
    }
  }
  
  var textColor: UIColor {
    switch self {
    default:
      return UIColor.white
    }
  }
  
  var isRounded: Bool {
    switch self {
    default:
      return false
    }
  }
  
  var shouldDisplayArray: Bool {
    switch self {
    default:
      return false
    }
  }

  var text: String {
    switch self {
    case .newActivity:
      return "SAVE"
    }
  }
}

