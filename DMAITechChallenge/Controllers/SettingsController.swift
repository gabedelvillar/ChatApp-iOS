
//
//  BookmarksController.swift
//  DMAITechChallenge
//
//  Created by Gabriel Del VIllar on 10/11/19.
//  Copyright © 2019 gdelvillar. All rights reserved.
//

import UIKit

class SettingsController: UITableViewController {

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
    cell.textLabel?.text = "Settings: \(indexPath.row)"
    return cell
  }

}
