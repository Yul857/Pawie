//
//  ServiceController.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/19/21.
//

import UIKit

class ServiceController: UIViewController {
    
    //MARK: - properties
    
    var isSlideMenuPressed = false
    
    lazy var slideInMenuPadding: CGFloat = self.view.frame.width * 0.4
    
    lazy var menuBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "sidebar.leading")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(menuBarButtonTapped))
    
    private let askVetButton: UIButton = {
        let button = UIButton()
        button.setTitle("ASK VETERINARIAN", for: .normal)
        button.backgroundColor = .systemRed
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(askVetTapped), for: .touchUpInside)
        return button
    }()
    
    private let lostFoundButton: UIButton = {
        let button = UIButton()
        button.setTitle("LOST/ FOUND PET", for: .normal)
        button.backgroundColor = .systemOrange
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(lostFoundTapped), for: .touchUpInside)
        return button
    }()
    
    private let hospitalNearMe: UIButton = {
        let button = UIButton()
        button.setTitle("ANIMAL HOSPITAL", for: .normal)
        button.backgroundColor = .systemYellow
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(hospitalTapped), for: .touchUpInside)
        return button
    }()
    
    private let giftButton: UIButton = {
        let button = UIButton()
        button.setTitle("GIFT", for: .normal)
        button.backgroundColor = .systemGreen
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(giftTapped), for: .touchUpInside)
        return button
    }()
    
    private let tryLuckButton: UIButton = {
        let button = UIButton()
        button.setTitle("TRY YOUR LUCK", for: .normal)
        button.backgroundColor = .systemBlue
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(tryLuckTapped), for: .touchUpInside)
        return button
    }()
    
    private let adoptionButton: UIButton = {
        let button = UIButton()
        button.setTitle("ADOPTION", for: .normal)
        button.backgroundColor = .systemIndigo
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(adoptionTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - LIFECYCLES
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "service-icon"), style: .plain, target: self, action: #selector(goBackToFeed))
        

        view.backgroundColor = .white
        navigationItem.setLeftBarButton(menuBarButtonItem, animated: false)
        
        menuView.pinMenuTo(view, with: slideInMenuPadding)
        menuView.addSubview(askVetButton)
        askVetButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 80)
        
        menuView.addSubview(lostFoundButton)
        lostFoundButton.anchor(top: askVetButton.bottomAnchor, left: view.leftAnchor,right: view.rightAnchor, height: 80)
        
        menuView.addSubview(hospitalNearMe)
        hospitalNearMe.anchor(top: lostFoundButton.bottomAnchor, left: view.leftAnchor,right: view.rightAnchor, height: 80)
        
        menuView.addSubview(giftButton)
        giftButton.anchor(top: hospitalNearMe.bottomAnchor, left: view.leftAnchor,right: view.rightAnchor, height: 80)
        
        menuView.addSubview(tryLuckButton)
        tryLuckButton.anchor(top: giftButton.bottomAnchor, left: view.leftAnchor,right: view.rightAnchor, height: 80)
        
        menuView.addSubview(adoptionButton)
        adoptionButton.anchor(top: tryLuckButton.bottomAnchor, left: view.leftAnchor,right: view.rightAnchor, height: 80)
        
        containerView.edgeTo(view)
    }
    
    lazy var menuView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    
    
    //MARK: - ACTIONS
    
    @objc func goBackToFeed() {
        navigationController?.popViewController(animated: false)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @objc func menuBarButtonTapped() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
            self.containerView.frame.origin.x = self.isSlideMenuPressed ? 0 : self.containerView.frame.width - self.slideInMenuPadding
        } completion: { finished in
            print("DEBUG: Animation finished \(finished)")
            self.isSlideMenuPressed.toggle()
        }
    }
    
    @objc func askVetTapped() {
        let nav = AskVetController()
        self.navigationController?.pushViewController(nav, animated: true)
    }
    @objc func lostFoundTapped() {
        let nav = LostNFoundController()
        self.navigationController?.pushViewController(nav, animated: true)
    }
    @objc func hospitalTapped() {
        let nav = HospitalController()
        self.navigationController?.pushViewController(nav, animated: true)
    }
    @objc func giftTapped() {
        let nav = GiftController()
        self.navigationController?.pushViewController(nav, animated: true)
    }
    @objc func tryLuckTapped() {
        let nav = TryLuckController()
        self.navigationController?.pushViewController(nav, animated: false)
    }
    @objc func adoptionTapped() {
        let nav = AdoptiontController()
        self.navigationController?.pushViewController(nav, animated: false)
    }
}
