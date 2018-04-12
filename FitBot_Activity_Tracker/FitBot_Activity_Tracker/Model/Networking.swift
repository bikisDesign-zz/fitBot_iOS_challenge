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
  
  func requestAcessToken(code: String, callback: @escaping (String?) -> ()){
    
    let oauthParams = [Strava.Key.clientID: Strava.Credential.clientId,
                       Strava.Key.clientSecret: Strava.Credential.secret,
                       Strava.Key.code: code]
    
    request(withParams: oauthParams, url: Strava.oauthURL) { (json) in
      guard let json = json else { print("didn't receive json back from access token req"); return }
      if let token = json[Strava.Key.accessToken] as? String {
        callback(token)
      }
    }
  }
  
  
  func post(activity: Activity, token: String, callback: @escaping (Bool) -> ()) {
    let params: JSON = [Strava.Key.distanceInMeters: activity.distance,
                        Strava.Key.startDate: activity.date,
                        Strava.Key.durationInSeconds: activity.time]
    let url = Strava.activitiesURL.appending(Strava.Key.accessToken.appending("=\(token)"))
    request(withParams: params, url: url) { (json) in
      if let response = json?["response"] as? Int {
        if response == 200 {
          callback(true)
          return
        }
      }
      callback(false)
    }
  }
  
  private func request(withParams params: JSON, url: String, callback: @escaping (JSON?) -> ()){
    var request = URLRequest(url: URL(string: url)!)
    request.httpMethod = "POST" //set http method as POST
    let session = URLSession.shared
    do {
      request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
    } catch let error {
      print(error.localizedDescription)
    }
    
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
      
      guard error == nil, let data = data else {
        callback(nil)
        return // handle this error if there is one
      }
      
      do {
        //create json object from data
        if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? JSON {
          callback(json)
        }
      } catch let error {
        if let response = response as? HTTPURLResponse {
          if response.statusCode == 200 {
            callback(["response": 200])
          }
        }
        print(error.localizedDescription)
      }
    })
    task.resume()
  }
  
  
  
}
