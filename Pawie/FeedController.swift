//
//  FeedController.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/5/21.
//

import UIKit
import Firebase


class FeedController: UICollectionViewController{
    
    private let reuseIdentifier = "feedCell"
    //MARK: - properties
    
    
    //MARK: - LifyCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    //MARK: - Actions
    @objc func handleLogOut() {
        do{
            let controller = LoginController()
            controller.delegate = self.tabBarController as? MainTabController
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: false, completion: nil)
            try Auth.auth().signOut()
        }catch{
            print("failed to logged out , \(error)")
        }
        
    }
    
    //MARK: - Helpers
    
    func configure() {
        collectionView.backgroundColor = .white
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out",
                                                           style: .plain, target: self,
                                                           action: #selector(handleLogOut))
        navigationItem.title = "PAWIE"
    }
}

//MARK: - UICollectionViewDataSource

extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
        return cell
    }
}

//MARK: -  UICollectionViewDelegateLayout

extension FeedController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        var height = width + 8 + 40 + 8
        height += 50
        height += 60
        
        return CGSize(width: width, height: height)
    }
}
