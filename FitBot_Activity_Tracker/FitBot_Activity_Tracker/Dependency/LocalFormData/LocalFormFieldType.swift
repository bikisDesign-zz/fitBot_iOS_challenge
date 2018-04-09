//
//  LocalFormDataSource.swift
//  Locked
//
//  Created by Aaron bikis on 1/5/18.
//  Copyright © 2018 Bikis Design. All rights reserved.
//

import UIKit
import SVNTextValidator

enum LocalFormFieldType: SVNFormFieldType {
  case email
  case <#pattern#>
  
  var fieldData: SVNFormFieldDataSource {
    switch self {
    case .email:
      return EmailField()
    case <#pattern#>:
    }
  }
}



private struct EmailField: SVNFormFieldDataSource {
  var placeholder: String = "Email"
  var apiKey: String = "emailaddress"
  var validationRule: [Rule]? = [RequiredRule(), EmailRule()]
  var keyboardType: UIKeyboardType = UIKeyboardType.emailAddress
  var stockData: String = "foo@bar.com"
}
