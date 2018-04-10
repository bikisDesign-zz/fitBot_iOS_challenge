//
//  LocalFormDataSource.swift
//  Locked
//
//  Created by Aaron bikis on 1/5/18.
//  Copyright © 2018 Bikis Design. All rights reserved.
//

// The data source of all the fields for the form

import UIKit
import SVNTextValidator

enum LocalFormFieldType: SVNFormFieldType {
  case time
  case distance
  case date
  
  
  var fieldData: SVNFormFieldDataSource {
    switch self {
    case .time:
      return TotalTimeField()
    case .distance:
      return DistanceField()
    case .date:
      return DateField()
    }
  }
}



private struct TotalTimeField: SVNFormFieldDataSource {
  var placeholder: String = "Total Time"
  var apiKey: String = "activity_time"
  var validationRule: [Rule]? = [RequiredRule()]
  var hasPickerView: SVNFormPickerType? = LocalPickerType.totalTime
}

private struct DistanceField: SVNFormFieldDataSource {
  var placeholder: String = "Distance In Feet"
  var apiKey: String = "activity_distance"
  var validationRule: [Rule]? = [RequiredRule()]
  var keyboardType: UIKeyboardType = UIKeyboardType.numberPad
}

private struct DateField: SVNFormFieldDataSource {
  var placeholder: String = "Date Of Activity"
  var apiKey: String = "activity_date"
  var validationRule: [Rule]? = [RequiredRule()]
  var hasDatePicker: SVNFormDatePickerType? = LocalDatePickerType.ActivityDate
}
