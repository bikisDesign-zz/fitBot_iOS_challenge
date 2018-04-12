//
//  Networking.swift
//  FitBot_Activity_Tracker
//
//  Created by Aaron bikis on 4/9/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import Alamofire
import SafariServices

typealias JSON = [String: Any?]


final class Networking: NSObject {
  
  lazy var strava = Strava()
}
