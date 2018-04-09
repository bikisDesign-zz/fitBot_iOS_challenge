//
//  NewActivityVC.swift
//  FitBot_Activity_Tracker
//
//  Created by Aaron bikis on 4/8/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit
import DeviceKit

protocol NewActivityViewControllerDelegate: class {
  func dismissNewActivityVC()
  func didValidateAllFields(withCredentials credentials: Credentials)
}

final class NewActivityViewController: CoordinatableViewController, AddButtonDelegate {
  weak var delegate: NewActivityViewControllerDelegate?
  
  private lazy var dismissButton = PopButton()
  
  private lazy var formVC: SVNFormViewController = {
    let form = SVNFormViewController(withData: LocalFormDataSource.newActivity, delegate: self, frame: CGRect(x: view.layoutMargins.left, y: formTitle.frame.origin.y + formTitle.frame.size.height + 25, width: view.frame.width - view.layoutMargins.left * 2, height: SVNFormViewModel.TextFieldCellHeight * CGFloat(LocalFormDataSource.newActivity.formData.count) + (SVNLargeButton.standardHeight + SVNLargeButton.standardPadding + SVNLargeButton.bottomPadding * 2)))
  }()

  private lazy var formTitle: UILabel = {
    let label = UILabel()
    label.text = Content.Text.formTitle.text
    label.font = Theme.Fonts.title.font
    label.textColor = UIColor.white
    return label
  }()
  
  
  override func loadView() {
    view = NewActivityBackgroundView()
    
    // addButton to view
    let device = Device()
    let dismissButtonSize = CGFloat(device.diagonal * 8)
    
    dismissButton.translatesAutoresizingMaskIntoConstraints = false
    formTitle.translatesAutoresizingMaskIntoConstraints = false
    dismissButton.addTapRecognizer(with: self, selector: #selector(dismissNewActivity))
    dismissButton.delegate = self
    dismissButton.iconImage = #imageLiteral(resourceName: "Icons_Dismiss")
    
    view.addSubview(dismissButton)
    view.addSubview(formTitle)
    
    let margins = view.layoutMarginsGuide
    
    //Set button constraints
    dismissButton.heightAnchor.constraint(equalToConstant: dismissButtonSize).isActive = true
    dismissButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 25).isActive = true
    dismissButton.widthAnchor.constraint(equalToConstant: dismissButtonSize).isActive = true
    dismissButton.topAnchor.constraint(equalTo: margins.topAnchor, constant: 25).isActive = true
    
    //set title constraints
    formTitle.heightAnchor.constraint(equalToConstant: dismissButtonSize).isActive = true
    formTitle.leadingAnchor.constraint(equalTo: dismissButton.leadingAnchor).isActive = true
    formTitle.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
    formTitle.topAnchor.constraint(equalTo: dismissButton.bottomAnchor, constant: dismissButtonSize).isActive = true
  }
  
  
  @objc func dismissNewActivity(){
      dismissButton.darkenExpand()
  }
  
  
  func animationFinished() {
    DispatchQueue.main.async {
      self.delegate?.dismissNewActivityVC()
    }
  }
}


extension NewActivityViewController: SVNFormViewControllerDelegate {
  func formWasValidated(withText text: [String]) {
    
  }
  
  func notifyUserOfFailedValidation() {
    
  }
  
  func forwardingOnToolTipTap(withData data: SVNFormTermsOverlayDataSource) {
    
  }
  
  func fieldWasValidated(field: SVNFormField) {
    
  }
  
  func scrollViewContentOffset(isZero: Bool) {
    
  }
  
  func forwarding(_ textField: SVNFormTextField, shouldChangeCharecters range: NSRange, replacement string: String) -> Bool {
    return true
  }
  
  func formWillBeginEditing(completion: @escaping (Bool) -> ()) {
    
  }
  
  func formWillFinishEditing() {
    
  }
}
