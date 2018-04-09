//
//  DeviceSize.swift
//  Locked
//
//  Created by Aaron bikis on 1/5/18.
//  Copyright © 2018 Bikis Design. All rights reserved.
//

import DeviceKit

enum Size {
  case isSmallPhone, isRegularPhone, isPlus, isiPad, isProSize
}

class DeviceSize {
  
  class var current: Size {
    get {
      let device = Device()
      if device .isOneOf([.iPhone6Plus, .iPhone6sPlus, .iPhone7Plus, .iPhone8Plus]) || device.isOneOf([.simulator(.iPhone6Plus), .simulator(.iPhone6Plus), .simulator(.iPhone7Plus), .simulator(.iPhone8Plus)]) {
        return Size.isPlus
      }
      if device.isOneOf([.iPhone6, .iPhone6s, .iPhone7, .iPhone8]) || device.isOneOf([.simulator(.iPhone6), .simulator(.iPhone6s), .simulator(.iPhone7), .simulator(.iPhone8)]) {
        return Size.isRegularPhone
      }
      if device.isOneOf(Device.allProDevices) || device.isOneOf([.simulator(.iPadPro9Inch), .simulator(.iPadPro10Inch), .simulator(.iPadPro12Inch), .simulator(.iPadPro12Inch2)]) {
        return Size.isProSize
      }
      if device.isOneOf(Device.allPhones) || device.isOneOf([.simulator(.iPhone4), .simulator(.iPhone4s), .simulator(.iPhone5), .simulator(.iPhone5c), .simulator(.iPhone5s), .simulator(.iPhoneSE)]){
        return Size.isSmallPhone
      }
      return Size.isiPad
    }
  }
}
