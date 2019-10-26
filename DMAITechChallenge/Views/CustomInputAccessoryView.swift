//
//  CustomAccessoryView.swift
//  DMAITechChallenge
//
//  Created by Gabriel Del VIllar on 10/12/19.
//  Copyright © 2019 gdelvillar. All rights reserved.
//

import LBTATools

class CustomInputAcessoryView: UIView{
  
  let textView = UITextView()
  let sendBtn = UIButton(title: "SEND", titleColor: .black, font: .boldSystemFont(ofSize: 14), backgroundColor: .clear, target: nil, action: nil)
  
  let placeholderLbl = UILabel(text: "Enter Message", font: .systemFont(ofSize: 16), textColor: .lightGray)
  
  override var intrinsicContentSize: CGSize{
    return .zero
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .white
    setupShadow(opacity: 0.1, radius: 8, offset: .init(width: 0, height: -8), color: .lightGray)
    
    autoresizingMask = .flexibleHeight
    
    
    
    textView.isScrollEnabled = false
    
    textView.font = .systemFont(ofSize: 16)
    
    NotificationCenter.default.addObserver(self, selector: #selector(handleTextChange), name: UITextView.textDidChangeNotification, object: nil)
    
    hstack(textView, sendBtn.withSize(.init(width: 60, height: 60)), alignment: .center).withMargins(.init(top: 0, left: 16, bottom: 0, right: 16))
    
    
    
    addSubview(placeholderLbl)
    
    placeholderLbl.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: sendBtn.leadingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 16))
    
    placeholderLbl.centerYAnchor.constraint(equalTo: sendBtn.centerYAnchor).isActive = true
    
  }
  
  @objc fileprivate func handleTextChange(){
    placeholderLbl.isHidden = textView.text.count != 0
  }
  
  
  
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
  
