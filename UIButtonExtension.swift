//
//  UIButtonExtension.swift
//  SwipingViewExample
//
//  Created by Jędrzej Chołuj on 01/07/2020.
//  Copyright © 2020 Jędrzej Chołuj. All rights reserved.
//

import UIKit

extension UIButton {
    
    func animateButton(duration: Double, scale: CGFloat, completion: ((Bool) -> Void)?) {
        let scale = CGAffineTransform(scaleX: scale, y: scale)
        self.transform = scale
        UIButton.animate(withDuration: duration, delay: 0, options: .curveEaseIn, animations: {
            self.transform = .identity
        }, completion: completion)
    }
    
    func configureRoundedButton(cornerRadius: CGFloat, color: UIColor, borderWidth: CGFloat, borderColor: CGColor?) {
        self.clipsToBounds = true
        self.backgroundColor = color
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor
        self.layer.borderWidth = borderWidth
    }
    
    func setSystemSymbolAsButtonImage(color: UIColor, name: String, size: CGFloat) {
        let configuration = UIImage.SymbolConfiguration(pointSize: size)
        self.setImage(UIImage(systemName: name, withConfiguration: configuration), for: .normal)
        self.imageView?.contentMode = .scaleToFill
        self.tintColor = color
    }
    
}

