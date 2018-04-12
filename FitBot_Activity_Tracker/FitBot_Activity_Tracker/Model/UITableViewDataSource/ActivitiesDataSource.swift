//
//  ActivitiesDataSource.swift
//  FitBot_Activity_Tracker
//
//  Created by Aaron bikis on 4/10/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit

final class ActivitiesDataSource: NSObject, UITableViewDataSource {
  
  lazy var postedActivites: Activites = Activites()
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: ActivityMetaTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
    cell.set(with: postedActivites[indexPath.row])
    return cell
  }
  
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return postedActivites.count
  }
}

