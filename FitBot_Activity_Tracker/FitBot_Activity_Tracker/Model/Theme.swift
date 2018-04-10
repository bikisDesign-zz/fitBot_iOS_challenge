//
//  Theme.swift
//  FitBot_Activity_Tracker
//
//  Created by Aaron bikis on 4/7/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit
import SVNBootstraper

/**
 A Model containing the thematic elements of the app, including:
 - Colors
 - Fonts

 */
struct Theme {
  enum Colors {
    case fitBotRed
    case teal
    case unfilledTextField
    
    
    var color: UIColor {
      switch self {
      case .fitBotRed:
        return UIColor(r: 252, g: 57, b:72)
      case .teal:
        return UIColor(r: 38, g: 198, b: 218)
      case .unfilledTextField:
        return UIColor(r: 228, g: 228, b: 228)
      }
    }
  }
  
  enum Fonts {
    case title
    case subtitle
    case body
    case detail
    case placeholder

    var font: UIFont {
      switch self {
      case .title:
        return UIFont(name: ApplicationFonts.robotBold, size: 32)!
      case .subtitle:
        return UIFont(name: ApplicationFonts.robotoMed, size: 30)!
      case .body:
        return UIFont(name: ApplicationFonts.robotoReg, size: 20)!
      case .detail:
        return UIFont(name: ApplicationFonts.robotoLight, size: 18)!
      case .placeholder:
        return UIFont(name: ApplicationFonts.robotoLight, size: 16)!
      }
    }
  }
  
}




private struct ApplicationFonts {
  static let robotoReg: String =  "Roboto-Regular"
  static let robotoLight: String = "Roboto-Light"
  static let robotoMed: String = "Roboto-Medium"
  static let robotBold: String = "Roboto-Bold"
}
