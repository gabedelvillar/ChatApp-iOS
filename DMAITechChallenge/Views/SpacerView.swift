//
//  SpacerView.swift
//  DMAITechChallenge
//
//  Created by Gabriel Del VIllar on 10/11/19.
//  Copyright © 2019 gdelvillar. All rights reserved.
//

import UIKit

class SpacerView: UIView {
  
  let space: CGFloat
  
  override var intrinsicContentSize: CGSize {
    return .init(width: space, height: space)
  }
  
  init(space: CGFloat){
    self.space = space
    super.init(frame: .zero)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
