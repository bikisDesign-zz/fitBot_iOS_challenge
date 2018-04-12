
//
//  StravaAuthViewController.swift
//  FitBot_Activity_Tracker
//
//  Created by Aaron bikis on 4/11/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit
import SVNBootstraper

protocol StravaAuthViewControllerDelegate: class {
  func received(code: String)
  func cacelAuth()
}
final class StravaAuthViewController: CoordinatableViewController {
  
  weak var delegate: StravaAuthViewControllerDelegate?
  
  lazy var authWebView: UIWebView = {
    let wv = UIWebView(frame: view.bounds)
    wv.delegate = self
    return wv
  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(authWebView)
    let req = URLRequest(url: URL(string: Strava.authorizeURL)!)
    authWebView.loadRequest(req)
    
    let barbuttonitem = UIBarButtonItem(image: #imageLiteral(resourceName: "Icons_Dismiss_Dark"), style: .plain, target: self, action: #selector(didTapNavDismiss))
    navigationItem.leftBarButtonItem = barbuttonitem
    barbuttonitem.tintColor = Theme.Colors.offBlack.color
  }
  
  @objc func didTapNavDismiss(){
    delegate?.cacelAuth()
  }
}

extension StravaAuthViewController: UIWebViewDelegate {
  
  func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
    guard let url = request.url,
      let fullQuery = url.query else { return true }
    print("requestURL :", url)
    let queryKV = fullQuery.components(separatedBy: "&")
    queryKV.forEach({
      let kv = $0.components(separatedBy: "=")
      if kv.count > 1 {
        if kv[0] == "code" {
          delegate?.received(code: kv[1])
        }
      }
    })
    return true
  }
  
  
  func webViewDidStartLoad(_ webView: UIWebView) {
    //add activity indicator here
  }
  
  func webViewDidFinishLoad(_ webView: UIWebView) {
    //remove activity indicator here
  }
}
