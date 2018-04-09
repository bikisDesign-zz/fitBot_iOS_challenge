//
//  SVNTermsActionSheetDatasource.swift
//  Locked
//
//  Created by Aaron bikis on 1/5/18.
//  Copyright © 2018 Bikis Design. All rights reserved.
//

import Foundation

protocol SVNTermsActionSheetDatasource {
  var title: String { get set }
  var termsActionTitle: String { get set }
  var privacyActionTitle: String { get set }
  var electronicActionTitle: String { get set }
  var termsURL: String { get set }
  var privacyURL: String { get set }
  var electronicDisclosureURL: String { get set }
}
