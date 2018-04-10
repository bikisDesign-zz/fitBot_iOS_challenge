//
//  LocalFormTheme.swift
//  Locked
//
//  Created by Aaron bikis on 1/5/18.
//  Copyright © 2018 Bikis Design. All rights reserved.
//

import UIKit

// alot of these aren't used in this app but for larger more complex forms they are neccessary

struct LocalFormTheme: SVNFormTheme {
  var selectedButtonColor: UIColor = { Theme.Colors.fitBotRed.color }()
  var errorColor: UIColor = { UIColor.white }()
  var buttonColor: UIColor = { Theme.Colors.teal.color }()
  var buttonTextColor: UIColor = { UIColor.white }()
  var textFieldTextColor: UIColor = { UIColor.white}()
  var placeholderTextColor: UIColor = { Theme.Colors.unfilledTextField.color }()
  var unavailableButtonColor: UIColor = { UIColor.gray }()
  var checkMarkViewBorderColor: UIColor = { UIColor.gray }()
  var buttonFont: UIFont = { Theme.Fonts.subtitle.font }()
  var pickerFont: UIFont = { Theme.Fonts.body.font }()
  var placeholderFont: UIFont = { Theme.Fonts.body.font }()
  var finePrintFont: UIFont = { Theme.Fonts.body.font }()
  var textFieldFont: UIFont = { Theme.Fonts.body.font }()
  var termsOverlayBodyFont: UIFont = { Theme.Fonts.body.font }()
  var buttonRightChevronImageFilename: String = { "none" }()
}
