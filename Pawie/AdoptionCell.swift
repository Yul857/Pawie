//
//  AdoptionCell.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/26/21.
//

import UIKit
import SDWebImage


class AdoptionCell: UICollectionViewCell {
    //MARK: - properties
    
    var viewModel: AdoptionViewModel? {
        didSet{configure()}
        }
    
    private let postImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    private let speciesLabel: UILabel = {
        let label = UILabel()
        label.text = "Pet:"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let speciesNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Dog"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let petNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Pet Name:"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let petName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
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
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description:"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    
    
    private let descripe: UILabel = {
        let label = UILabel()
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
    
    private let ownerNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "phone Unkown"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email Unknown"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(postImageView)
        postImageView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 250)
        
        addSubview(speciesLabel)
        speciesLabel.anchor(top: postImageView.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)
        
        addSubview(speciesNameLabel)
        speciesNameLabel.anchor(top: postImageView.bottomAnchor, left: speciesLabel.rightAnchor, paddingTop: 8, paddingLeft: 4)
        
        addSubview(petNameLabel)
        petNameLabel.anchor(top: speciesLabel.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)
        
        addSubview(petName)
        petName.anchor(top: speciesLabel.bottomAnchor, left: petNameLabel.rightAnchor, paddingTop: 8, paddingLeft: 4)
        
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
        
        addSubview(descriptionLabel)
        descriptionLabel.anchor(top: areaLabel.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)
        
        addSubview(descripe)
        descripe.anchor(top: descriptionLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 8)
        
        let nameStack = UIStackView(arrangedSubviews: [contactLabel, ownerNameLabel])
        nameStack.axis  = .horizontal
        nameStack.spacing = 8
        
        addSubview(nameStack)
        nameStack.anchor(top: postImageView.bottomAnchor, right: rightAnchor, paddingTop: 8, paddingRight: 8)
        
        addSubview(phoneLabel)
        phoneLabel.anchor(top: nameStack.bottomAnchor, right: rightAnchor, paddingTop: 8, paddingRight: 20)
        
        addSubview(emailLabel)
        emailLabel.anchor(top: phoneLabel.bottomAnchor, right: rightAnchor, paddingTop: 8, paddingRight: 20)
        
        addSubview(timeLabel)
        timeLabel.anchor(bottom: descripe.topAnchor, right: rightAnchor, paddingBottom: 8, paddingRight: 20)
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    func configure() {
        guard let viewModel = viewModel else {return}
        speciesNameLabel.text = viewModel.species
        ownerNameLabel.text = viewModel.ownerName
        petName.text = viewModel.petname
        breed.text = viewModel.breed
        age.text = viewModel.age
        area.text = viewModel.area
        postImageView.sd_setImage(with: viewModel.petImageUrl)
        phoneLabel.text = viewModel.phone
        emailLabel.text = viewModel.email
        descripe.text = viewModel.description
        timeLabel.text = viewModel.timeStampString
    }
}
