//
//  NavigationViewController.swift
//  SwipingViewExample
//
//  Created by Jędrzej Chołuj on 01/07/2020.
//  Copyright © 2020 Jędrzej Chołuj. All rights reserved.
//

import UIKit

class NavigationViewController: UIViewController {
    
    var navigationBar: UINavigationBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        configureNavigationBar()
    }
    
    func setupNavigationBar() {
        navigationBar = UINavigationBar()
        self.view.addSubview(navigationBar)
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureNavigationBar() {
        let font = UIFont(name: "HelveticaNeue-Bold", size: 12)
        navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font!, NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.layoutIfNeeded()
    }
    
}
