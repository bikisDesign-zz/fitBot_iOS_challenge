//
//  SVNLargeButton.swift
//  Locked
//
//  Created by Aaron bikis on 1/5/18.
//  Copyright © 2018 Bikis Design. All rights reserved.
//

//
//  LWLargeButton.swift
//  LendWallet
//
//  Created by Aaron Dean Bikis on 6/14/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import UIKit

class SVNLargeButton: UIButton {
  
  var dataSource: SVNLargeButtonDataSource {
    didSet {
      setUI(for: dataSource)
    }
  }
  
  class var standardHeight: CGFloat! {
    get {
      switch DeviceSize.current {
      case .isRegularPhone, .isPlus:
        return 55.0
      case .isSmallPhone:
        return 45.0
      default:
        return 55.0
      }
    }
  }
  
  class var standardPadding: CGFloat! {
    get {
      switch DeviceSize.current {
      case .isSmallPhone:
        return 10.0
      default:
        return 20.0
      }
    }
  }
  
  class var bottomPadding: CGFloat {
    get {
      switch DeviceSize.current {
      case .isPlus, .isRegularPhone:
        return 35.0
      case .isSmallPhone:
        return 20.0
      default:
        return 35.0
      }
    }
  }
  
  override var isEnabled: Bool {
    didSet {
      backgroundColor = isEnabled ?
        theme.buttonColor :
        theme.unavailableButtonColor
    }
  }
  
  
  private var borderLayer: CAShapeLayer?
  
  private var theme: SVNFormTheme
  
  
  init(frame: CGRect, theme: SVNFormTheme, dataSource: SVNLargeButtonDataSource) {
    self.theme = theme
    self.dataSource = dataSource
    super.init(frame: frame)
    setUI(for: dataSource)
  }
  required init?(coder aDecoder: NSCoder) { fatalError("dont init with coder") }
  
  
  private func setUI(for dataSource: SVNLargeButtonDataSource){
    backgroundColor = dataSource.backgroundColor
    setTitle(dataSource.text, for: UIControlState())
    setTitleColor(dataSource.textColor, for: UIControlState())
    titleLabel?.font = theme.buttonFont
    titleLabel?.textColor = theme.buttonTextColor
    if dataSource.isRounded { layer.cornerRadius = 10 }
    
    
    if dataSource.shouldDisplayArray {
      let arrowDetailDisclosure = UIImageView(image: UIImage(named: theme.buttonRightChevronImageFilename))
      arrowDetailDisclosure.frame = CGRect(x: frame.width - 15 * 2,
                                           y:(frame.height / 2) - (20 / 2),
                                           width: 15,
                                           height: 20)
      arrowDetailDisclosure.contentMode = .scaleAspectFit
      addSubview(arrowDetailDisclosure)
    }
  }
}

