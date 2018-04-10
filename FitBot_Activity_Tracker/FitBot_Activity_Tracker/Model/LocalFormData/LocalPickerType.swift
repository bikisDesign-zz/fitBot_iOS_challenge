//
//  LocalPickerType.swift
//  FitBot_Activity_Tracker
//
//  Created by Aaron bikis on 4/9/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import Foundation


enum LocalPickerType: SVNFormPickerType {
  case totalTime
  
  var data: SVNFormPickerDataSource {
    switch self {
    case .totalTime:
      return TotalTime()
    }
  }
}


private struct TotalTime: SVNFormPickerDataSource {
  var content: [[String]] {
    return [(1...24).map{( String($0) )}, ["Hr"], (1...24).map{( String($0) )}, ["Min"]]
  }
}
