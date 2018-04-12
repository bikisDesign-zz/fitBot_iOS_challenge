//
//  Strava.swift
//  FitBot_Activity_Tracker
//
//  Created by Aaron bikis on 4/11/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import Foundation

struct Strava {
  static let authorizeURL: String = "https://www.strava.com/oauth/authorize?client_id=24730&response_type=code&redirect_uri=https://com.fitbot-activity-tracker&approval_prompt=force"
  
  struct Credential {
    static let secret: String = "fe2ba8fc513e93d3ba740a13e4795cd24f14f50b"
    static let token: String = "d3366318b7178759282d4f0e76ce3d5aae4926e4"
    static let clientId: String = "24730"
  }
  
  
  /**
   OAuth Keys
   */
  struct Key {
    static let durationInSeconds: String = "elapsed_time"
    static let distanceInMeters: String = "distance"
    static let startDate: String = "start_date_local"
    static let accessToken: String = "access_token"
    static let clientID: String = "client_id"
    static let redirectURL: String = "redirect_uri"
    static let scope: String = "scope"
    static let approvalPrompt: String = "approval_prompt"
    static let responseType: String = "response_type"
  }
}
