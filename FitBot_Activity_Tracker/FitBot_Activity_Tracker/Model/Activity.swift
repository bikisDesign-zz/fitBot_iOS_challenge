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
  var parsedTime: String?
  
  init?(json: JSON){
    if let time = json[Strava.Key.durationInSeconds] as? Int,
      let date = json[Strava.Key.startDate] as? String,
      let distance = json[Strava.Key.distanceInMeters] as? Int {
      self.time = time
      self.distance = distance
      self.date = date
    } else {
      return nil
    }
  }
  
  // parse form data for API
  init?(date: String, time: String, distance: String){
    
    let parsedTime = time.components(separatedBy: " ").filter({ $0 != "" && $0 != "Hr" && $0 != "Min"})
    guard let hoursInSec = Int(parsedTime[0]),
      let secs =  Int(parsedTime[1]) else { print("issue parsing time"); return nil }
    self.time = hoursInSec * 60 + secs
    
    
    guard let doubleDist = Double(distance) else { return nil }
    self.distance = Int(doubleDist * 0.305) // convert to meters
    
    self.date = date
    self.date = convert(date: date, toStrava: true)
    
    print(self)
  }
  
  
  // helper init to debug ui for tableviewcell
  init(date: String, time: Int, distance: Int) {
    self.date = date
    self.time = time
    self.distance = distance
  }
  
  func getPrettyTime() -> String {
    let mins = (time % 3600) / 60
    let hours = time / 3600
    return "\(hours):\(mins)"
  }
  
  func getPrettyDistance() -> String {
    return "\(Int(Double(distance) * 3.28))" // convert to feet
  }
  
  
  
  func convert(date: String, toStrava: Bool) -> String {
    let dateFormater = DateFormatter()
    dateFormater.dateFormat = "MM/dd/yyyy"
    let ISO8601formatter = ISO8601DateFormatter()
    
    if toStrava {
      let localDate = dateFormater.date(from: date)
      
      return ISO8601formatter.string(from: localDate!)
    } else {
      let stravaDate = ISO8601formatter.date(from: date)
      return dateFormater.string(from: stravaDate!)
    }
  }
  
  func getDate() -> Date? {
    return ISO8601DateFormatter().date(from: self.date)
  }
}
