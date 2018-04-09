//
//  USStateRule.swift
//  Deedz
//
//  Created by Aaron bikis on 11/29/16.
//  Copyright © 2016 7apps. All rights reserved.
//

import Foundation

/**
 `USStateRule` is a subclass of Rule that defines how a full name is validated.
 */
public class USStateRule : Rule {
    /// Error message to be displayed if validation fails.
    private var message : String
    
    let usStates: [String] = ["Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "District of Columbia", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming", "IN", "PA", "UT", "AK", "ID", "NE", "NV", "CT", "CO", "SD", "CA", "NY", "MA", "NH", "ME", "VA", "KS", "AR", "IA", "MT", "AL", "MD", "AZ", "DE", "ND", "OK", "MO", "IL", "MS", "VT", "SC", "KY", "RI", "WY", "NM", "MN", "OH", "TX", "WA", "MI", "NC", "VI", "LA", "WI", "GA", "WV", "HI", "OR", "TN", "FL", "NJ"]

    /**
     Initializes a `USStateRule` object that is used to verify that text in field is a valid US State.
     
     - parameter message: String of error message.
     - returns: An initialized `USStateRule` object, or nil if an object could not be created for some reason that would not result in an exception.
     */
    public init(message : String = "Invalid State"){
        self.message = message
    }
    
    /**
     Used to validate a field.
     
     - parameter value: String to checked for validation.
     - returns: A boolean value. True if validation is successful; False if validation fails.
     */
    public func validate(_ value: String) -> Bool {
        return usStates.map{ $0.lowercased() }.contains(value.lowercased())
    }
    
    /**
     Used to display error message of a field that has failed validation.
     
     - returns: String of error message.
     */
    public func errorMessage() -> String {
        return message
    }
}
