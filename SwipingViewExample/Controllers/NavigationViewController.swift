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
    
    override func loadView() {
        super.loadView()
        
        setupNavigationBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
    }
    
    func setupNavigationBar() {
        let navBar = UINavigationBar()
        self.view.addSubview(navBar)
        navBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            navBar.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        self.navigationBar = navBar
    }
    
    func configureNavigationBar() {
        let font = UIFont(name: "HelveticaNeue-Bold", size: 12)
        navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font!, NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.layoutIfNeeded()
    }
    
}
