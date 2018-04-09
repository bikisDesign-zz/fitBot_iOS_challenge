//
//  SVNFormTextField.swift
//  Tester
//
//  Created by Aaron Dean Bikis on 4/21/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import UIKit

protocol SVNFormTextFieldDelegate: class {
  func forwardingToolbarStateChange(withState state: SVNFormToolbarState, sender: SVNFormTextField)
}

final class SVNFormTextField: UITextField, SVNFormField {
  
  weak var formDelegate: SVNFormTextFieldDelegate!
  
  var validationText: String {
    get {
      return text ?? ""
    }
  }
  
  class var StandardHeight: CGFloat {
    get {
      print(SVNLargeButton.standardHeight - SVNFormPlaceholderLabel.StandardHeight)
      return SVNLargeButton.standardHeight - SVNFormPlaceholderLabel.StandardHeight
    }
  }
  
  
  var isPristine: Bool = true
  
  var type: SVNFormFieldType!
  
  lazy var formToolbar: SVNFormToolBar = SVNFormToolBar(theme: theme)
  
  var pickerView: SVNFormPickerView?
  
  var datePickerView: LWDatePicker?
  
  private var theme: SVNFormTheme
  
  init(theme: SVNFormTheme){
    self.theme = theme
    super.init(frame: CGRect.zero)
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  func setView(forType type: SVNFormFieldType, formDelegate: SVNFormTextFieldDelegate, textFieldDelegate: UITextFieldDelegate? = nil, autoFillText: String){
    isPristine = true
    self.type = type
    self.formDelegate = formDelegate
    delegate = textFieldDelegate
    font = theme.textFieldFont
    textColor = theme.textFieldTextColor
    keyboardType = type.fieldData.keyboardType
    isSecureTextEntry = type.fieldData.isSecureEntry
    autocorrectionType = type.fieldData.hasAutoCorrection
    
    text = autoFillText
    #if SVNFORM_shouldAutofill
      if autoFillText == "" {
        text = type.fieldData.stockData
      }
    #endif
    
    if let pickerData = type.fieldData.hasPickerView {
      pickerView = SVNFormPickerView(frame: CGRect.zero, data: pickerData.data, theme: theme) 
      pickerView?.formPickerDelegate = self
      inputView = pickerView
    }
    
    if let datePickerType = type.fieldData.hasDatePicker {
      datePickerView = LWDatePicker(frame: CGRect.zero, type: datePickerType.data, theme: theme)
      datePickerView?.delegate = self
      inputView = datePickerView
    }
    
    inputAccessoryView = formToolbar
    formToolbar.toolbarDelegate = self
  }
  
  
  
  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return CGRect(x: bounds.origin.x + 5, y: bounds.origin.y,
                  width: bounds.width - 10, height: bounds.height)
  }
  
  
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return CGRect(x: bounds.origin.x + 5, y: bounds.origin.y,
                  width: bounds.width - 10, height: bounds.height)
  }
}

extension SVNFormTextField: SVNFormToolBarDelegate {
  func onStateChange(state: SVNFormToolbarState) {
    formDelegate.forwardingToolbarStateChange(withState: state, sender: self)
  }
}

extension SVNFormTextField: SVNFormPickerViewDelegate {
  func formPicker(didSelectValue value: String) {
    text = value
  }
}

extension SVNFormTextField: LWDatePickerDelegate {
  func datePicker(changedValue value: String) {
    text = value
  }
}
