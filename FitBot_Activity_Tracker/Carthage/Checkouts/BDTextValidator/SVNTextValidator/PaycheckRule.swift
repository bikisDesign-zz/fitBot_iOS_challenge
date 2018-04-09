//
//  PaycheckRule.swift
//  Validator
//
//  Created by Aaron bikis on 10/25/16.
//  Copyright © 2016 Aaron bikis. All rights reserved.
//

import Foundation

/**
 `PaycheckRule` is a subclass of `Rule`. It is used to verify that a field has a date that is after the set minimum date
 */
public class PaycheckRule: Rule, DateConvertable {
  private var message: String
  private var weekendMessage: String
  
  /**
   Initializes a `PaycheckRule` object to verify that field has valid date.
   - parameter message: String of error message if field is todays date.
   - parameter weekendMessage: String of error message if field is on a weekend
   - returns: An initialized object, or nil if an object could not be created for some reason that would not result in an exception.
   */
  public init(message: String = "Must be after today", weekendMessage: String = "Cannot be on a weekend"){
    self.message = message
    self.weekendMessage = weekendMessage
  }
  
  
  /**
   Validates a field.
   - parameter value: String to checked for validation.
   - returns: A boolean value. True if validation is successful; False if validation fails.
   */
  public func validate(_ value: String) -> Bool {
    guard let userDate = convertToDate(value) else { return false }
    let comparision = userDate.compare(Date())
    if comparision == ComparisonResult.orderedAscending {
      return false
    }
    let calendar = Calendar(identifier: .gregorian)
    let components = calendar.component(.weekday, from: userDate)
    if components == 1 || components == 7 {
      self.message = weekendMessage
      return false
    }
    return true
  }
  
  /**
   Displays error message when field has failed validation.
   
   - returns: String of error message.
   */
  public func errorMessage() -> String {
    return message
  }
}
