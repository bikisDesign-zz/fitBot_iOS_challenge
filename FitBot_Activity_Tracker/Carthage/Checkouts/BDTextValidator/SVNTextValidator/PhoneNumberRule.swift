//
//  PhoneValidation.swift
//
//  Created by Jeff Potter on 11/11/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//

import Foundation

/**
 `PhoneNumberRule` is a subclass of Rule that defines how a phone number is validated.
 */
public class PhoneNumberRule: RegexRule {
  
  /// Phone number regular express string to be used in validation.
  static let regex = "^\\d{3}-\\d{3}-\\d{4}$"
  
  var isOptional: Bool = false
  
  /**
   Initializes a `PhoneNumberRule` object. Used to validate that a field has a valid phone number.
   
   - parameter message: Error message that is displayed if validation fails.
   - returns: An initialized `PasswordRule` object, or nil if an object could not be created for some reason that would not result in an exception.
   */
  public convenience init(message : String = "Invalid Phone Number", isOptional: Bool) {
    self.init(regex: PhoneNumberRule.regex, message: message)
    self.isOptional = isOptional
  }
  
  public override func validate(_ value: String) -> Bool {
    if value == "" && isOptional {
      return true
    }
    return super.validate(value)
  }
}
