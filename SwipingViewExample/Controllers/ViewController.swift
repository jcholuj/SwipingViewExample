//
//  ViewController.swift
//  SwipingViewExample
//
//  Created by Jędrzej Chołuj on 25/06/2020.
//  Copyright © 2020 Jędrzej Chołuj. All rights reserved.
//

import UIKit

class ViewController: NavigationViewController {
    
    var dataArray = [DataModel(title: "CARD 1"), DataModel(title: "CARD 2"), DataModel(title: "CARD 3"), DataModel(title: "CARD 4"), DataModel(title: "CARD 5"), DataModel(title: "CARD 6")]
    var swipingContainer: SwipingContainerView!
    var addButton: UIButton!
    var emptyViewLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSwipingContainer()
        configureAddButton()
        configureEmptyViewLabel()
        setupNavigationBar()
        configureNavigationBar()
        configureBarElements()
        view.backgroundColor = .white
        swipingContainer.dataSource = self
    }
    
    func configureBarElements() {
        let navigationItem = UINavigationItem(title: "NAUKA")
        let configuration = UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold)
        let rightImage = UIImage(systemName: "arrow.counterclockwise", withConfiguration: configuration)
        let leftImage = UIImage(systemName: "trash.circle", withConfiguration: configuration)
        let rightBarButton = UIBarButtonItem(image: rightImage,
                                             style: .plain,
                                             target: nil,
                                             action: #selector(reloadData))
        let leftBarButton = UIBarButtonItem(image: leftImage,
                                            style: .plain,
                                            target: nil,
                                            action: #selector(deleteView))
        navigationItem.rightBarButtonItem = rightBarButton
        navigationItem.leftBarButtonItem = leftBarButton
        navigationBar.barTintColor = .white
        navigationBar.tintColor = .black
        navigationBar.setItems([navigationItem], animated: false)
    }
    
    @objc private func deleteView() {
        swipingContainer.deleteFirstView()
    }
    
    @objc private func reloadData() {
        swipingContainer.reloadVisibleViews()
        emptyViewLabel.isHidden = true
    }
    
    func configureSwipingContainer() {
        swipingContainer = SwipingContainerView()
        view.addSubview(swipingContainer)
        NSLayoutConstraint.activate([
            swipingContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            swipingContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -115),
            swipingContainer.widthAnchor.constraint(equalToConstant: view.frame.width * 0.9),
            swipingContainer.heightAnchor.constraint(equalToConstant: view.frame.height * 0.72)
        ])
        swipingContainer.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureEmptyViewLabel() {
        emptyViewLabel = UILabel()
        swipingContainer.insertSubview(emptyViewLabel, aboveSubview: swipingContainer)
        emptyViewLabel.isHidden = true
        NSLayoutConstraint.activate([
            emptyViewLabel.centerXAnchor.constraint(equalTo: swipingContainer.centerXAnchor),
            emptyViewLabel.centerYAnchor.constraint(equalTo: swipingContainer.centerYAnchor),
            emptyViewLabel.widthAnchor.constraint(equalTo: swipingContainer.widthAnchor),
            emptyViewLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        emptyViewLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyViewLabel.textAlignment = .center
        emptyViewLabel.text = "There's nothing to display.."
        emptyViewLabel.backgroundColor = .clear
        emptyViewLabel.textColor = .lightGray
    }

    func configureAddButton() {
        addButton = UIButton()
        view.addSubview(addButton)
        addButton.configureRoundedButton(cornerRadius: 25, color: .purple, borderWidth: 0, borderColor: nil)
        let configuration = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)
        addButton.setImage(UIImage(systemName: "plus", withConfiguration: configuration), for: .normal)
        addButton.tintColor = .white
        NSLayoutConstraint.activate([
            addButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            addButton.heightAnchor.constraint(equalToConstant: 50),
            addButton.widthAnchor.constraint(equalToConstant: 50)
        ])
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        addButton.addTarget(self, action: #selector(addButtonPressed(_:)), for: .touchUpInside)
    }
    
    @objc private func addButtonPressed(_ sender: UIButton) {
        sender.animateButton(duration: 0.4, scale: 1.2) { _ in
            self.presentAddViewAlert()
        }
    }
    
    func presentAddViewAlert() {
        let alert = UIAlertController(title: "Add View", message: "Enter text for the new view", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Enter text"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default, handler: { addAction in
            guard let textField = alert.textFields?[0] else { return }
            if textField.text?.isEmpty == false {
                self.dataArray.append(DataModel(title: textField.text!))
                self.swipingContainer.reloadNumberOfViewsToPresent()
                self.emptyViewLabel.isHidden = true
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        alert.preferredAction = addAction
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension ViewController: SwipingViewsDataSource {
    
    func numberOfViewsToPresent() -> Int {
        return dataArray.count
    }
    
    func viewToPresent(viewAtIndex: Int) -> SwipingView {
        let view = SwipingView()
        // If we will have more components of the view content then we could extract method to configure View content at given index
        view.titleLabel.text = dataArray[viewAtIndex].title
        return view
    }
    
    func emptyView() {
        emptyViewLabel.isHidden = false
    }
    
}
