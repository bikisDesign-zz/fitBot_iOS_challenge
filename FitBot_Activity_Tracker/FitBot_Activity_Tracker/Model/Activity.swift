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
  var time: Int
  var date: String
  var distance: Int
  
  init(json: JSON){
    time = json[Strava.Key.durationInSeconds] as? Int ?? 0
    date = json[Strava.Key.startDate] as? String ?? ""
    distance = json[Strava.Key.distanceInMeters] as? Int ?? 0
  }
  
  init(date: String, time: String, distance: String){
    
    let dateFormater = DateFormatter()
    dateFormater.dateFormat = "MM/dd/yyyy"
    let postedDate = dateFormater.date(from: date)
  
    let ISO8601formatter = DateFormatter()
    ISO8601formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    ISO8601formatter.timeZone = TimeZone(secondsFromGMT: 0)
    ISO8601formatter.locale = Locale(identifier: "en_US_POSIX")
    self.date = ISO8601formatter.string(from: postedDate!)
    
    self.distance = Int(Double(distance)! * 0.305) // convert to meters
    
    self.time = Int(time)!
  }
}
