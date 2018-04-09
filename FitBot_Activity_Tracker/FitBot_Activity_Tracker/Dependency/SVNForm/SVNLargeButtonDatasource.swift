//
//  SVNLargeButtonDatasource.swift
//  Locked
//
//  Created by Aaron bikis on 1/5/18.
//  Copyright © 2018 Bikis Design. All rights reserved.
//

import UIKit

protocol SVNLargeButtonDataSource {
  var backgroundColor: UIColor { get }
  var textColor: UIColor { get }
  var isRounded: Bool { get }
  var shouldDisplayArray: Bool { get }
  var text: String { get }
}
