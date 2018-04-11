//
//  Networking.swift
//  FitBot_Activity_Tracker
//
//  Created by Aaron bikis on 4/9/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import Alamofire

typealias JSON = [String: Any?]

private struct StravaAPICredentials {
  static let secret: String = "fe2ba8fc513e93d3ba740a13e4795cd24f14f50b"
  static let token: String = "d3366318b7178759282d4f0e76ce3d5aae4926e4"
  static let clientId: String = "24730"
}

struct StravaAPIKey {
  static let durationInSeconds: String = "elapsed_time"
  static let distanceInMeters: String = "distance"
  static let startDate: String = "start_date_local"
}
