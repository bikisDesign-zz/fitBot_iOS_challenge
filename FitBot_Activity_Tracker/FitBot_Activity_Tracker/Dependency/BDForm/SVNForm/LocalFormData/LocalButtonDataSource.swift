//
//  LocalButtonDataSource.swift
//  Locked
//
//  Created by Aaron bikis on 1/5/18.
//  Copyright © 2018 Bikis Design. All rights reserved.
//

import UIKit

enum LocalButtonDataSource: SVNLargeButtonDataSource {
  case <#pattern#>
  
  var backgroundColor: UIColor {
    switch self {
    case <#pattern#>:
      <#code#>
    default:
      <#code#>
    }
  }
  
  var textColor: UIColor {
    switch self {
    case <#pattern#>:
      <#code#>
    default:
      return UIColor.white
    }
  }
  
  var isRounded: Bool {
    switch self {
    case <#pattern#>:
      <#code#>
    default:
      return false
    }
  }
  
  var shouldDisplayArray: Bool {
    switch self {
    case <#pattern#>:
      <#code#>
    default:
      return false
    }
  }

  var text: String {
    switch self {
    case <#pattern#>:
      <#code#>
    default:
      <#code#>
    }
  }
}

