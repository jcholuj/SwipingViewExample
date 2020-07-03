//
//  SwipingContainerView.swift
//  SwipingViewExample
//
//  Created by Jędrzej Chołuj on 26/06/2020.
//  Copyright © 2020 Jędrzej Chołuj. All rights reserved.
//

import UIKit

protocol SwipingViewsDataSource {
    
    func numberOfViewsToPresent() -> Int
    func viewToPresent(viewAtIndex: Int) -> SwipingView
    func emptyView()
    
}

class SwipingContainerView: UIView {
    
    var numberOfViewsToPresent = 0
    var numberOfVisibleViews = 3
    var visibleViews = [SwipingView]()
    var numberOfViewsLeftToPresent = 0
    let multiplier = 15
    
    var dataSource: SwipingViewsDataSource? {
        didSet {
            reloadVisibleViews()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addFrameForViewInHierarchy(index: Int, view: SwipingView) {
        let sizeDifference = CGFloat(index * multiplier)
        var viewFrame = bounds
        viewFrame.size.width -= 2 * sizeDifference
        viewFrame.origin.x += sizeDifference
        viewFrame.origin.y += sizeDifference
        view.frame = viewFrame
    }
    
    func addViewToHierarchy(index: Int, view: SwipingView) {
        view.delegate = self
        view.swipeableDelegate = self
        addFrameForViewInHierarchy(index: index, view: view)
        visibleViews.append(view)
        insertSubview(view, at: 0)
        numberOfViewsLeftToPresent -= 1
        
    }
    
    func deleteFirstView() {
        guard let dataSource = dataSource else { return }
        numberOfViewsToPresent = dataSource.numberOfViewsToPresent()
        if !visibleViews.isEmpty {
            visibleViews[0].removeFromSuperview()
            visibleViews.remove(at: 0)
            moveViews()
            if numberOfViewsLeftToPresent > 0 {
                addViewToHierarchy(index: visibleViews.count, view: dataSource.viewToPresent(viewAtIndex: numberOfViewsToPresent - numberOfViewsLeftToPresent))
            }
            if visibleViews.count == 0 && numberOfViewsLeftToPresent == 0 {
                dataSource.emptyView()
            }
        }
    }
    
    func reloadNumberOfViewsToPresent() {
        guard let dataSource = dataSource else { return }
        numberOfViewsToPresent = dataSource.numberOfViewsToPresent()
        numberOfViewsLeftToPresent += 1
        if visibleViews.count < 3 {
            addViewToHierarchy(index: visibleViews.count, view: dataSource.viewToPresent(viewAtIndex: numberOfViewsToPresent - 1))
        }
    }

    func reloadVisibleViews() {
        removeCurrentlyVisibleViews()
        visibleViews.removeAll()
        guard let dataSource = dataSource else { return }
        layoutIfNeeded()
        numberOfViewsToPresent = dataSource.numberOfViewsToPresent()
        numberOfViewsLeftToPresent = numberOfViewsToPresent
        let range = (0..<min(numberOfVisibleViews, numberOfViewsToPresent))
        range.forEach({addViewToHierarchy(index: $0, view: dataSource.viewToPresent(viewAtIndex: $0))})
    }
    
    func removeCurrentlyVisibleViews() {
        visibleViews.forEach({ $0.removeFromSuperview() })
    }
    
}

extension SwipingContainerView: SwipingViewsDelegate {
    
    func moveViews() {
        visibleViews.enumerated().forEach({ (index, view) in
            UIView.animate(withDuration: 0.2, animations: {
                view.center = self.center
                self.addFrameForViewInHierarchy(index: index, view: view)
            })
        })
    }
    
    func swipeDidEnd(view: SwipingView) {
        visibleViews.remove(at: 0)
        guard let dataSource = dataSource else { return }
        
        if numberOfViewsLeftToPresent > 0 {
            let indexToInsert = dataSource.numberOfViewsToPresent() - numberOfViewsLeftToPresent
            addViewToHierarchy(index: indexToInsert, view: dataSource.viewToPresent(viewAtIndex: indexToInsert))
            
            moveViews()
        } else {
            moveViews()
        }
        
        if visibleViews.isEmpty {
            dataSource.emptyView()
        }
        
    }
    
}

extension SwipingContainerView: SwipeableProtocol {
    
    func getLeftSwipeMargin() -> CGPoint {
        return CGPoint(x: self.frame.width * 0.2, y: 0)
    }
    
    func getRightSwipeMargin() -> CGPoint {
        return CGPoint(x: self.frame.width * 0.8, y: 0)
    }
    
    func getCenterOfParentView() -> CGPoint {
        return CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
    }
    
}
