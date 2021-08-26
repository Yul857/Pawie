//
//  ShoppingCell.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/14/21.
//


import UIKit
class ShoppingCell: UICollectionViewCell {
    //MARK: - properties
    
  
    
    private let goodsImageView: UIImageView =  {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "toyImage")
        return iv
    }()
    
    private let goodsTitle: UILabel = {
        let label = UILabel()
        label.text = "dogs toy that your cat will definitely love!!"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private let originalPriceLabel: UILabel = {
        let label = UILabel()
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "Was $20")
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        label.attributedText = attributeString
        return label
    }()
    
    private let discountedPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Now $16"
        return label
    }()
    
    private let addItem: UIButton = {
        let iv = UIButton()
        iv.setImage(#imageLiteral(resourceName: "add-Goods"), for: .normal)
        iv.addTarget(self, action: #selector(addItemToCart), for: .touchUpInside)
        return iv
    }()
    
    
    
    //MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(goodsImageView)
        goodsImageView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor)
        
        addSubview(goodsTitle)
        goodsTitle.anchor(top: goodsImageView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 5, height: 50)
        goodsTitle.numberOfLines = 0
        
        addSubview(originalPriceLabel)
        originalPriceLabel.anchor(top: goodsTitle.bottomAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 8)
        
        addSubview(discountedPriceLabel)
        discountedPriceLabel.anchor(top: originalPriceLabel.bottomAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 8)
        
//        contentView.addSubview(addItem)
//        addItem.anchor(top: goodsTitle.bottomAnchor, right: rightAnchor, paddingTop: 10, paddingRight: 8, width: 40, height: 40)
//        addItem.layer.cornerRadius = 40 / 2
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Actions
    
    @objc func addItemToCart() {
        print("DEBUG: Add this item to cart")
    }
    





}

