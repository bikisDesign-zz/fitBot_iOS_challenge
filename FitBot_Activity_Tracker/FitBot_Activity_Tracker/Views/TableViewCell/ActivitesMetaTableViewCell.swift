//
//  ActivitesMetaTableViewCell.swift
//  FitBot_Activity_Tracker
//
//  Created by Aaron bikis on 4/10/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit
import SwiftEssentials

final class ActivitesMetaTableViewCell: UITableViewCell, ReusableView {
  private lazy var dateLabel: UILabel = self.labelFactory(isDate: true)
  
  private lazy var distanceLabel: UILabel = self.labelFactory(isDate: false)
  
  private lazy var iconImageView: UIImageView = {
    let iv = UIImageView(image: #imageLiteral(resourceName: "Icons_Runner"))
    iv.contentMode = .scaleAspectFit
    return iv
  }()
  
  private func labelFactory(isDate: Bool) -> UILabel {
    let label = UILabel()
    if isDate {
      label.font = Theme.Fonts.placeholder.font
    } else {
      label.textColor = Theme.Colors.teal.color
      label.font = Theme.Fonts.subtitle.font
    }
    self.addSubview(label)
    return label
  }
  
  override func layoutSubviews() {
    let iconPadding: CGFloat = 10
    let yPaddding: CGFloat = 5
    
    iconImageView.frame = CGRect(x: 0, y: 0,
                                 width: 25, height: frame.height)
    
    let iconImageSizeNPadding = iconImageView.frame.origin.x + iconImageView.frame.width + yPaddding
    
    dateLabel.frame = CGRect(x: iconImageView.frame.origin.x + iconPadding, y: yPaddding,
                              width: (frame.width - yPaddding) - iconImageSizeNPadding, height: frame.height / 3 - 10) // padding distance is 5
    
    let distancelabelEnd = dateLabel.frame.origin.y + dateLabel.frame.size.height + yPaddding
    distanceLabel.frame = CGRect(x: iconImageView.frame.origin.x + iconPadding, y: distancelabelEnd,
                                 width: (frame.width - yPaddding) - iconImageSizeNPadding, height: (frame.height - yPaddding) - (distancelabelEnd + yPaddding))
    
  }
  
  
  func set(date: String, distance: String){
    dateLabel.text = date
    distanceLabel.text = distance
  }
}
