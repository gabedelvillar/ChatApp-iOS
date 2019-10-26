//
//  CustomMenuHeaderView.swift
//  DMAITechChallenge
//
//  Created by Gabriel Del VIllar on 10/11/19.
//  Copyright © 2019 gdelvillar. All rights reserved.
//

import UIKit

class CustomMenuHeaderView: UIView {
  
  
  let nameLbl = UILabel()
  let userNameLbl = UILabel()
  let statsLbl = UILabel()
  var profileImgView = ProfileImageView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .white
    
    setupComponentProps()
    
    setupStackView()
  }
  
  fileprivate func setupStackView() {
    let stackView = UIStackView(arrangedSubviews: [
      UIStackView(arrangedSubviews: [profileImgView, UIView()]),
      nameLbl,
      userNameLbl,
      SpacerView(space: 16),
      statsLbl
      ])
    
    stackView.axis = .vertical
    stackView.spacing = 4
    
    
    addSubview(stackView)
    stackView.fillSuperview()
    
    stackView.isLayoutMarginsRelativeArrangement = true
    stackView.layoutMargins = .init(top: 24, left: 24, bottom: 24, right: 24)
  }
  
  fileprivate func setupComponentProps() {
    nameLbl.text = "Gabriel Del Villar"
    nameLbl.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
    userNameLbl.text = "@codingdevbox"
    statsLbl.text = "42 Following 709 Followers"
    profileImgView.image = #imageLiteral(resourceName: "lady5c")
    profileImgView.contentMode = .scaleAspectFit
    profileImgView.layer.cornerRadius = 48/2
    profileImgView.clipsToBounds = true
    
    setupStatsAttributedText()
  }
  
  fileprivate func setupStatsAttributedText() {
    statsLbl.font = UIFont.systemFont(ofSize: 14)
    let attributedText = NSMutableAttributedString(string: "42 ", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium)])
    attributedText.append(NSAttributedString(string: "Following  ", attributes: [.foregroundColor: UIColor.black]))
    attributedText.append(NSAttributedString(string: "7091 ", attributes: [.font: UIFont.systemFont(ofSize: 17, weight: .medium)]))
    attributedText.append(NSAttributedString(string: "Followers", attributes: [.foregroundColor: UIColor.black]))
    
    statsLbl.attributedText = attributedText
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
