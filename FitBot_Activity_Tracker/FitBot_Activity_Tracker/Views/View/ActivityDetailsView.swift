//
//  ActivityDetailsView.swift
//  FitBot_Activity_Tracker
//
//  Created by Aaron bikis on 4/11/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit

final class ActivityDetailsView: UIView {
  
  private var title: String
  private var details: String
  
  private lazy var titeLabel: UILabel = {
    let label = UILabel(frame: CGRect.zero)
    label.textColor = Theme.Colors.offBlack.color
    label.text = title
    label.font = Theme.Fonts.smallTitle.font
    label.textAlignment = .right
    addSubview(label)
    return label
  }()
  
  private lazy var detailsLabel: UILabel = {
    let label = UILabel(frame: CGRect.zero)
    label.textColor = Theme.Colors.offBlack.color
    label.text = details
    label.font = Theme.Fonts.smallDetail.font
    label.textAlignment = .left
    addSubview(label)
    return label
  }()
  
  init(title: String, details: String){
    self.title = title
    self.details = details
    super.init(frame: CGRect.zero)
    layer.borderColor = Theme.Colors.offBlack.color.cgColor
    layer.borderWidth = 1
  }
  required init?(coder aDecoder: NSCoder) { fatalError() }
  
  override func layoutSubviews() {
    let xPadding: CGFloat = 20
    titeLabel.frame = CGRect(x: xPadding, y: 0,
                              width: frame.width / 2 - xPadding * 2, height: frame.height)
    
    detailsLabel.frame = CGRect(x: frame.width / 2 , y: 0,
                                width: frame.width / 2 - xPadding * 2, height: frame.height)
  }
}
