//
//  LoginViewController.swift
//  Bankey
//
//  Created by Marco Carmona on 6/27/22.
//

import UIKit

class LoginViewController: UIViewController {

  let titleLabel = UILabel()
  let descriptionLabel = UILabel()
  let loginView = LoginView()
  let signInButton = UIButton(type: .system)
  let errorMessageLabel = UILabel()
  
  var username: String? {
    return loginView.usernameTextField.text
  }
  
  var password: String? {
    return loginView.passwordTextField.text
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    style()
    layout()
  }
  

}

extension LoginViewController {
  private func style() {
    titleLabel.font = .preferredFont(forTextStyle: .title1)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.textAlignment = .center
    titleLabel.text = "Bankey"
    
    descriptionLabel.font = .preferredFont(forTextStyle: .body)
    descriptionLabel.numberOfLines = 0
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    descriptionLabel.textAlignment = .center
    descriptionLabel.text = "Your premium source for all things banking!"
    
    loginView.translatesAutoresizingMaskIntoConstraints = false
    
    signInButton.translatesAutoresizingMaskIntoConstraints = false
    signInButton.configuration = .filled()
    signInButton.configuration?.imagePadding = 8 // for indicator spacing
    signInButton.setTitle("Sign In", for: [])
    signInButton.addTarget(
      self,
      action: #selector(signInTapped),
      for: .primaryActionTriggered
    )
    
    errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
    errorMessageLabel.textAlignment = .center
    errorMessageLabel.textColor = .systemRed
    errorMessageLabel.numberOfLines = 0
    errorMessageLabel.isHidden = true
  }
  
  private func layout() {
    let constraints = [
      // Title label
      descriptionLabel.topAnchor.constraint(
        equalToSystemSpacingBelow: titleLabel.bottomAnchor,
        multiplier: 2
      ),
      titleLabel.leadingAnchor.constraint(
        equalToSystemSpacingAfter: view.leadingAnchor,
        multiplier: 1
      ),
      view.trailingAnchor.constraint(
        equalToSystemSpacingAfter: titleLabel.trailingAnchor,
        multiplier: 1
      ),
      // Description label
      loginView.topAnchor.constraint(
        equalToSystemSpacingBelow: descriptionLabel.bottomAnchor,
        multiplier: 2
      ),
      descriptionLabel.leadingAnchor.constraint(
        equalToSystemSpacingAfter: view.leadingAnchor,
        multiplier: 1
      ),
      view.trailingAnchor.constraint(
        equalToSystemSpacingAfter: descriptionLabel.trailingAnchor,
        multiplier: 1
      ),
      // Login view
      loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      loginView.leadingAnchor.constraint(
        equalToSystemSpacingAfter: view.leadingAnchor,
        multiplier: 1
      ),
      view.trailingAnchor.constraint(
        equalToSystemSpacingAfter: loginView.trailingAnchor,
        multiplier: 1
      ),
      // Sign In Button
      signInButton.topAnchor.constraint(
        equalToSystemSpacingBelow: loginView.bottomAnchor,
        multiplier: 2
      ),
      signInButton.leadingAnchor.constraint(
        equalToSystemSpacingAfter: view.leadingAnchor,
        multiplier: 1
      ),
      view.trailingAnchor.constraint(
        equalToSystemSpacingAfter: signInButton.trailingAnchor,
        multiplier: 1
      ),
      // Error message label
      errorMessageLabel.topAnchor.constraint(
        equalToSystemSpacingBelow: signInButton.bottomAnchor,
        multiplier: 2
      ),
      errorMessageLabel.leadingAnchor.constraint(
        equalToSystemSpacingAfter: view.leadingAnchor,
        multiplier: 1
      ),
      view.trailingAnchor.constraint(
        equalToSystemSpacingAfter: errorMessageLabel.trailingAnchor,
        multiplier: 1
      ),
    ]
    
    view.addSubview(titleLabel)
    view.addSubview(descriptionLabel)
    view.addSubview(loginView)
    view.addSubview(signInButton)
    view.addSubview(errorMessageLabel)
    
    NSLayoutConstraint.activate(constraints)
  }
}

extension LoginViewController {
  @objc func signInTapped(sender: UIButton) {
    errorMessageLabel.text = nil
    errorMessageLabel.isHidden = true
    
    guard let errorMessage = login() else {
      signInButton.configuration?.showsActivityIndicator = true
      return
    }
    
    errorMessageLabel.text = errorMessage
    errorMessageLabel.isHidden = false
  }
  
  private func login() -> String? {
    let desiredUser = "mcarmonat"
    let desiredPassword = UIDevice.current.name.split(separator: " ").first ?? ""
    let errorMessage = "Username / Password cannot be blank"
    
    guard let enteredUsername = username, !enteredUsername.isEmpty else {
      return errorMessage
    }
    
    guard let enteredPassword = password, !enteredPassword.isEmpty else {
      return errorMessage
    }
    
    guard desiredUser == enteredUsername && desiredPassword == enteredPassword else {
      return "Incorrect username or password"
    }
    
    return nil
  }
}
