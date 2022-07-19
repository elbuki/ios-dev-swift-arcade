//
//  LoginViewController.swift
//  Bankey
//
//  Created by Marco Carmona on 6/27/22.
//

import UIKit

protocol LogoutDelegate: AnyObject {
    func didLogout()
}

protocol LoginViewControllerDelegate: AnyObject {
    func didLogin()
}

class LoginViewController: UIViewController {

  let titleLabel = UILabel()
  let descriptionLabel = UILabel()
  let loginView = LoginView()
  let signInButton = UIButton(type: .system)
  let errorMessageLabel = UILabel()
  
  weak var delegate: LoginViewControllerDelegate?
    
  var username: String? {
    return loginView.usernameTextField.text
  }
  
  var password: String? {
    return loginView.passwordTextField.text
  }
    
    var leadingEdgeOnScreen: CGFloat = 16
    var leadingEdgeOffScreen: CGFloat = -1000
    
    var titleLeadingAnchor: NSLayoutConstraint?
    var subtitleLeadingAnchor: NSLayoutConstraint?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    style()
    layout()
  }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        signInButton.configuration?.showsActivityIndicator = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animate()
    }
  

}

extension LoginViewController {
  private func style() {
    titleLabel.font = .preferredFont(forTextStyle: .title1)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.textAlignment = .center
    titleLabel.text = "Bankey"
      titleLabel.alpha = 0

    descriptionLabel.font = .preferredFont(forTextStyle: .body)
    descriptionLabel.numberOfLines = 0
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    descriptionLabel.textAlignment = .center
    descriptionLabel.text = "Your premium source for all things banking!"
      descriptionLabel.alpha = 0
    
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
      titleLeadingAnchor = titleLabel.leadingAnchor.constraint(
        equalTo: view.leadingAnchor,
        constant: leadingEdgeOffScreen
      )
      
      subtitleLeadingAnchor = descriptionLabel.leadingAnchor.constraint(
        equalTo: view.leadingAnchor,
        constant: leadingEdgeOffScreen
      )
      
      guard let titleLeadingAnchor = titleLeadingAnchor else { return }
      guard let subtitleLeadingAnchor = subtitleLeadingAnchor else { return }
      
    let constraints = [
      // Title label
      descriptionLabel.topAnchor.constraint(
        equalToSystemSpacingBelow: titleLabel.bottomAnchor,
        multiplier: 3
      ),
      titleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
      titleLeadingAnchor,
      // Description label
      loginView.topAnchor.constraint(
        equalToSystemSpacingBelow: descriptionLabel.bottomAnchor,
        multiplier: 3
      ),
      descriptionLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
      subtitleLeadingAnchor,
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
      delegate?.didLogin()
      return
    }
    
    errorMessageLabel.text = errorMessage
    errorMessageLabel.isHidden = false
      shakeButton()
      
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
    
    private func shakeButton() {
        let animation = CAKeyframeAnimation()
        
        animation.keyPath = "position.x"
        animation.values = [0, 10, -10, 10, 0]
        animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
        animation.duration = 0.4
        animation.isAdditive = true
        
        signInButton.layer.add(animation, forKey: "shake")
    }
}

// MARK: - Animations
extension LoginViewController {
    
    private func animate() {
        let duration = 0.8
        
        let animator1 = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            self.titleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        
        let animator2 = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            self.subtitleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        
        let animator3 = UIViewPropertyAnimator(duration: duration * 2, curve: .easeInOut) {
            self.titleLabel.alpha = 1
            self.descriptionLabel.alpha = 1
            self.view.layoutIfNeeded()
        }
        
        animator1.startAnimation()
        animator2.startAnimation(afterDelay: 0.2)
        animator3.startAnimation(afterDelay: 0.2)
    }
    
}
