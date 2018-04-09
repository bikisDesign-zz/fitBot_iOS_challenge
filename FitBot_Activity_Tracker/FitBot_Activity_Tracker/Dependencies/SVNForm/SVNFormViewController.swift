//
//  SVNFormViewController.swift
//  Locked
//
//  Created by Aaron bikis on 1/5/18.
//  Copyright © 2018 Bikis Design. All rights reserved.
//

import UIKit
import SVNTextValidator
import SVNBootstraper

/**
 A View Controller containing a tableview set to the bounds of the viewController
 Intended to be set as a child of another View Controller.
 To initlize this VC call init(theme:, dataSource: nibNamed:, bundleNamed:)
 To validate textFields call validator.validate()
 Reference didValidateAllFields([LWFormFieldType: String]) as a callback to a sucessful validation
 Tapping Go on the return key type will attempt to validate the textFields resulting in didValidateAllFields being called if successful
 When resizing this viewController make sure to resize the tableview contained within it.
 */

protocol SVNFormViewControllerDelegate: class {
  /// notifies the receiver that the full form was validated
  /// - Parameter text: A String Array matching the supplied SVNFormViewControllerDataSource in indexing
  func formWasValidated(withText text: [String])
  
  /*
   Called by the form if validation failed. Can override to perform notifications to the user before presenting errors
   Actual field animation handling should be performed by updating the viewModel's style transformation * Not currently supported *
   **/
  func notifyUserOfFailedValidation()
  
  /// Notifies the receiver when a tool tip has been tapped.
  /// Is called on the main thread
  func forwardingOnToolTipTap(withData data: SVNFormTermsOverlayDataSource)
  
  /// Notifies the receiver that a single field was validated
  func fieldWasValidated(field: SVNFormField)
  
  /// Notifies the receiver when the scroll view scrolls in a certain direction.
  /// perform animations here.
  /// Is executed on the main thread.
  func scrollViewContentOffset(isZero: Bool)
  
  /// notifies the receiver that a textField's text changed. Perform all changes in input here.
  /// i.e. zip code length restrictions, hypenation ...ect
  func forwarding(_ textField: SVNFormTextField, shouldChangeCharecters range: NSRange, replacement string: String) -> Bool
  
  /// is called before the form is animated upwards the completion handler must be called in order for the form to animate correctly
  /// the form will animate upwards to y: 0
  /// if you need to hide or animate other UI elements as the form is animated upwards call them here.
  func formWillBeginEditing(completion: @escaping (Bool) -> ())
  
  func formWillFinishEditing()
}


class SVNFormViewController: UIViewController, KeyboardNotifiable {
  
  internal var actionSheetDatasource: SVNTermsActionSheetDatasource?
  
  lazy var scrollView: UIScrollView = {
    let scroll = UIScrollView()
    scroll.delegate = self
    self.view.addSubview(scroll)
    return scroll
  }()
  
  fileprivate var viewModel: SVNFormViewModel
  
  weak var delegate: SVNFormViewControllerDelegate!
  
  fileprivate lazy var formFields = [SVNFormFieldView]()
  
  private lazy var formFieldFrames = [CGRect]()
  
  private lazy var buttonFrame = CGRect()
  
  fileprivate var fieldYpadding: CGFloat = 15
  
  lazy var validationButton: SVNLargeButton = {
    let button = SVNLargeButton(frame: CGRect.zero,
                                theme: viewModel.dataSource.theme,
                                dataSource: viewModel.dataSource.buttonData)
    button.addTarget(self, action: #selector(onValidateButtonTap), for: .touchUpInside)
    self.scrollView.addSubview(button)
    return button
  }()
  
  private var centeredFormFrame: CGRect!
  
  init(withData dataSource: SVNFormViewControllerDataSource, delegate: SVNFormViewControllerDelegate, frame: CGRect){
    viewModel = SVNFormViewModel(dataSource: dataSource)
    super.init(nibName: nil, bundle: nil)
    self.actionSheetDatasource = dataSource.actionSheetData
    centeredFormFrame = frame
    view.frame = centeredFormFrame
    self.delegate = delegate
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  fileprivate var previousStaticScrollViewContentOffSet = CGPoint(x: 0, y: 0)
  
  
  override func viewDidLayoutSubviews() {
    
    scrollView.frame = view.bounds
    
    for index in 0..<formFields.count {
      formFields[index].frame = formFieldFrames[index]
    }
    
    validationButton.frame = buttonFrame
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.setStyleTransformers(success: { (rule) in
      
      if let label = rule.errorLabel as? SVNFormPlaceholderLabel {
        label.hasErrorMessage = nil
        
      } else if let field = rule.field as? SVNFormCheckMarkView {
        field.hasErrorMessage = ""
      }
      
    }) { (error) in
      
      if let label = error.errorLabel as? SVNFormPlaceholderLabel {
        label.hasErrorMessage = error.errorMessage
        
      } else if let field = error.field as? SVNFormCheckMarkView {
        field.hasErrorMessage = error.errorMessage
      }
    }
    
    setForm()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    registerForKeyboardNotifications(with: #selector(keyboardWillShowOrHide(_:)))
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    unregisterForKeyboardNotifications()
  }
  
  func reload(data dataSource: SVNFormViewControllerDataSource, autofillData: [String]? = nil){
    formFieldFrames.removeAll()
    formFields.forEach({ $0.removeFromSuperview() })
    formFields.removeAll()
    
    viewModel.update(dataSource: dataSource, autofillData: autofillData ?? Array(repeating: "", count: dataSource.formData.count))
    setForm()
    viewDidLayoutSubviews()
  }
  
  
  func updateTextField(atIndex index: Int, text: String, type: SVNFieldType){
    DispatchQueue.main.async { // can be called by an API
      switch type {
      case .toggle:
        self.formFields[index].toggleView.select(withTitle: text)
      case .checkMark:
        self.formFields[index].checkMarkView.isChecked = text != ""
      case .textField:
        self.formFields[index].textField.text = text
      }
    }
  }
  
  
  private func setForm(){
    
    viewModel.setDelegates(forTextField: self, forDisclosureButton: self,
                           forSVNTextField: self, forViewModel: self, forFieldView: self)
    
    var accumulatedY = fieldYpadding
    
    for i in 0..<viewModel.numberOfFields {
      
      let field = viewModel.createField(forRow: i)
      
      let height = viewModel.getHeightForCell(atRow: i)
      
      formFieldFrames.append(CGRect(x: SVNLargeButton.standardPadding, y: accumulatedY,
                                    width: view.frame.width - SVNLargeButton.standardPadding * 2, height: height))
      
      accumulatedY += (height + fieldYpadding)
      
      scrollView.addSubview(field)
      
      formFields.append(field)
    }
    
    
    buttonFrame = CGRect(x: SVNLargeButton.standardPadding, y: accumulatedY + SVNLargeButton.standardPadding,
                         width: view.frame.width - SVNLargeButton.standardPadding * 2, height: SVNLargeButton.standardHeight)
    
    accumulatedY += (SVNLargeButton.standardHeight + (SVNLargeButton.standardPadding * 2) + SVNLargeButton.bottomPadding)
    
    scrollView.contentSize = CGSize(width: view.frame.width, height: accumulatedY)
  }
  
  
  //MARK: Actions
  @objc private func onValidateButtonTap(){
    view.endEditing(true)
    viewModel.validateForm()
  }
  
  @objc func keyboardWillShowOrHide(_ notification: NSNotification) {
    guard let keyboardEnd = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect,
      let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double else { return }
    
    let isPresenting = notification.name == NSNotification.Name.UIKeyboardWillShow
    
    if notification.name == NSNotification.Name.UIKeyboardDidHide {
      UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseIn], animations: {
        self.view.frame = self.centeredFormFrame
      }, completion: { (isFinished) in
        if isFinished {
          self.delegate.formWillFinishEditing()
        }
      })
      return
    }
    
    guard var formFrame = centeredFormFrame else { return }
    
    if isPresenting {
      let visibleBottom = keyboardEnd.origin.y
      formFrame.origin.y = SVNLargeButton.bottomPadding
      formFrame.size.height = visibleBottom - formFrame.origin.y
    }
    
    
    self.delegate.formWillBeginEditing(completion: { (isFinished) in
      if isFinished {
        DispatchQueue.main.async {
          UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseIn], animations: {
            self.view.frame = formFrame
          }, completion: nil )
        }
      }
    })
  }
}


extension SVNFormViewController: SVNFormTextFieldDelegate {
  func forwardingToolbarStateChange(withState state: SVNFormToolbarState, sender: SVNFormTextField) {
    switch state {
    case .dismiss:
      sender.resignFirstResponder()
      
    case .next:
      setNextResponder(currentResponder: sender, incrementing: true)
      
    case .previous:
      setNextResponder(currentResponder: sender, incrementing: false)
    }
  }
}

extension SVNFormViewController: SVNFormFieldViewDelegate, TermsActionSheetPresentable {
  
  func onCheckMarkLabelTap(sender: UIView) {
    view.endEditing(true)
    let rect = view.convert(sender.frame, from: sender.superview)
    presentTermsSheetActionAlert(in: rect)
  }
}


extension SVNFormViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    guard let tf = textField as? SVNFormTextField else { fatalError(SVNFormError.notTextFieldSubclass.localizedDescription) }
    return delegate.forwarding(tf, shouldChangeCharecters: range, replacement: string)
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    guard let tf = textField as? SVNFormTextField else { fatalError(SVNFormError.notTextFieldSubclass.localizedDescription) }
    if tf.type.fieldData.hasProtectedInformation {
      tf.text = ""
    }
  }
  
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    guard let tf = textField as? SVNFormTextField else { fatalError(SVNFormError.notTextFieldSubclass.localizedDescription) }
    viewModel.validate(field: tf)
  }
  
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    setNextResponder(currentResponder: textField, incrementing: true)
    return true
  }
  
  
  fileprivate func setNextResponder(currentResponder textField: UITextField, incrementing: Bool) {
    guard var index = formFields.index(of: textField.superview as! SVNFormFieldView) else { return }
    
    index = incrementing ? index + 1 : index - 1
    
    guard index < formFields.count && index >= 0 else {
      textField.resignFirstResponder()
      return
    }
    
    guard formFields.indices.contains(index) else { return }
    
    let nextField = formFields[index]
    
    if nextField.type == .textField {
      nextField.textField.becomeFirstResponder()
      
    } else {
      textField.resignFirstResponder()
    }
  }
}


extension SVNFormViewController: SVNFormDisclosureButtonDelegate {
  func onDisclosureButtonTap(alertViewPresentationData data: SVNFormTermsOverlayDataSource?) {
    view.endEditing(true)
    guard let tooltipData = data else { return }
    delegate.forwardingOnToolTipTap(withData: tooltipData)
  }
}


extension SVNFormViewController: SVNFormViewModelDelegate {
  func formWasValidated() {
    
    delegate.formWasValidated(withText: formFields.map({
      switch $0.type! {
      case .textField:
        return $0.textField.validationText
        
      case .checkMark:
        return $0.checkMarkView.validationText
        
      case .toggle:
        return $0.toggleView.validationText
      }
    }))
  }
  
  
  func formWasInvalid(error: [(Validatable, ValidationError)]) {
    for (index, field) in formFields.enumerated() {
      if let _ = error.filter({ ($0.1.field as? UIView)?.superview == field }).first { // if is errored scroll to it
        scrollView.setContentOffset(CGPoint(x: 0, y: formFields[index].frame.origin.y - fieldYpadding), animated: true)
        return // then end
      }
    }
    delegate.notifyUserOfFailedValidation()
  }
  
  func fieldWasValidated(field: SVNFormField) {
    delegate.fieldWasValidated(field: field)
  }
}


extension SVNFormViewController: UIScrollViewDelegate {
  //MARK: ScrollView Delegate
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    delegate.scrollViewContentOffset(isZero: scrollView.contentOffset == CGPoint.zero)
  }
}

