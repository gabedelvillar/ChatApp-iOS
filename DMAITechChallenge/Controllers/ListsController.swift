//
//  ListsController.swift
//  DMAITechChallenge
//
//  Created by Gabriel Del VIllar on 10/11/19.
//  Copyright © 2019 gdelvillar. All rights reserved.
//

import UIKit

class ListsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
      
        navigationItem.title = "List"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
      
      let lbl = UILabel()
      lbl.text = "Lists"
      lbl.font = UIFont.boldSystemFont(ofSize: 64)
      lbl.textAlignment = .center
      view.addSubview(lbl)
      lbl.centerInSuperview()
    }
    

  
  

}
