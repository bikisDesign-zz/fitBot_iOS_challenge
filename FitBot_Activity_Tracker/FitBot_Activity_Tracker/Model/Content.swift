//
//  Strings.swift
//  FitBot_Activity_Tracker
//
//  Created by Aaron bikis on 4/9/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import Foundation
import SVNBootstraper


struct Content {
  enum Text {
    case formTitle
    
    var text: String {
      switch self {
      case .formTitle:
        return "New Activity"
      }
    }
  }
  
  struct AuthorizeStravaAlert: SVNAlert {
    var title: String = "Authorize Strava"
    var message: String = "This app uses Strava to store its data. In order to add an Activity please Authorize this app on Strava"
    var denialTitle: String = "No"
    var confirmationTitle: String = "Yes"
  }
}
