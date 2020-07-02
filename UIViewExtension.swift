//
//  UIViewExtension.swift
//  SwipingViewExample
//
//  Created by Jędrzej Chołuj on 01/07/2020.
//  Copyright © 2020 Jędrzej Chołuj. All rights reserved.
//

import UIKit

extension UIView {
    
    func setRoundedCorners(value: Int) {
        self.clipsToBounds = true
        self.layer.cornerRadius = CGFloat(value)
    }
    
    func setBorder(color: CGColor, width: CGFloat) {
        self.clipsToBounds = true
        self.layer.borderWidth = width
        self.layer.borderColor = color
    }
    
    func setViewShadows(opacity: Float, color: CGColor, radius: CGFloat, offset: CGSize) {
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = opacity
        self.layer.shadowColor = color
        self.layer.shadowRadius = radius
        self.layer.shadowOffset = offset
    }
    
}
