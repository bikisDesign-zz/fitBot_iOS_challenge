//
//  LocalDatePickerType.swift
//  FitBot_Activity_Tracker
//
//  Created by Aaron bikis on 4/9/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit

// the datasource for date pickers throughout the app
enum LocalDatePickerType: SVNFormDatePickerType {
  case ActivityDate
  case ActivityTime
  
  var data: SVNFormDatePickerDataSource {
    switch self {
    case .ActivityDate:
      return ActivityDatePickerDataSource()
    case .ActivityTime:
      return ActivityTimePickerDataSource()
    }
  }
}


private struct ActivityDatePickerDataSource: SVNFormDatePickerDataSource {} // leave this empty as its just a normal date picker without restrictions on min dates

private struct ActivityTimePickerDataSource: SVNFormDatePickerDataSource {
  var datePickerMode: UIDatePickerMode {
    return UIDatePickerMode.time
  }
}
