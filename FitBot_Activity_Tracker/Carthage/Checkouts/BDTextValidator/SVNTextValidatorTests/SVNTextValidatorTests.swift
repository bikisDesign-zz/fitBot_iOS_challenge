//
//  SVNTextValidatorTests.swift
//  SVNTextValidatorTests
//
//  Created by Aaron Dean Bikis on 7/17/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import XCTest

class SVNTextValidatorTests: XCTestCase {
  
  var validator: Validator!
  var validatableField: UITextField!
  
  override func setUp() {
    super.setUp()
    validator = Validator()
    validatableField = UITextField()
    validatableField.text = "2441223333"
    
    validator.registerField(validatableField, rules: [RoutingNumberRule()])
  }
  
  override func tearDown() {
    
    super.tearDown()
  }
  
  func testExample() {
    validator.validateField(validatableField) { (error) in
      guard error == nil else {
        XCTAssert(true, error!.errorMessage)
        return
      }
    }
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
  }
  
}
