//
//  OnboardingContainerViewController.swift
//  Bankey
//
//  Created by Marco Carmona on 6/29/22.
//

import UIKit

protocol OnboardingControllerViewControllerDelegate: AnyObject {
    func didFinishOnboarding()
}

class OnboardingContainerViewController: UIViewController {

    let pageViewController: UIPageViewController
    var pages = [UIViewController]()
    var currentVC: UIViewController
    let closeButton = UIButton(type: .system)
    
    weak var delegate: OnboardingControllerViewControllerDelegate?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
      
        let pagesView = [
          (
            "delorean",
            "Bankey is faster, easier to use, and has a brand new look and feel that will make you feel like you are back in 1989."
          ),
          (
            "world",
            "Move your money around the world quickly and securely."
          ),
          (
            "thumbs",
            "Learn more at www.bankey.com."
          )
        ]
      
        for pageView in pagesView {
          pages.append(OnboardingViewController(heroImageName: pageView.0, titleText: pageView.1))
        }
        
        currentVC = pages.first!
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
      super.viewDidLoad()
        
      setup()
      style()
      layout()
    }
  
  func setup() {
    view.backgroundColor = .systemPurple
    
    addChild(pageViewController)
    view.addSubview(pageViewController.view)
    pageViewController.didMove(toParent: self)
    
    pageViewController.dataSource = self
    pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
        view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
        view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
        view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
        view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor),
    ])
  
    guard let firstPage = pages.first else { return }
    
    pageViewController.setViewControllers(
      [firstPage],
      direction: .forward,
      animated: false,
      completion: nil
    )
    currentVC = firstPage
  }
  
  private func style() {
    closeButton.translatesAutoresizingMaskIntoConstraints = false
    closeButton.setTitle("Close", for: [])
    closeButton.addTarget(self, action: #selector(closeTapped), for: .primaryActionTriggered)
    
    view.addSubview(closeButton)
  }
  
  private func layout() {
    let constraint = [
      closeButton.leadingAnchor.constraint(
        equalToSystemSpacingAfter: view.leadingAnchor,
        multiplier: 2
      ),
      closeButton.topAnchor.constraint(
        equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor,
        multiplier: 1
      )
    ]
    
    NSLayoutConstraint.activate(constraint)
  }
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingContainerViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getPreviousViewController(from: viewController)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getNextViewController(from: viewController)
    }

    private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
        currentVC = pages[index - 1]
        return pages[index - 1]
    }

    private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else { return nil }
        currentVC = pages[index + 1]
        return pages[index + 1]
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pages.firstIndex(of: self.currentVC) ?? 0
    }
}

// MARK: - Actions
extension OnboardingContainerViewController {
  @objc private func closeTapped(_ sender: UIButton) {
      delegate?.didFinishOnboarding()
  }
}
