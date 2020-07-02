//
//  SwipingView.swift
//  SwipingViewExample
//
//  Created by Jędrzej Chołuj on 25/06/2020.
//  Copyright © 2020 Jędrzej Chołuj. All rights reserved.
//

import UIKit

protocol SwipingViewsDelegate {
    
    func swipeDidEnd(view: SwipingView)
    
}

class SwipingView: SwipeableView {
    
    var titleLabel: UILabel!
    var swipeView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupSwipingView()
        setupTitleLabel()
        configureLabelApperance()
        configureViewApperance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSwipingView() {
        swipeView = UIView()
        addSubview(swipeView)
        NSLayoutConstraint.activate([
            swipeView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            swipeView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            swipeView.widthAnchor.constraint(equalTo: self.widthAnchor),
            swipeView.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
        swipeView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupTitleLabel() {
        titleLabel = UILabel()
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 80),
            titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20)
        ])
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureLabelApperance() {
        titleLabel.textColor = .black
        titleLabel.backgroundColor = .clear
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 24)
    }
    
    func configureViewApperance() {
        self.backgroundColor = .white
        self.setRoundedCorners(value: 8)
        self.setBorder(color: UIColor.lightText.cgColor, width: 1)
        self.setViewShadows(opacity: 0.6, color: UIColor.gray.cgColor, radius: 4.0, offset: .zero)
        
        let favouriteButton = UIButton()
        self.addSubview(favouriteButton)
        configureFavouriteButton(favouriteButton)
        
        let firstButton = UIButton()
        self.addSubview(firstButton)
        configureFirstButton(firstButton)
        
        let secondButton = UIButton()
        self.addSubview(secondButton)
        configureSecondButton(secondButton)
        
    }
    
    func setupButton(_ button: UIButton, imageName: String, color: UIColor, size: CGFloat) {
        button.configureRoundedButton(cornerRadius: 15, color: .clear, borderWidth: 0, borderColor: nil)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setSystemSymbolAsButtonImage(color: color, name: imageName, size: size)
    }
    
    func configureSecondButton(_ button: UIButton) {
        NSLayoutConstraint.activate([
            button.rightAnchor.constraint(equalTo: self.swipeView.rightAnchor, constant: -55),
            button.topAnchor.constraint(equalTo: self.swipeView.topAnchor, constant: 15),
            button.widthAnchor.constraint(equalToConstant: 35),
            button.heightAnchor.constraint(equalToConstant: 35)
        ])
        setupButton(button, imageName: "arrowshape.turn.up.left.circle", color: .black, size: 35)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    func configureFirstButton(_ button: UIButton) {
        NSLayoutConstraint.activate([
            button.rightAnchor.constraint(equalTo: self.swipeView.rightAnchor, constant: -15),
            button.topAnchor.constraint(equalTo: self.swipeView.topAnchor, constant: 15),
            button.widthAnchor.constraint(equalToConstant: 35),
            button.heightAnchor.constraint(equalToConstant: 35)
        ])
        setupButton(button, imageName: "ellipsis.circle", color: .black, size: 35)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    func configureFavouriteButton(_ button: UIButton) {
        NSLayoutConstraint.activate([
            button.leftAnchor.constraint(equalTo: self.swipeView.leftAnchor, constant: 15),
            button.topAnchor.constraint(equalTo: self.swipeView.topAnchor, constant:15),
            button.widthAnchor.constraint(equalToConstant: 35),
            button.heightAnchor.constraint(equalToConstant: 35)
        ])
        setupButton(button, imageName: "star.circle", color: .lightGray, size: 35)
        button.addTarget(self, action: #selector(favButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc private func buttonTapped(_ button: UIButton) {
        let alert = UIAlertController(title: "Author", message: "App created by Jędrzej Chołuj", preferredStyle: .alert)
        let doneAction = UIAlertAction(title: "Done", style: .default, handler: nil)
        alert.addAction(doneAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    @objc private func favButtonTapped(_ sender: UIButton) {
        let color = sender.tintColor
        color == UIColor.lightGray ?
            sender.setSystemSymbolAsButtonImage(color: .purple, name: "star.circle.fill", size: 35) :
            sender.setSystemSymbolAsButtonImage(color: .lightGray, name: "star.circle", size: 35)
    }

}
