//
//  LoginView.swift
//  Bankey
//
//  Created by Marco Carmona on 6/27/22.
//

import Foundation
import UIKit

class LoginView: UIView, UITextFieldDelegate {
  
  let stackView = UIStackView()
  let usernameTextField = UITextField()
  let passwordTextField = UITextField()
  let dividerView = UIView()

  override init(frame: CGRect) {
    super.init(frame: frame)
    
    style()
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func style() {
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = .secondarySystemBackground
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = 8
    
    usernameTextField.translatesAutoresizingMaskIntoConstraints = false
    usernameTextField.placeholder = "Username"
    usernameTextField.delegate = self
    
    passwordTextField.translatesAutoresizingMaskIntoConstraints = false
    passwordTextField.placeholder = "Password"
    passwordTextField.isSecureTextEntry = true
    passwordTextField.delegate = self
    
    dividerView.translatesAutoresizingMaskIntoConstraints = false
    dividerView.backgroundColor = .secondarySystemFill
    
    layer.cornerRadius = 5
    clipsToBounds = true
  }
    
  func layout() {
    let constraints = [
      stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
      stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
      trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
      bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1),
      dividerView.heightAnchor.constraint(equalToConstant: 1)
    ]
    
    stackView.addArrangedSubview(usernameTextField)
    stackView.addArrangedSubview(dividerView)
    stackView.addArrangedSubview(passwordTextField)
    addSubview(stackView)
    
    NSLayoutConstraint.activate(constraints)
  }

}

extension LoginView: UITextViewDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    usernameTextField.endEditing(true)
    passwordTextField.endEditing(true)
    return true
  }
  
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    return true
  }
}
