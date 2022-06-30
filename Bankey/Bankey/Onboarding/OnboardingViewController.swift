//
//  OnboardingViewController.swift
//  Bankey
//
//  Created by Marco Carmona on 6/30/22.
//

import UIKit

class OnboardingViewController: UIViewController {
  
  let stackView = UIStackView()
  let imageView = UIImageView()
  let labelView = UILabel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    style()
    layout()
  }
  
}

extension OnboardingViewController {
  func style() {
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = 20
    
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    imageView.image = .init(named: "delorean")
    
    labelView.translatesAutoresizingMaskIntoConstraints = false
    labelView.textAlignment = .center
    labelView.text = "Bankey is faster, easier to use, and has a brand new look and feel that will make you feel like you are back in 1989."
    labelView.adjustsFontForContentSizeCategory = true
    labelView.numberOfLines = 0
    labelView.font = .preferredFont(forTextStyle: .title3)
  }
  
  func layout() {
    let constraints = [
      stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      stackView.leadingAnchor.constraint(
        equalToSystemSpacingAfter: view.leadingAnchor,
        multiplier: 1
      ),
      view.trailingAnchor.constraint(
        equalToSystemSpacingAfter: stackView.trailingAnchor,
        multiplier: 1
      )
    ]
    
    stackView.addArrangedSubview(imageView)
    stackView.addArrangedSubview(labelView)
    
    view.addSubview(stackView)
    
    NSLayoutConstraint.activate(constraints)
  }
}
