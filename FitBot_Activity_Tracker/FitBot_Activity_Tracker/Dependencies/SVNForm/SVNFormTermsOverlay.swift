//
//  SVNFormTermsOverlay.swift
//  Locked
//
//  Created by Aaron bikis on 1/5/18.
//  Copyright © 2018 Bikis Design. All rights reserved.
//

import UIKit

protocol SVNFormTermsOverlayType {
  var data: SVNFormTermsOverlayDataSource { get }
}

protocol SVNFormTermsOverlayDataSource {
  var body: [String] { get }
  var agreeText: String { get }
  var buttonData: SVNLargeButtonDataSource? { get }
  var font: UIFont { get }
  var image: UIImage? { get }
}

extension SVNFormTermsOverlayDataSource {
  var agreeText: String { return "I agree." }
  var image: UIImage? { return nil }
  var buttonData: SVNLargeButtonDataSource? { return nil }
}
