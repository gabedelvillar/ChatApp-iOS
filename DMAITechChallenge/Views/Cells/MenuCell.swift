//
//  MenuCell.swift
//  DMAITechChallenge
//
//  Created by Gabriel Del VIllar on 10/11/19.
//  Copyright © 2019 gdelvillar. All rights reserved.
//

import UIKit

class IconImgView: UIImageView {
  override var intrinsicContentSize: CGSize{
    return .init(width: 44, height: 44)
  }
}

class MenuCell: UITableViewCell {
  
  let iconImgView: IconImgView = {
    let iv = IconImgView()
    iv.contentMode = .scaleAspectFit
    iv.image = #imageLiteral(resourceName: "profile")
    return iv
  }()
  
  let titleLbl: UILabel = {
    let lbl = UILabel()
    lbl.font = UIFont.systemFont(ofSize: 20, weight: .medium)
    
    return lbl
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    let stackView = UIStackView(arrangedSubviews: [
        iconImgView, titleLbl, UIView()
      ])
    
    addSubview(stackView)
    stackView.spacing = 12
    titleLbl.text = "Profile"
    stackView.fillSuperview()
    stackView.isLayoutMarginsRelativeArrangement = true
    stackView.layoutMargins = .init(top: 8, left: 12, bottom: 8, right: 12)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
