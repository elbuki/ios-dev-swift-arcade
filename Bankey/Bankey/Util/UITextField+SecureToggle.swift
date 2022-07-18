//
//  UITextField+SecureToggle.swift
//  Bankey
//
//  Created by Marco Carmona on 7/15/22.
//

import Foundation
import UIKit

let passwordToggleButton = UIButton(type: .custom)

extension UITextField {
    
    func enablePasswordToggle() {
        passwordToggleButton.setImage(.init(systemName: "eye.fill"), for: .normal)
        passwordToggleButton.setImage(.init(systemName: "eye.slash.fill"), for: .selected)
        passwordToggleButton.addTarget(
            self,
            action: #selector(togglePasswordView),
            for: .touchUpInside
        )
        
        rightView = passwordToggleButton
        rightViewMode = .always
    }
    
    @objc func togglePasswordView(_ sender: Any) {
        isSecureTextEntry.toggle()
        passwordToggleButton.isSelected.toggle()
    }
    
}
