//
//  SVNFormPlaceholderLabel.swift
//  Locked
//
//  Created by Aaron bikis on 1/5/18.
//  Copyright © 2018 Bikis Design. All rights reserved.
//


import UIKit

class SVNFormPlaceholderLabel: UILabel {
  
  var standardText: String?
  
  var theme: SVNFormTheme
  
  class var StandardHeight: CGFloat {
    get {
      switch DeviceSize.current {
      case .isRegularPhone, .isPlus:
        return 20
      case .isSmallPhone:
        return 15
      default:
        return 20
      }
    }
  }
  
  var hasErrorMessage: String? {
    didSet {
      refreshView()
    }
  }
  
  init(theme: SVNFormTheme){
    self.theme = theme
    super.init(frame: CGRect.zero)
    textAlignment = .left
    font = theme.placeholderFont
    textColor = theme.placeholderTextColor
  }
  required init?(coder aDecoder: NSCoder) { fatalError() }
  
  
  func refreshView(){
    textColor = hasErrorMessage != nil ? theme.errorColor : theme.placeholderTextColor
    if hasErrorMessage == "Required" {
      guard let stockText = standardText else { return }
      if stockText.last == "?" {
        text = stockText.substring(to: stockText.index(before: stockText.endIndex)).appending(" is Required")
      } else {
        text = "\(standardText!) is Required"
      }
      return
    }
    text = hasErrorMessage ?? standardText
  }
}
