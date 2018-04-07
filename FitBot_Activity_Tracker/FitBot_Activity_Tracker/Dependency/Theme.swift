//
//  Theme.swift
//  FitBot_Activity_Tracker
//
//  Created by Aaron bikis on 4/7/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit
import SVNBootstraper

struct Theme {
  enum Colors {
    case fitBotRed
    case teal
    
    var color: UIColor {
      switch self {
      case .fitBotRed:
        return UIColor(r: 252, g: 57, b:72)
      case .teal:
        return UIColor(r: 38, g: 198, b: 218)
      }
    }
  }
  
  
}
