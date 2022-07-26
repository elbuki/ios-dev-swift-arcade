//
//  SkeletonLoadable.swift
//  Bankey
//
//  Created by Marco Carmona on 7/25/22.
//

import QuartzCore
import UIKit

protocol SkeletonLoadable {}

extension SkeletonLoadable {
    
    func makeAnimationGroup(previousGroup: CAAnimationGroup? = nil) -> CAAnimationGroup {
        let animDuration: CFTimeInterval = 1.5
        let group = CAAnimationGroup()
        let gradientDarkGrey = UIColor(
            red: 239 / 255.0,
            green: 241 / 255.0,
            blue: 241 / 255.0,
            alpha: 1
        )
        let gradientLightGrey = UIColor(
            red: 201 / 255.0,
            green: 201 / 255.0,
            blue: 201 / 255.0,
            alpha: 1
        )
        var animations: [CABasicAnimation] = []
        var fromColor = gradientLightGrey.cgColor
        var toColor = gradientDarkGrey.cgColor
        
        for index in 0..<2 {
            let animation = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
            let fromColorTemp = fromColor
            
            animation.fromValue = fromColor
            animation.toValue = toColor
            animation.duration = animDuration
            animation.beginTime = 0.0
            
            if let lastAnimation = animations.last, index > 0 {
                animation.beginTime = lastAnimation.beginTime + lastAnimation.duration
            }
            
            fromColor = toColor
            toColor = fromColorTemp
            
            animations.append(animation)
        }
        
        group.animations = animations
        group.repeatCount = .greatestFiniteMagnitude
        group.isRemovedOnCompletion = false
        
        if let lastAnimation = animations.last {
            group.duration = lastAnimation.beginTime + lastAnimation.duration
        }
        
        if let previousGroup = previousGroup {
            // Offset groups by 0.33 seconds for effect
            group.beginTime = previousGroup.beginTime + 0.33
        }
        
        return group
    }
    
}
