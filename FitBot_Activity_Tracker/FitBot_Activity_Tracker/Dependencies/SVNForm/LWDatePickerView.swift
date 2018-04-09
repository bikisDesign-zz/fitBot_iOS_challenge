//
//  LWDatePickerView.swift
//  Locked
//
//  Created by Aaron bikis on 1/5/18.
//  Copyright © 2018 Bikis Design. All rights reserved.
//

import UIKit

protocol LWDatePickerDelegate: class {
  func datePicker(changedValue value:String)
}

class LWDatePicker: UIDatePicker {
  weak var delegate: LWDatePickerDelegate?
  var type: SVNFormDatePickerDataSource
  var dayOfWeekLabel : UILabel!
  private var theme: SVNFormTheme
  
  init(frame: CGRect, type: SVNFormDatePickerDataSource, theme: SVNFormTheme) {
    self.theme = theme
    self.type = type
    super.init(frame: frame)
    setCalendar()
    setUpDatePicker()
    setDayOfWeekView()
  }
  required init?(coder aDecoder: NSCoder) { fatalError() }
  
  
  private func setCalendar(){
    datePickerMode = type.datePickerMode
    setDate(type.minDate, animated: false)
  }
  
  
  private func setDayOfWeekView(){
    let width = UIWindow().bounds.width
    dayOfWeekLabel = UILabel(frame: CGRect(x: 0, y: frame.height - 25, width: width, height: 25))
    dayOfWeekLabel.backgroundColor = theme.buttonColor
    dayOfWeekLabel.textColor = UIColor.white
    dayOfWeekLabel.textAlignment = .center
    guard let dayOfWeek = getDayOfWeek() else { return }
    dayOfWeekLabel.text = dayOfWeek
    addSubview(dayOfWeekLabel)
  }
  
  
  private func getDayOfWeek() -> String? {
    let cal = Calendar(identifier: .gregorian)
    let dayOfWeek = cal.component(.weekday, from: date)
    switch dayOfWeek {
    case 1:
      return "Sunday"
    case 2:
      return "Monday"
    case 3:
      return "Tuesday"
    case 4:
      return "Wednesday"
    case 5:
      return "Thursday"
    case 6:
      return "Friday"
    case 7:
      return "Saturday"
    default:
      return nil
    }
  }
  
  
  private func setUpDatePicker(){
    addTarget(self, action:#selector(datePickerValueChanged), for: .valueChanged)
    setValue(theme.buttonColor, forKey: "textColor")
  }
  
  
  @objc func datePickerValueChanged(){
    let dateFormater = DateFormatter()
    dateFormater.dateFormat = "MM/dd/yyyy"
    let dateStr = dateFormater.string(from: date)
    delegate?.datePicker(changedValue: dateStr)
    guard let dayOfWeek = getDayOfWeek() else { return }
    dayOfWeekLabel.text = dayOfWeek
  }
}

