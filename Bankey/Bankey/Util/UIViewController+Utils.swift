//
//  UIViewController+Utils.swift
//  Bankey
//
//  Created by Marco Carmona on 7/5/22.
//

import UIKit

extension UIViewController {
    func setStatusBar() {
        let navBarApperance = UINavigationBarAppearance()
        
        navBarApperance.configureWithTransparentBackground()
        navBarApperance.backgroundColor = appColor
        
        UINavigationBar.appearance().standardAppearance = navBarApperance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarApperance
    }
    
    func setTabBarImage(imageName: String, title: String) {
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: imageName, withConfiguration: configuration)
        
        tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
    }
}


