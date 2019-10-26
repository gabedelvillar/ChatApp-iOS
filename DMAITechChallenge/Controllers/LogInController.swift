//
//  LogInController.swift
//  DMAITechChallenge
//
//  Created by Gabriel Del VIllar on 10/11/19.
//  Copyright © 2019 gdelvillar. All rights reserved.
//

import UIKit

extension LogInController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    let img = info[.originalImage] as? UIImage
    self.selectPhotoBtn.setImage(img?.withRenderingMode(.alwaysOriginal), for: .normal)
    
    dismiss(animated: true)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true)
  }
}

class LogInController: UIViewController {
  // UI Components
  
  
  let selectPhotoBtn: UIButton = {
    let btn = UIButton(type: .system)
    btn.setTitle("Select Photo", for: .normal)
    btn.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
    btn.backgroundColor = .white
    btn.setTitleColor(.black, for: .normal)
    btn.heightAnchor.constraint(equalToConstant: 275).isActive = true
    btn.layer.cornerRadius = 16
    btn.clipsToBounds = true
    btn.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
    btn.imageView?.contentMode = .scaleAspectFill
    btn.clipsToBounds = true
    return btn
  }()
  
  @objc fileprivate func handleSelectPhoto() {
    let imgPickerController = UIImagePickerController()
    imgPickerController.delegate = self
    present(imgPickerController, animated: true)
    
    
  }
  
  let fullNameTextField: CustomTextField = {
    let tf = CustomTextField(padding: 24)
    tf.placeholder = "Enter full name"
    tf.backgroundColor = .white
    tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
    return tf
  }()
  
  let emailTextField: CustomTextField = {
    let tf = CustomTextField(padding: 24)
    tf.placeholder = "Enter email"
    tf.keyboardType = .emailAddress
    tf.backgroundColor = .white
    tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
    return tf
  }()
  
  @objc fileprivate func handleTextChange(textField: UITextField) {
    

  }
  
  let registerButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Register", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
    //button.backgroundColor = #colorLiteral(red: 0.8235294118, green: 0, blue: 0.3254901961, alpha: 1)
    button.backgroundColor = .lightGray
    button.heightAnchor.constraint(equalToConstant: 44).isActive = true
    button.layer.cornerRadius = 22
    button.addTarget(self, action: #selector(registerBtnPressed), for: .touchUpInside)
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupGradientLayer()
    
    setupLayout()
    
    setupNotificationObservers()
    
    setupTapGesture()
    
    
  }
  
  fileprivate func setupTapGesture() {
    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
  }
  
  @objc fileprivate func handleTapDismiss(){
    // dismisses the keyboard
    self.view.endEditing(true)
    
    
  }
  
  @objc fileprivate func handleKeyboardHide(){
    
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
      self.view.transform = .identity
    })
    
    
  }
  
  fileprivate func setupNotificationObservers() {
    NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    
    NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    
    
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    NotificationCenter.default.removeObserver(self)
    
    
  }
  
  @objc fileprivate func handleKeyboardShow(notification: Notification){
    
    // figure out how tall the keyboard is
    guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
    
    let keyboardFrame = value.cgRectValue
    
    // figure out the gap between the register btn and  the bottom of the screen
    let bottomSpace = view.frame.height - overallStackView.frame.origin.y - overallStackView.frame.height
    
    let difference = keyboardFrame.height - bottomSpace
    
    
    
    self.view.transform = CGAffineTransform(translationX: 0, y: -difference - 10)
    
  }
  
  
  @objc fileprivate func registerBtnPressed(){
    
    
    if let fullName = fullNameTextField.text, let email =  emailTextField.text {
      
      if !fullName.isEmpty && !email.isEmpty{
        
        let user = User(name: fullName, email: email, imgView: selectPhotoBtn.imageView ?? UIImageView(backgroundColor: .blue))
        
        let baseSlidingController = BaseSlidingController(user: user)
        
        navigationController?.pushViewController(baseSlidingController, animated: true)
        
        fullNameTextField.text = nil
        emailTextField.text = nil
        selectPhotoBtn.setImage(nil, for: .normal)
        
      } else{
        let message = "Please fill out both your full name and email address."
        let alert = UIAlertController(title: "Input Field(s) Empty", message: message, preferredStyle: .alert)
        
        present(alert, animated: true)
        
        let when = DispatchTime.now() + 3
        DispatchQueue.main.asyncAfter(deadline: when){
          alert.dismiss(animated: true, completion: nil)
        }
        
      }
      
     
    }

  }
  

  

  

  
  lazy var verticalStackView: UIStackView = {
    let sv = UIStackView(arrangedSubviews: [
      fullNameTextField,
      emailTextField,
      registerButton
      ])
    sv.axis = .vertical
    sv.distribution = .fillEqually
    sv.spacing = 8
    return sv
  }()
  
  lazy var overallStackView = UIStackView(arrangedSubviews: [
    selectPhotoBtn,
    UIStackView(arrangedSubviews: [
      verticalStackView
      ])
    ])
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    if self.traitCollection.verticalSizeClass == .compact {
      overallStackView.axis = .horizontal
      
    } else {
      overallStackView.axis = .vertical
    }
  }
  
  fileprivate func setupLayout() {
    
    self.navigationController?.isNavigationBarHidden = true
    
    overallStackView.axis = .horizontal
    selectPhotoBtn.widthAnchor.constraint(equalToConstant: 275).isActive = true
    overallStackView.spacing = 8
    view.addSubview(overallStackView)
    
    
    overallStackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 50, bottom: 0, right: 50))
    
    overallStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
  }
  
  let gradientLayer = CAGradientLayer()
  
  override func viewWillLayoutSubviews() {
    gradientLayer.frame = view.bounds
  }
  
  
  fileprivate func setupGradientLayer() {
    
    
    let topColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
    let bottomColor = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
    gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
    gradientLayer.locations = [0,1]
    
    view.layer.addSublayer(gradientLayer)
    gradientLayer.frame = view.bounds
  }
  

}
