//
//  SVNFormPickerView.swift
//  Locked
//
//  Created by Aaron bikis on 1/5/18.
//  Copyright © 2018 Bikis Design. All rights reserved.
//

import UIKit
protocol SVNFormPickerViewDelegate: class {
  func formPicker(didSelectValue value:String)
}

class SVNFormPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource, UIGestureRecognizerDelegate {
  var data: SVNFormPickerDataSource
  weak var formPickerDelegate: SVNFormPickerViewDelegate?
  private var theme: SVNFormTheme
  
  init(frame: CGRect, data: SVNFormPickerDataSource, theme: SVNFormTheme) {
    self.theme = theme
    self.data = data
    super.init(frame: frame)
    setUpPicker()
  }
  
  required init?(coder aDecoder: NSCoder) { fatalError() }
  
  
  private func setUpPicker() {
    delegate = self
    dataSource = self
    let tgr = UITapGestureRecognizer(target: self, action: #selector(pickerTapped))
    addGestureRecognizer(tgr)
    tgr.delegate = self
  }
  
//  func setMaxContent(toMax max: String){
//    if let maxIndex = data.content.index(of: max) {
//      data.content.removeSubrange(0..<maxIndex)
//      self.reloadAllComponents()
//    }
//  }
  
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return data.content.count
  }
  
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    formPickerDelegate?.formPicker(didSelectValue: data.content[component][row])
  }
  
  func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
    return frame.width / CGFloat(data.content.count)
  }
  
  func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    var pickerLabel = view as? UILabel
    if pickerLabel == nil {
      pickerLabel = UILabel()
    }
    let frame = CGRect(x: pickerLabel!.frame.origin.x,
                       y: pickerLabel!.frame.origin.y,
                       width: pickerLabel!.frame.width, height: pickerLabel!.frame.height)
    pickerLabel?.frame = frame
    pickerLabel?.font = theme.pickerFont
    pickerLabel?.adjustsFontSizeToFitWidth = true
    pickerLabel?.textAlignment = NSTextAlignment.center
    pickerLabel?.text = data.content[component][row]
    return pickerLabel!
  }
  
  func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
    return 65
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return data.content[component].count
  }
  
  @objc func pickerTapped(_ sender: UITapGestureRecognizer){
//    let rowHeight = self.rowSize(forComponent: 0).height
//    let selectedRowFrame = self.bounds.insetBy(dx: 0.0, dy: (self.frame.height - rowHeight) / 2.0)
//    let userTappedOnSelectedRow = selectedRowFrame.contains(sender.location(in: self))
//    if userTappedOnSelectedRow {
//      let value = data.content[selectedRow(inComponent: 0)]
////      formPickerDelegate?.formPicker(didSelectValue: value) // lets just not implemnt this just now
//    }
  }
}

