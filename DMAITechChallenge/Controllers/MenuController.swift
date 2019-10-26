//
//  MenuController.swift
//  DMAITechChallenge
//
//  Created by Gabriel Del VIllar on 10/11/19.
//  Copyright © 2019 gdelvillar. All rights reserved.
//

import UIKit

struct MenuItem {
  let icon: UIImage
  let title: String
}

extension MenuController {
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let baseSlidingController = baseSlidingController {
      //baseSlidingController.closeMenu()
      baseSlidingController.didSelectMenuItem(indexPath: indexPath)
    }
  }
}

class MenuController: UITableViewController {
  
  var user: User? = nil
  
 
  var baseSlidingController: BaseSlidingController? = nil
  
  let menuItems = [
    MenuItem(icon: #imageLiteral(resourceName: "profile"), title: "Home"),
    MenuItem(icon: #imageLiteral(resourceName: "lists"), title: "List"),
    MenuItem(icon: #imageLiteral(resourceName: "bookmarks"), title: "Settings"),
    MenuItem(icon: #imageLiteral(resourceName: "moments"), title: "Moments"),
    MenuItem(icon: #imageLiteral(resourceName: "icons8-logout-rounded-left-50"), title: "Logout")
  ]
  
  fileprivate let cellId = "CellID"

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.separatorStyle = .none
    
  }
  
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let purpleView = CustomMenuHeaderView()
    
    purpleView.nameLbl.text = user?.name
    purpleView.userNameLbl.text = user?.email
    purpleView.profileImgView.image = user?.imgView.image
    
    return purpleView
  }
  
  
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return menuItems.count
  }
  
 
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let menuItem = menuItems[indexPath.row]
    let cell = MenuCell(style: .default, reuseIdentifier: cellId)
    cell.iconImgView.image = menuItem.icon
    cell.titleLbl.text = menuItem.title
    return cell
  }

}
