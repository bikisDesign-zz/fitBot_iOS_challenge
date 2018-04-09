//
//  SVNFormToolbar.swift
//  Locked
//
//  Created by Aaron bikis on 1/5/18.
//  Copyright © 2018 Bikis Design. All rights reserved.
//

import Foundation
//
//  LWToolBar.swift
//  LendWallet
//
//  Created by Aaron Dean Bikis on 7/17/17.
//  Copyright © 2017 7apps. All rights reserved.
//
import UIKit

protocol SVNFormToolBarDelegate : class {
  func onStateChange(state: SVNFormToolbarState)
}

enum SVNFormToolbarState {
  case dismiss, next, previous
}


class SVNFormToolBar: UIToolbar {
  
  weak var toolbarDelegate: SVNFormToolBarDelegate?
  
  private var theme: SVNFormTheme
  
  init(theme: SVNFormTheme){
    self.theme = theme
    super.init(frame: CGRect.zero)
    barStyle = UIBarStyle.default
    isTranslucent = true
    tintColor = theme.buttonColor
    sizeToFit()
    addButtons()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  
  func addButtons(){
    let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(toolBarFinished))
    let firstFlexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let upButton = UIBarButtonItem(image: UIImage(named: "up"), landscapeImagePhone: .none, style:.plain, target: self, action: #selector(previousField))
    let downButton = UIBarButtonItem(image: UIImage(named: "down"), landscapeImagePhone: .none, style: .plain, target: self, action: #selector(nextField))
    setItems([doneButton, firstFlexibleSpace, upButton, downButton], animated: true)
    isUserInteractionEnabled = true
  }
  
  
  @objc func previousField(){
    toolbarDelegate?.onStateChange(state: .previous)
  }
  
  
  @objc func nextField(){
    toolbarDelegate?.onStateChange(state: .next)
  }
  
  
  @objc func toolBarFinished(){
    toolbarDelegate?.onStateChange(state: .dismiss)
  }
}
