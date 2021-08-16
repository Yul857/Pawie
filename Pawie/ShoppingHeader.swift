//
//  ShoppingHeader.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/14/21.
//

import UIKit

class ShoppingHeader: UICollectionReusableView {
    //MARK: properties
    
    private let headerPicture: UIImageView = {
        let headerImage = UIImageView()
        headerImage.image = #imageLiteral(resourceName: "ShoppingHeader")
        headerImage.contentMode = .scaleAspectFill
        headerImage.clipsToBounds = true
        headerImage.backgroundColor = .lightGray
        return headerImage
        
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Catogories"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.layer.cornerRadius = 10
        return label
    }()
    
    private let foodCategory: UIButton = {
        let button = UIButton()
        button.setTitle("Food", for: .normal)
        button.addTarget(self, action: #selector(foodCategoryTapped), for: .touchUpInside)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let toyCategory: UIButton = {
        let button = UIButton()
        button.setTitle("toy", for: .normal)
        button.addTarget(self, action: #selector(toyCategoryTapped), for: .touchUpInside)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let treatCategory: UIButton = {
        let button = UIButton()
        button.setTitle("treat", for: .normal)
        button.addTarget(self, action: #selector(treatCategoryTapped), for: .touchUpInside)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let accessoryCategory: UIButton = {
        let button = UIButton()
        button.setTitle("accessory", for: .normal)
        button.addTarget(self, action: #selector(accessoryCategoryTapped), for: .touchUpInside)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let healthCategory: UIButton = {
        let button = UIButton()
        button.setTitle("health", for: .normal)
        button.addTarget(self, action: #selector(healthCategoryTapped), for: .touchUpInside)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let otherCategory: UIButton = {
        let button = UIButton()
        button.setTitle("other", for: .normal)
        button.addTarget(self, action: #selector(otherCategoryTapped), for: .touchUpInside)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 10
        return button
    }()
    
    
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        
        addSubview(headerPicture)
        headerPicture.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, right: rightAnchor, height: 150)
        
        addSubview(categoryLabel)
        categoryLabel.anchor(top: headerPicture.bottomAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 10)
        
        
        addSubview(foodCategory)
        foodCategory.anchor(top: categoryLabel.bottomAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 10, width: 120)
        
        addSubview(toyCategory)
        toyCategory.anchor(top: foodCategory.bottomAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 10, width: 120)
        
        addSubview(treatCategory)
        treatCategory.anchor(top: categoryLabel.bottomAnchor, left: foodCategory.rightAnchor, paddingTop: 10, paddingLeft: 10, width: 120)
        
        addSubview(accessoryCategory)
        accessoryCategory.anchor(top: foodCategory.bottomAnchor, left: toyCategory.rightAnchor, paddingTop: 10, paddingLeft: 10, width: 120)
        
        addSubview(healthCategory)
        healthCategory.anchor(top: categoryLabel.bottomAnchor, left: treatCategory.rightAnchor, paddingTop: 10, paddingLeft: 10, width: 120)
        
        addSubview(otherCategory)
        otherCategory.anchor(top: foodCategory.bottomAnchor, left: accessoryCategory.rightAnchor, paddingTop: 10, paddingLeft: 10, width: 120)
        
        
        let bottomDivider = UIView()
        bottomDivider.backgroundColor = .black
        addSubview(bottomDivider)
        
        bottomDivider.anchor(top: toyCategory.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 15, height:0.5)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//MARK: - Actions
    
    @objc func foodCategoryTapped() {
        print("DEBUG: Tapped food category button")
    }
    
    @objc func toyCategoryTapped() {
        print("DEBUG: Tapped toy category button")
    }
    
    @objc func accessoryCategoryTapped() {
        print("DEBUG: Tapped accessory category button")
    }
    
    @objc func treatCategoryTapped() {
        print("DEBUG: Tapped treat category button")
    }
    
    @objc func healthCategoryTapped() {
        print("DEBUG: Tapped health category button")
    }
    
    @objc func otherCategoryTapped() {
        print("DEBUG: Tapped other category button")
    }
    
    
}
