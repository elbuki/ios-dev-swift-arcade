//
//  AppDelegate.swift
//  Bankey
//
//  Created by Marco Carmona on 6/27/22.
//

import UIKit

let appColor: UIColor = .systemTeal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
    
  let onboardingContainerViewController = OnboardingContainerViewController()
  let loginViewController = LoginViewController()
  let mainViewController = MainViewController()
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [
      UIApplication.LaunchOptionsKey: Any
    ]?
  ) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    window?.backgroundColor = .systemBackground
      
    loginViewController.delegate = self
    onboardingContainerViewController.delegate = self
      
    let vc = mainViewController
    
    vc.setStatusBar()
      
    UINavigationBar.appearance().isTranslucent = false
    UINavigationBar.appearance().backgroundColor = appColor
      
    window?.rootViewController = vc
    
    return true
    
  }

}

extension AppDelegate: LoginViewControllerDelegate {
    func didLogin() {
        var controller: UIViewController = onboardingContainerViewController
        
        if LocalState.hasOnboarded {
            controller = mainViewController
        }
        
        setRootViewController(controller)
    }
}

extension AppDelegate: OnboardingControllerViewControllerDelegate {
    func didFinishOnboarding() {
        LocalState.hasOnboarded = true
        setRootViewController(mainViewController)
    }
}

extension AppDelegate: LogoutDelegate {
    func didLogout() {
        setRootViewController(loginViewController)
    }
}

extension AppDelegate {
    func setRootViewController(_ vc: UIViewController, withAnimation: Bool = true) {
        guard let window = window, withAnimation else {
            window?.rootViewController = vc
            window?.makeKeyAndVisible()
            return
        }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(
            with: window,
            duration: 0.3,
            options: .transitionCrossDissolve,
            animations: nil,
            completion: nil
        )
    }
}
