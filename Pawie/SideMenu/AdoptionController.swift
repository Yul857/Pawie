//
//  AdoptionController.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/19/21.
//

import UIKit

class AdoptionController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    private let reuseIdentifier = "adoptionCell"
    //MARK: - properties
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .white
        cv.register(AdoptionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        return cv
    }()
    
    
    
    //MARK: - LifyCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        view.backgroundColor = .white
        
        
        //create a new button
        let button = UIButton(type: .custom)
        //set image for button
        button.setImage(UIImage(named: "plus"), for: .normal)
        //add function for button
        button.addTarget(self, action: #selector(notificationButtonPressed), for: .touchUpInside)
        //set frame
        button.frame = CGRect(x: 0, y: 0, width: 53, height: 51)
        
        let barButton = UIBarButtonItem(customView: button)
        //assign button to navigationbar
        self.navigationItem.rightBarButtonItem = barButton
    }
    //MARK: - Actions

    
    @objc func notificationButtonPressed() {
        let nav = AddAdoptionController()
        self.navigationController?.pushViewController(nav, animated: true)
    }
    
    //MARK: - Helpers
    
    func configure() {
        navigationItem.title = "ADOPTION"
        view.addSubview(collectionView)
        collectionView.fillSuperview()
        
    }
}

//MARK: - UICollectionViewDataSource

extension AdoptionController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AdoptionCell
        return cell
    }
}

//MARK: -  UICollectionViewDelegateLayout

extension AdoptionController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        var height = width + 8 + 40 + 8
        height += 50
        height += 60
        
        return CGSize(width: width, height: height)
    }
}
