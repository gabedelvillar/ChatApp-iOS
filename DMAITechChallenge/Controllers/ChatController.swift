//
//  ChatController.swift
//  DMAITechChallenge
//
//  Created by Gabriel Del VIllar on 10/11/19.
//  Copyright © 2019 gdelvillar. All rights reserved.
//

import LBTATools


  
class ChatController: LBTAListController<MessageCell, Message>, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate {
  
  var baseSlidingController: BaseSlidingController? = nil
  
  let customNavBar = ChatNavBar()
  fileprivate let navBarHeight: CGFloat = 120
  
  
  // input acessory view
  

  lazy var customInputView: CustomInputAcessoryView = {
   
    let civ = CustomInputAcessoryView(frame: .init(x: 0, y: 0, width: view.frame.width, height: 50))
    civ.sendBtn.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
    return civ
  }()
  
  @objc fileprivate func handleSend() {
    items.append(Message(text: customInputView.textView.text, isFromCurrentLoggedUser: true))
    customInputView.textView.text = nil
    customInputView.placeholderLbl.isHidden = false
    collectionView.reloadData()
    
  }
  
  override var inputAccessoryView: UIView? {
    get {
     
      return customInputView
    }
  }
  
  override var canBecomeFirstResponder: Bool {
    return true
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.keyboardDismissMode = .interactive
    
    items = [
      .init(text: "Hello from the chat controller", isFromCurrentLoggedUser: true),
      .init(text: "Hello from the chat controller", isFromCurrentLoggedUser: false),
      .init(text: "Hello from the chat controller", isFromCurrentLoggedUser: true),
      .init(text: "This is a slightly longer text to verify thaht the code for auto sizeing cells for messages actually works!", isFromCurrentLoggedUser: false)
      
    ]
    
    setupCustomNavBar()
  
    
  }
  
  fileprivate func setupCustomNavBar() {
    customNavBar.menuBtn.addTarget(self, action: #selector(openMenu), for: .touchUpInside)
    
    view.addSubview(customNavBar)
    customNavBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: navBarHeight))
    
    collectionView.contentInset.top = navBarHeight
    collectionView.scrollIndicatorInsets.top = navBarHeight
    
    let statusBarCover = UIView(backgroundColor: .white)
    
    view.addSubview(statusBarCover)
    statusBarCover.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, trailing: view.trailingAnchor)
  }
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    // estimated size
    let estimatedSizeCell = MessageCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
    
    estimatedSizeCell.item = self.items[indexPath.item]
    
    
    
    estimatedSizeCell.layoutIfNeeded()
    
    let estimatedSize = estimatedSizeCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
    
    return .init(width: view.frame.width, height: estimatedSize.height)
  }
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: 16, left: 0, bottom: 16, right: 0)
  }
  
  
  // Mark :- fileprivate
  
  @objc fileprivate func openMenu() {
    if let baseSlidingController = baseSlidingController {
      baseSlidingController.openMenu()
    }
  }
  
  @objc fileprivate func hideMenu() {
    
    if let baseSlidingController = baseSlidingController {
      baseSlidingController.closeMenu()
    }
    
    
  }
  
}
