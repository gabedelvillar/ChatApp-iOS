//
//  ChatNavBar.swift
//  DMAITechChallenge
//
//  Created by Gabriel Del VIllar on 10/11/19.
//  Copyright © 2019 gdelvillar. All rights reserved.
//

import LBTATools

class ChatNavBar: UIView {
  
  
  let nameLabel = UILabel(text: "CHAT", font: .systemFont(ofSize: 16))
  
let menuBtn = UIButton(image: #imageLiteral(resourceName: "icons8-menu-24"), tintColor: #colorLiteral(red: 0.9792197347, green: 0.2754820287, blue: 0.3579338193, alpha: 1))
//  let flagButton = UIButton(image: #imageLiteral(resourceName: "flag"), tintColor: #colorLiteral(red: 0.9792197347, green: 0.2754820287, blue: 0.3579338193, alpha: 1))
  
  
  override init(frame: CGRect) {
    
    super.init(frame: frame)
    
    
    nameLabel.text = "CHAT"
   
    
  
    backgroundColor = .white
    
    setupShadow(opacity: 0.2, radius: 8, offset: .init(width: 0, height: 10), color: .init(white: 0, alpha: 0.3))
    
    //        userProfileImageView.constrainWidth(44)
    //        userProfileImageView.constrainHeight(44)
    //        userProfileImageView.clipsToBounds = true
    //        userProfileImageView.layer.cornerRadius = 44 / 2
    
    let middleStack = hstack(
      stack(
        nameLabel,
        spacing: 8,
        alignment: .center),
      alignment: .center
    )
    
   
    
    hstack(
      menuBtn,
           middleStack).withMargins(.init(top: 0, left: 16, bottom: 0, right: 16))
           //flagButton).withMargins(.init(top: 0, left: 16, bottom: 0, right: 16))
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
}
