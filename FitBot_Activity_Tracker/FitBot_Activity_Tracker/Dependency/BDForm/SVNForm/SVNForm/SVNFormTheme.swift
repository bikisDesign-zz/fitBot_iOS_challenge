//
//  SVNFormTheme.swift
//  Locked
//
//  Created by Aaron bikis on 1/5/18.
//  Copyright © 2018 Bikis Design. All rights reserved.
//

import UIKit

protocol SVNFormTheme {
  var placeholderTextColor: UIColor { get set }
  var errorColor: UIColor { get set }
  var placeholderFont: UIFont { get set }
  var textFieldFont: UIFont { get set }
  var textFieldTextColor: UIColor { get set }
  
  var buttonColor: UIColor { get set }
  var buttonTextColor: UIColor { get set }
  var selectedButtonColor: UIColor { get set }
  var unavailableButtonColor: UIColor { get set}
  var buttonRightChevronImageFilename: String { get set }
  var buttonFont: UIFont { get set }
  
  var pickerFont: UIFont { get set }
  
  var termsOverlayBodyFont: UIFont { get set }
  var finePrintFont: UIFont { get set }
  var checkMarkViewBorderColor: UIColor { get set }
}
