//
//  User.swift
//  DMAITechChallenge
//
//  Created by Gabriel Del VIllar on 10/12/19.
//  Copyright © 2019 gdelvillar. All rights reserved.
//

import UIKit


class User {
  let name: String
  
  let email: String
  let imgView: UIImageView
  
  init(name: String, email: String, imgView: UIImageView) {
    self.name = name
    self.email = email
    self.imgView = imgView
  }
}
