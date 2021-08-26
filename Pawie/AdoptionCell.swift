//
//  AdoptionCell.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/26/21.
//

import UIKit


class AdoptionCell: UICollectionViewCell {
    //MARK: - properties
    
    private let postImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.backgroundColor = .lightGray
        iv.image = #imageLiteral(resourceName: "profile pic")
        return iv
    }()
    
    private let petNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Pet Name:"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let petName: UILabel = {
        let label = UILabel()
        label.text = "BOBO"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let breedLabel: UILabel = {
        let label = UILabel()
        label.text = "Breed:"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let breed: UILabel = {
        let label = UILabel()
        label.text = "Siamese"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let ageLabel: UILabel = {
        let label = UILabel()
        label.text = "Age:"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let age: UILabel = {
        let label = UILabel()
        label.text = "2"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let areaLabel: UILabel = {
        let label = UILabel()
        label.text = "Area:"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let area: UILabel = {
        let label = UILabel()
        label.text = "92117"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let discriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description:"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    
    
    private let discription: UILabel = {
        let label = UILabel()
        label.text = "He is a cute, shy and locing creature He is a cute, shy and locing creature He is a cute, shy and locing creature He is a cute, shy and locing creature He is a cute, shy and locing creature He is a cute, shy and locing creature He is a cute, shy and locing creature He is a cute"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private let contactLabel: UILabel = {
        let label = UILabel()
        label.text = "Contact:"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "123456"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "bobo@gmail.com"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    
    
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(postImageView)
        postImageView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 250)
        
        addSubview(petNameLabel)
        petNameLabel.anchor(top: postImageView.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)
        
        addSubview(petName)
        petName.anchor(top: postImageView.bottomAnchor, left: petNameLabel.rightAnchor, paddingTop: 8, paddingLeft: 4)
        
        addSubview(breedLabel)
        breedLabel.anchor(top: petNameLabel.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)
        
        addSubview(breed)
        breed.anchor(top: petNameLabel.bottomAnchor, left: breedLabel.rightAnchor, paddingTop: 8, paddingLeft: 4)

        addSubview(ageLabel)
        ageLabel.anchor(top: breedLabel.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)
        
        addSubview(age)
        age.anchor(top: breedLabel.bottomAnchor, left: ageLabel.rightAnchor, paddingTop: 8, paddingLeft: 4)
        
        addSubview(areaLabel)
        areaLabel.anchor(top: ageLabel.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)
        
        addSubview(area)
        area.anchor(top: ageLabel.bottomAnchor, left: areaLabel.rightAnchor, paddingTop: 8, paddingLeft: 4)
        
        addSubview(discriptionLabel)
        discriptionLabel.anchor(top: areaLabel.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)
        
        addSubview(discription)
        discription.anchor(top: discriptionLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 8)
        
        addSubview(contactLabel)
        contactLabel.anchor(top: postImageView.bottomAnchor, right: rightAnchor, paddingTop: 8, paddingRight: 20)
        
        addSubview(phoneLabel)
        phoneLabel.anchor(top: contactLabel.bottomAnchor, right: rightAnchor, paddingTop: 8, paddingRight: 20)
        
        addSubview(emailLabel)
        emailLabel.anchor(top: phoneLabel.bottomAnchor, right: rightAnchor, paddingTop: 8, paddingRight: 20)
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
}
