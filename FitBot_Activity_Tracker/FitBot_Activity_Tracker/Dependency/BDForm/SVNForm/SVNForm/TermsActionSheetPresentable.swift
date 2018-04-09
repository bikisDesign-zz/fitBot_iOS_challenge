//
//  TermsActionSheetPresentable.swift
//  Locked
//
//  Created by Aaron bikis on 1/5/18.
//  Copyright © 2018 Bikis Design. All rights reserved.
//

import UIKit

protocol TermsActionSheetPresentable {
  func presentTermsSheetActionAlert(in rect: CGRect)
  var actionSheetDatasource: SVNTermsActionSheetDatasource? { get set }
}


extension TermsActionSheetPresentable where Self: UIViewController {
  
  func presentTermsSheetActionAlert(in rect: CGRect){
    guard let actionSheetDatasource = self.actionSheetDatasource else {
      fatalError("you need to set the SVNTermsActionSheetDatasource for SVNFormViewController in order to use this feature")
    }
    
    let alertViewController = UIAlertController(title: actionSheetDatasource.title, message: nil, preferredStyle: .actionSheet)
    alertViewController.popoverPresentationController?.sourceView = view
    alertViewController.popoverPresentationController?.sourceRect = rect
    let termsAction = UIAlertAction(title: actionSheetDatasource.termsActionTitle, style: .default) { (_) in
      UIApplication.shared.openURL(URL(string: actionSheetDatasource.termsURL)!)
    }
    
    let privacyAction = UIAlertAction(title: actionSheetDatasource.privacyActionTitle, style: .default) { (_) in
      UIApplication.shared.openURL(URL(string: actionSheetDatasource.privacyURL)!)
    }
    
    let electronicAction = UIAlertAction(title: actionSheetDatasource.electronicActionTitle, style: .default) { (_) in
      UIApplication.shared.openURL(URL(string: actionSheetDatasource.electronicDisclosureURL)!)
    }
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
      self.dismiss(animated: true, completion: nil)
    }
    
    alertViewController.addAction(termsAction)
    alertViewController.addAction(privacyAction)
    alertViewController.addAction(electronicAction)
    alertViewController.addAction(cancelAction)
    present(alertViewController, animated: true, completion: nil)
  }
}
