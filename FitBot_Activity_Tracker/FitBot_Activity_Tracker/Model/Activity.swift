//
//  Activity.swift
//  FitBot_Activity_Tracker
//
//  Created by Aaron bikis on 4/10/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import Foundation

typealias Activites = [Activity]

struct Activity {
  var time: String
  var date: String
  var distance: String
  
  init(json: JSON){
    time = json[Strava.Key.durationInSeconds] as? String ?? ""
    date = json[Strava.Key.startDate] as? String ?? ""
    distance = json[Strava.Key.distanceInMeters] as? String ?? ""
  }
}
