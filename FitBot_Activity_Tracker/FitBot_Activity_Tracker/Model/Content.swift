//
//  Strings.swift
//  FitBot_Activity_Tracker
//
//  Created by Aaron bikis on 4/9/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import Foundation


struct Content {
  enum Text {
    case formTitle
    
    var text: String {
      switch self {
      case .formTitle:
        return "New Activity"
      }
    }
  }
}
