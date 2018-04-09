//
//  LocalFormDataSource.swift
//  Locked
//
//  Created by Aaron bikis on 1/5/18.
//  Copyright © 2018 Bikis Design. All rights reserved.
//

import UIKit

enum LocalFormDataSource: SVNFormViewControllerDataSource {
  case newActivity
  
  var formData: SVNFormData {
    switch self {
    case .newActivity:
      return [LocalFormFieldType.time,
              LocalFormFieldType.distance,
              LocalFormFieldType.date]
    }
  }
  
  var theme: SVNFormTheme {
    switch self {
    default:
      return LocalFormTheme()
    }
  }
  
  var actionSheetData: SVNTermsActionSheetDatasource? {
    return nil
  }
  
  var buttonData: SVNLargeButtonDataSource {
    switch self {
    case .newActivity:
      return LocalButtonDataSource.newActivity
    }
  }
}


