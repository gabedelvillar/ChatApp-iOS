//
//  BaseSlidingController.swift
//  DMAITechChallenge
//
//  Created by Gabriel Del VIllar on 10/11/19.
//  Copyright © 2019 gdelvillar. All rights reserved.
//

import UIKit

class RightContainerView: UIView {}
class MenuContainerView: UIView {}
class DarkCoverView: UIView {}


class BaseSlidingController: UIViewController {
  
  let user: User
  
  init(user: User) {
   
    self.user = user
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  let redView: RightContainerView = {
    let v = RightContainerView()
    v.translatesAutoresizingMaskIntoConstraints = false
    return v
  }()
  
  
  let blueView: MenuContainerView = {
    let v = MenuContainerView()
    v.backgroundColor = .blue
    v.translatesAutoresizingMaskIntoConstraints = false
    return v
  }()
  
  
  let darkCoverView: DarkCoverView = {
    let v = DarkCoverView()
    v.backgroundColor = UIColor(white: 0, alpha: 0.7)
    v.alpha = 0
    v.translatesAutoresizingMaskIntoConstraints = false
    return v
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
    view.addGestureRecognizer(panGesture)
    
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss))
    
    darkCoverView.addGestureRecognizer(tapGesture)
  }
  
  @objc fileprivate func handleTapDismiss() {
    closeMenu()
  }
  
  @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
    let translation = gesture.translation(in: view)
    var x = translation.x
    
    x = isMenuOpened ? x + menuWidth : x
    
    x = min(menuWidth, x)
    x = max(0,x)
    
    
    
    redViewLeadingConstraint.constant = x
    redViewTrailingConstraint.constant = x
    darkCoverView.alpha = x / menuWidth
    
    if gesture.state == .ended {
      handleEnded(gesture: gesture)
    }
    
  }
  
  fileprivate func handleEnded(gesture: UIPanGestureRecognizer){
     let translation = gesture.translation(in: view)
    let velocity = gesture.velocity(in: view)
    
    if isMenuOpened {
      if abs(velocity.x) > velocityThreshold {
        closeMenu()
        return
      }
      if abs(translation.x) < menuWidth / 2 {
        openMenu()
      } else {
        closeMenu()
      }
    } else {
      if abs(velocity.x) > velocityThreshold {
        openMenu()
        return
      }
      
      if translation.x < menuWidth / 2 {
        closeMenu()
      } else {
        openMenu()
      }
    }
  }
  
   func openMenu() {
    isMenuOpened = true
    redViewLeadingConstraint.constant = menuWidth
    redViewTrailingConstraint.constant = menuWidth
    performAnimations()
  }
  
   func closeMenu() {
    redViewLeadingConstraint.constant = 0
    redViewTrailingConstraint.constant = 0
    isMenuOpened = false
    performAnimations()
  }
  
  func didSelectMenuItem(indexPath: IndexPath){
   performRightViewCleanUp()
     closeMenu()
    switch indexPath.row {
    case 0:
      rightViewController = ChatController()
    case 1:
      rightViewController = UINavigationController(rootViewController: ListsController())

    case 2:
      rightViewController = SettingsController()
    case 3:
      let tabBarController = UITabBarController()
      let momentsController = UIViewController()
      momentsController.navigationItem.title = "Moments"
      momentsController.view.backgroundColor = .orange
      let navController = UINavigationController(rootViewController: momentsController)
      navController.tabBarItem.title = "Moments"
      tabBarController.viewControllers = [navController]
      rightViewController = tabBarController
    default:
      blueView.isHidden = true
     self.navigationController?.popToRootViewController(animated: true)
      
      
      
    }
    
    (rightViewController as? ChatController)?.baseSlidingController = self
    redView.addSubview(rightViewController.view)
    addChild(rightViewController)
    
    redView.bringSubviewToFront(darkCoverView)
    
  }
  
  var rightViewController: UIViewController = ChatController()
  
  
  
  fileprivate func performRightViewCleanUp(){
    rightViewController.view.removeFromSuperview()
    rightViewController.removeFromParent()
  }
  
  fileprivate func performAnimations() {
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
      // leave a reference link down in desc below
      self.view.layoutIfNeeded()
      self.darkCoverView.alpha = self.isMenuOpened ? 1 : 0
    })
  }
  
  var redViewLeadingConstraint: NSLayoutConstraint!
  var redViewTrailingConstraint: NSLayoutConstraint!
  fileprivate let menuWidth: CGFloat = 300
  fileprivate let velocityThreshold: CGFloat = 500
  fileprivate var isMenuOpened = false
  
  fileprivate func setupViews() {
    view.backgroundColor = .white
    view.addSubview(redView)
    view.addSubview(blueView)
    
    NSLayoutConstraint.activate([
      redView.topAnchor.constraint(equalTo: view.topAnchor),
      redView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      
      
      
      blueView.topAnchor.constraint(equalTo: view.topAnchor),
      blueView.trailingAnchor.constraint(equalTo: redView.leadingAnchor),
      blueView.widthAnchor.constraint(equalToConstant: menuWidth),
      blueView.bottomAnchor.constraint(equalTo: redView.bottomAnchor)
      
      ])
    
    redViewLeadingConstraint = redView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
   
    
    redViewLeadingConstraint.isActive = true
    
    redViewTrailingConstraint = redView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    
    redViewTrailingConstraint.isActive = true
    
    setupViewControllers()
  }
  
  fileprivate func setupViewControllers(){
    let menuController = MenuController()
    menuController.baseSlidingController = self
    
    menuController.user = self.user
    (rightViewController as? ChatController)?.baseSlidingController = self
    
    let chatControllerView = rightViewController.view!
    let menuControllerView = menuController.view!
    
    
    redView.addSubview(chatControllerView)
    redView.addSubview(darkCoverView)
    blueView.addSubview(menuControllerView)
    
   
    chatControllerView.fillSuperview()
    menuControllerView.fillSuperview()
    darkCoverView.anchor(top: redView.topAnchor, leading: redView.leadingAnchor, bottom: redView.bottomAnchor, trailing: redView.trailingAnchor)
    
    addChild(rightViewController)
    addChild(menuController)
  }
}
