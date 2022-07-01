//
//  OnboardingViewController.swift
//  Bankey
//
//  Created by Marco Carmona on 6/30/22.
//

import UIKit

class OnboardingViewController: UIViewController {
  
  private let heroImageName: String
  private let titleText: String
  
  let stackView = UIStackView()
  let imageView = UIImageView()
  let labelView = UILabel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    style()
    layout()
  }
  
  init(heroImageName: String, titleText: String) {
    self.heroImageName = heroImageName
    self.titleText = titleText
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

extension OnboardingViewController {
  func style() {
    view.backgroundColor = .systemBackground
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = 20
    
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    imageView.image = .init(named: heroImageName)
    
    labelView.translatesAutoresizingMaskIntoConstraints = false
    labelView.textAlignment = .center
    labelView.text = titleText
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
