//
//  SwipeableView.swift
//  SwipingViewExample
//
//  Created by Jędrzej Chołuj on 30/06/2020.
//  Copyright © 2020 Jędrzej Chołuj. All rights reserved.
//

import UIKit

protocol SwipeableProtocol {
    
    func getLeftSwipeMargin() -> CGPoint
    func getRightSwipeMargin() -> CGPoint
    func getCenterOfParentView() -> CGPoint
    
}

class SwipeableView: UIView {
    
    var delegate: SwipingViewsDelegate?
    var swipeableDelegate: SwipeableProtocol?
    
    private var panGestureRecognizer: UIPanGestureRecognizer!
    private var centerOfParentView: CGPoint!
    private var leftSwipingMargin: CGPoint!
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        createPanGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createPanGestureRecognizer() {
        let panGesture = UIPanGestureRecognizer(target: self, action:(#selector(self.handlePanGesture(_:))))
        self.addGestureRecognizer(panGesture)
    }
    
    private func recenterView(view: SwipingView) {
        UIView.animate(withDuration: 0.2, animations: {
            view.center = self.centerOfParentView
        })
    }
    
    private func swipingRightDidEnd(view: SwipingView) {
        UIView.animate(withDuration: 0.4, animations: {
            view.frame.origin.x += (self.centerOfParentView.x / 2)
            view.alpha = 0
            view.backgroundColor = .green
            let rotate = CGAffineTransform(rotationAngle: -50)
            view.transform = rotate
        }, completion: { finished in
            self.delegate?.swipeDidEnd(view: view)
            view.removeFromSuperview()
        })
    }
    
    private func swipingLeftDidEnd(view: SwipingView) {
        UIView.animate(withDuration: 0.4, animations: {
            view.frame.origin.x -= (self.centerOfParentView.x / 2)
            view.alpha = 0
            view.backgroundColor = .red
            let rotate = CGAffineTransform(rotationAngle: 50)
            view.transform = rotate
        }, completion: { finished in
            self.delegate?.swipeDidEnd(view: view)
            view.removeFromSuperview()
        })
    }
    
    private func swipingLeft(view: SwipingView) {
        UIView.animate(withDuration: 0.5, animations: {
            view.backgroundColor = .red
        })
    }
    
    @objc private func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        let view = sender.view! as! SwipingView
        let point = sender.translation(in: view)
        centerOfParentView = swipeableDelegate?.getCenterOfParentView()
        view.center = CGPoint(x: centerOfParentView.x + point.x, y: centerOfParentView.y + point.y)
        
        if sender.state == .ended {
            if view.center.x < (swipeableDelegate?.getLeftSwipeMargin())!.x {
                swipingLeftDidEnd(view: view)
            } else if view.center.x > (swipeableDelegate?.getRightSwipeMargin())!.x {
                swipingRightDidEnd(view: view)
            } else {
                recenterView(view: view)
            }
        }
    }
    
}
