//
//  FinePrintCreatable.swift
//  Locked
//
//  Created by Aaron bikis on 1/5/18.
//  Copyright © 2018 Bikis Design. All rights reserved.
//

import UIKit

protocol FinePrintCreatable {}

extension FinePrintCreatable {
  func createFinePrintAttributedString(withStrings body: [String], linkFont: UIFont, textColor: UIColor, linkColor: UIColor, alignment: NSTextAlignment) -> NSMutableAttributedString{
    let paragaph = NSMutableParagraphStyle()
    paragaph.alignment = alignment
    paragaph.lineBreakMode = .byWordWrapping
    paragaph.lineSpacing = 0.5
    
    let intro = NSMutableAttributedString(string: body.first!)
    let introRange = NSMakeRange(0, intro.length)
    intro.addAttribute(NSAttributedStringKey.foregroundColor, value: textColor, range: introRange)
    
    let linkAttributes: [NSAttributedStringKey : Any] = [NSAttributedStringKey.foregroundColor: linkColor,
                                                         NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue]
    
    let termsStr = NSMutableAttributedString(string: body[1])
    let termsRange = NSMakeRange(0, termsStr.length)
    termsStr.addAttributes(linkAttributes, range: termsRange)
    
    let termsAndPrivacy = NSMutableAttributedString()
    
    termsAndPrivacy.append(intro)
    termsAndPrivacy.append(termsStr)
    
    if body.count >= 3 {
      
      let privacyStr = NSMutableAttributedString(string:  body[2])
      let privacyRange = NSMakeRange(0, privacyStr.length)
      privacyStr.addAttributes(linkAttributes, range: privacyRange)
      
      let and = NSMutableAttributedString(string: body[3])
      and.addAttribute(NSAttributedStringKey.foregroundColor, value: textColor, range: NSMakeRange(0, and.length))
      
      let consentStr = NSMutableAttributedString(string: body[4])
      let consentRange = NSMakeRange(0, consentStr.length)
      consentStr.addAttributes(linkAttributes, range: consentRange)
      
      termsAndPrivacy.append(privacyStr)
      termsAndPrivacy.append(and)
      termsAndPrivacy.append(consentStr)
    }
    
    let conditionsRange = NSMakeRange(0, termsAndPrivacy.length)
    
    termsAndPrivacy.addAttributes([NSAttributedStringKey.font: linkFont,
                                   NSAttributedStringKey.paragraphStyle: paragaph], range: conditionsRange)
    
    if body.count == 4 {
      let addtionalStr = NSMutableAttributedString(string: body[5])
      termsAndPrivacy.append(addtionalStr)
    }
    
    return termsAndPrivacy
  }
}
