
//
//  URLRule.swift
//  Deedz
//
//  Created by Aaron bikis on 2/7/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import Foundation

/**
 `URLRule` is a subclass of Rule that defines how a full name is validated.
 */
public class GofundmeURLRule: Rule {
    /// Error message to be displayed if validation fails.
    private var message: String
    /**
     Initializes a `URLRule` object that is used to verify that text in field is a valid URL
     
     - parameter message: String of error message.
     - returns: An initialized `URLRule` object, or nil if an object could not be created for some reason that would not result in an exception.
     */
    public init(message: String = "Invalid URL") {
        self.message = message
    }
    
    /**
     Used to validate a field.
     
     - parameter value: String to be checked for validation.
     - returns: A boolean value. True if validation is successful; False if validation fails.
     */
    public func validate(_ value: String) -> Bool {
        guard value != "" else { return true }
        var urlString = value
        if !value.lowercased().hasPrefix("http://") {
            urlString = "http://".appending(value)
        }
        
        if let url = URL(string: urlString) {
            guard let host = url.host else { return false }
            if host == "www.gofundme.com" || host == "gofundme.com" {
                return true
            }
        }
        return false
    }
    
    /**
     Used to display error message of a field that has failed validation.
     
     - returns: String of error message.
     */
    public func errorMessage() -> String {
        return message
    }
}
