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
  
  init(json: JSON){
    time = json[Strava.Key.durationInSeconds] as? Int ?? 0
    date = json[Strava.Key.startDate] as? String ?? ""
    distance = json[Strava.Key.distanceInMeters] as? Int ?? 0
  }
  
  // parse form data for API
  init?(date: String, time: String, distance: String){
    self.date = convert(date: date, toStrava: true)
    self.time = convert(time: time, toStrava: true) ?? return nil
    self.distance = convert(distance: distance, toStrava: true) ?? return nil
  }
  
  func getParsedData() -> Activity {
    let date =  convert(distance: "\(self.distance)", toStrava: false)
    let time =  convert(time: "\(self.time)", toStrava: false)
    let distance = convert(date: self.date, toStrava: false)
    return Activity(date: date, time: time, distance: distance)
  }
  
  // helper init to debug ui for tableviewcell
  init(date: String, time: Int, distance: Int) {
    self.date = date
    self.time = time
    self.distance = distance
  }
  
  
  private func convert(date: String, toStrava: Bool) -> String {
    let dateFormater = DateFormatter()
    dateFormater.dateFormat = "MM/dd/yyyy"
    
    let ISO8601formatter = DateFormatter()
    ISO8601formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    ISO8601formatter.timeZone = TimeZone(secondsFromGMT: 0)
    ISO8601formatter.locale = Locale(identifier: "en_US_POSIX")
    
    if toStrava {
      let localDate = dateFormater.date(from: date)
      return ISO8601formatter.string(from: localDate!)
    } else {
      let stravaDate = ISO8601formatter.date(from: date)
      return dateFormater.string(from: stravaDate!)
    }
  }
  
  private mutating func convert(time: String, toStrava: Bool) -> Int? {
    if toStrava {
      let parsedTime = time.components(separatedBy: " ").filter({ $0 != "" && $0 != "Hr" && $0 != "Min"})
      guard let hoursInSec = Int(parsedTime[0]),
        let secs =  Int(parsedTime[1]) else { print("issue parsing time"); return nil }
      return hoursInSec * 60 + secs
      
    } else { // represent time in a better looking way
      guard let seconds = Int(time) else { return nil }
      let mins = (seconds % 3600) / 60
      let hours = seconds / 3600
      self.parsedTime = "\(hours):\(mins)"
      return Int(time)!
    }
  }
  
  private func convert(distance: String, toStrava: Bool) -> Int? {
    guard let doubleDist = Double(distance) else { return nil }
    if toStrava {
      return Int(doubleDist * 0.305) // convert to meters
    }
    return Int(doubleDist * 3.28) // convert to feet
  }
}
