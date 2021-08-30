//
//  LostNFoundController.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/19/21.
//

import UIKit

class LostNFoundController: UIViewController {
    //MARK: - properties
    
    private let titleOneLabel: UILabel = {
        let label = UILabel()
        label.text = "There are "
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.numberOfLines = 0
        return label
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.text = "1200"
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.numberOfLines = 0
        return label
    }()
    
    private let titleTwoLabel: UILabel = {
        let label = UILabel()
        label.text = "pets found their owner"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.numberOfLines = 0
        return label
    }()
    
    private let lostButton: UIButton = {
        let button = UIButton()
        button.setTitle("LOST", for: .normal)
        button.backgroundColor =  #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        button.tintColor = .black
        button.setDimensions(height: 70, width: 140)
        button.addTarget(self, action: #selector(showLost), for: .touchUpInside)
        return button
    }()
    
    private let foundButton: UIButton = {
        let button = UIButton()
        button.setTitle("FOUND", for: .normal)
        button.backgroundColor =  #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        button.tintColor = .black
        button.setDimensions(height: 70, width: 140)
        button.addTarget(self, action: #selector(showFound), for: .touchUpInside)
        return button
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "LOST AND FOUND"
        configureUI()
    }
    
    //MARK: - Helpers
    func configureUI() {
        configurePinkGradientLayer()
        view.backgroundColor = .white
        view.addSubview(titleOneLabel)
        titleOneLabel.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 200)
        
        view.addSubview(numberLabel)
        numberLabel.centerX(inView: view, topAnchor: titleOneLabel.bottomAnchor, paddingTop: 8)
        
        view.addSubview(titleTwoLabel)
        titleTwoLabel.centerX(inView: view, topAnchor: numberLabel.bottomAnchor, paddingTop: 8)
        
        let stack = UIStackView(arrangedSubviews: [lostButton, foundButton])
        stack.axis = .horizontal
        stack.spacing = 30
        
        view.addSubview(stack)
        stack.centerX(inView: view, topAnchor: titleTwoLabel.bottomAnchor, paddingTop: 150)
    }
    
    @objc func showLost() {
        let nav = LostController()
        self.navigationController?.pushViewController(nav, animated: true)
    }
    
    @objc func showFound() {
        let nav = FoundController()
        self.navigationController?.pushViewController(nav, animated: true)
    }
}
