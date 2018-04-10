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
  
  private var formIsAnimating = false
  
  private lazy var dismissButton: PopButton = {
    let button = PopButton()
    button.delegate = self
    button.iconImage = #imageLiteral(resourceName: "Icons_Dismiss")
    button.addTapRecognizer(with: self, selector: #selector(dismissNewActivity))
    view.addSubview(button)
    return button
  }()
  
  private lazy var formVC: SVNFormViewController = {
    let form = SVNFormViewController(withData: LocalFormDataSource.newActivity, delegate: self, frame: CGRect.zero)
    form.delegate = self
    embed(controller: form, into: view)
    return form
  }()

  private lazy var formTitle: UILabel = {
    let label = UILabel()
    label.text = Content.Text.formTitle.text
    label.font = Theme.Fonts.title.font
    label.textColor = UIColor.white
    view.addSubview(label)
    return label
  }()
  
  private var formTopLayoutConstraint: NSLayoutConstraint!
  private var formBottomLayoutConstraint: NSLayoutConstraint!
  
  
  override func loadView() {
    view = NewActivityBackgroundView()
    
    // addButton to view
    let device = Device()
    let dismissButtonSize = CGFloat(device.diagonal * 8)
    
    //dont translate autoresizing masks for subviews
    dismissButton.translatesAutoresizingMaskIntoConstraints = false
    formTitle.translatesAutoresizingMaskIntoConstraints = false
    formVC.view.translatesAutoresizingMaskIntoConstraints = false
    
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
    formTitle.topAnchor.constraint(equalTo: dismissButton.bottomAnchor, constant: dismissButtonSize / 2).isActive = true
    
    //formVC constraints
    formVC.view.heightAnchor.constraint(equalToConstant: (SVNFormViewModel.TextFieldCellHeight + SVNFormViewModel.FieldYpadding) * CGFloat(LocalFormDataSource.newActivity.formData.count) + (SVNLargeButton.standardHeight + SVNLargeButton.standardPadding + SVNLargeButton.bottomPadding * 2)).isActive = true
    formVC.view.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
    formVC.view.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
    formTopLayoutConstraint = formVC.view.topAnchor.constraint(equalTo: formTitle.bottomAnchor, constant: 15)
    formTopLayoutConstraint.isActive = true
    formBottomLayoutConstraint = formVC.view.bottomAnchor.constraint(equalTo: margins.bottomAnchor) // dont set this to active
  }

  
  override func viewDidLoad() {
    super.viewDidLoad()
    print(formVC.view.frame)
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
  func keyboardWillShowNeedTopAndBottomLayoutConstraint() -> (NSLayoutConstraint, NSLayoutConstraint) {
    return (formTopLayoutConstraint, formBottomLayoutConstraint)
  }
  
  func formWasValidated(withText text: [String]) {
    
  }
  
  func notifyUserOfFailedValidation() {}
  
  func forwardingOnToolTipTap(withData data: SVNFormTermsOverlayDataSource) {}
  
  func fieldWasValidated(field: SVNFormField) {
    
  }
  
  func scrollViewContentOffset(isZero: Bool) {
    
  }
  
  func forwarding(_ textField: SVNFormTextField, shouldChangeCharecters range: NSRange, replacement string: String) -> Bool {
    return true
  }
}
