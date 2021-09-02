//
//  ProfileHeader.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/7/21.
//

import UIKit
import SDWebImage

protocol ProfileHeaderDelegate: class {
    func header(_ profileHeader: ProfileHeader, didTapActionButtonFor user: User)
}

class ProfileHeader: UICollectionReusableView {
    //MARK: - Properties
    var viewModel: ProfileHeaderViewModel? {
        didSet{ configure()}
    }
    
    weak var delegate: ProfileHeaderDelegate?
    
    private let profileImageView: UIImageView =  {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize:24)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let petImage: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "pet-account")
        return iv
    }()
    
    private let ownerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        
        return label
    }()
    
    private let accountImage: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "account")
        return iv
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        
        return label
    }()
    
    
    private lazy var editProfileFollowButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("loading", for: .normal)
        button.layer.cornerRadius = 3
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 0.5
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(handleEditProfileFollowTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var postLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.attributedText = attributedStackText(value: 10, label: "posts")
        return label
    }()
    
    private lazy var followersLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.attributedText = attributedStackText(value: 2, label: "followers")
        return label
    }()
    
    
    private lazy var followingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.attributedText = attributedStackText(value: 2, label: "following")
        return label
    }()
    
//    let pokeButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(#imageLiteral(resourceName: "send2"), for: .normal)
//        button.contentMode = .scaleAspectFit
//        return button
//    }()
    
//    let listButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(#imageLiteral(resourceName: "list"), for: .normal)
//        button.tintColor = UIColor(white: 0, alpha: 0.2)
//        return button
//    }()
//
//    let bookmarkButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
//        button.tintColor = UIColor(white: 0, alpha: 0.2)
//        return button
//    }()
    
    
    //MARK: - LifeCycle
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 16, paddingLeft: 12)
        profileImageView.setDimensions(height: 100, width: 100)
        profileImageView.layer.cornerRadius = 100/2
        
        addSubview(petImage)
        petImage.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 12)
        
        addSubview(nameLabel)
        nameLabel.anchor(top: profileImageView.bottomAnchor, left: petImage.rightAnchor, paddingTop: 12, paddingLeft: 4, width: 150)
        
        
        addSubview(accountImage)
        accountImage.anchor(top: petImage.bottomAnchor, left: leftAnchor, paddingTop: 6, paddingLeft: 12)
        
        addSubview(ownerLabel)
        ownerLabel.anchor(top: petImage.bottomAnchor, left: accountImage.rightAnchor, paddingTop: 6, paddingLeft: 4, width: 150)
        
        addSubview(bioLabel)
        bioLabel.anchor(top: ownerLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 6, paddingLeft: 12, paddingRight: 12)
        
        
        
        
        let stack = UIStackView(arrangedSubviews: [postLabel, followersLabel, followingLabel])
        stack.distribution = .fillEqually
        addSubview(stack)
        stack.centerY(inView: profileImageView)
        stack.anchor(left: profileImageView.rightAnchor, right: rightAnchor, paddingLeft: 12, paddingRight: 12, height: 50)
        
        
        addSubview(editProfileFollowButton)
        editProfileFollowButton.anchor(top: stack.bottomAnchor ,left: ownerLabel.rightAnchor, paddingTop: 30,
                                       paddingLeft: 6, width: 150, height: 40)
        
//        addSubview(pokeButton)
//        pokeButton.anchor(top: stack.bottomAnchor, left: editProfileFollowButton.rightAnchor, right: rightAnchor, paddingTop: 30, paddingLeft: 5, paddingRight: 5, height: 40)
        
        let topDivider = UIView()
        topDivider.backgroundColor = .lightGray
        
        let bottomDevider = UIView()
        bottomDevider.backgroundColor = .lightGray
        
//        let buttonStack = UIStackView(arrangedSubviews: [gridButton, listButton, bookmarkButton])
//        buttonStack.distribution = .fillEqually
//
//
 //       addSubview(topDivider)
 //       addSubview(bottomDevider)
//        addSubview(buttonStack)
//
//        buttonStack.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 50)
//        topDivider.anchor(top: buttonStack.topAnchor, left: leftAnchor, right: rightAnchor, height: 0.5)
//        bottomDevider.anchor(top: bioLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 4, height: 0.5 )
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    @objc func handleEditProfileFollowTapped() {
        guard let viewModel = viewModel else { return }
        delegate?.header(self, didTapActionButtonFor: viewModel.user)
        
    }
    
    //MARK: - Helpers
    
    func configure(){
        guard let viewModel = viewModel else {return}
       
        nameLabel.text = viewModel.petname
        bioLabel.text = viewModel.bio
        ownerLabel.text = "Owner: \(viewModel.ownername)"
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
                
        editProfileFollowButton.setTitle(viewModel.followButtonText, for: .normal)
        editProfileFollowButton.setTitleColor(viewModel.followButtonTextColor, for: .normal)
        editProfileFollowButton.backgroundColor = viewModel.followButtonBackgoundColor
        
        postLabel.attributedText = viewModel.numberOfPosts
        followersLabel.attributedText = viewModel.numberOfFollowers
        followingLabel.attributedText = viewModel.numberOfFollowing
    }
    
    func attributedStackText(value: Int, label: String) -> NSAttributedString{
        let attributedText = NSMutableAttributedString(string: "\(value)\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: label, attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        
        return attributedText
    }
    

}
