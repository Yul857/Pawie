//
//  FeedCell.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/6/21.
//

import UIKit
import SDWebImage

protocol FeedCellDelegate: class {
    func cell(_ cell: FeedCell, wantsToShowCommentsForPost: Post)
//    func cell(_ cell: FeedCell, didLike post: Post)
//    func cell(_ cell: FeedCell, wantsToShowProfileFor uid: String)
}


class FeedCell: UICollectionViewCell{
    //MARK: - LifeCycle
    
    var viewModel: PostViewModel? {
        didSet { configure() }
    }
    weak var delegate: FeedCellDelegate?
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.image = #imageLiteral(resourceName: "venom-7")
        
        let tab = UITapGestureRecognizer(target: self, action: #selector(showUserProfile))
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(tab)
        return iv
    }()
    
    private lazy var usernameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.addTarget(self, action: #selector(showUserProfile), for: .touchUpInside)
        button.setTitle("bobo Siamese Cat", for: .normal)
        
        return button
    }()
    
    private let postImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "like_unselected"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        return button
    }()
    
    private lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "comment"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(didTapComment), for: .touchUpInside)
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "send2"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let likeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.text = "2 comments"
        return label
    }()
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private let postTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "2 days ago"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()
    
    
    
    //MARK: - Properties
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 12)
        profileImageView.setDimensions(height: 40, width: 40)
        profileImageView.layer.cornerRadius = 40 / 2
        
        addSubview(usernameButton)
        usernameButton.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
        
        addSubview(postImageView)
        postImageView.anchor(top: usernameButton.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 8)
        postImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        
        addSubview(likeButton)
        likeButton.anchor(top: postImageView.bottomAnchor, left: leftAnchor, paddingLeft: 8, height: 50)

        addSubview(likeLabel)
        likeLabel.anchor(top: postImageView.bottomAnchor, left: likeButton.rightAnchor, paddingLeft: 8, height: 50)

        addSubview(commentButton)
        commentButton.anchor(top: postImageView.bottomAnchor, left: likeLabel.rightAnchor, paddingLeft: 55, height: 50)

        addSubview(commentLabel)
        commentLabel.anchor(top: postImageView.bottomAnchor, left: commentButton.rightAnchor, paddingLeft: 8, height: 50)

        addSubview(shareButton)
        shareButton.anchor(top: postImageView.bottomAnchor, right: rightAnchor, paddingRight: 20, height: 50)
       
        
//        let feedStack = UIStackView(arrangedSubviews: [likeStack, commentStack, shareButton])
//        feedStack.distribution = .fillEqually
//        feedStack.axis = .horizontal
//        addSubview(feedStack)
//        feedStack.anchor(top: postImageView.bottomAnchor, left: leftAnchor, right: rightAnchor, height: 50)
        
        let divider = UIView()
        divider.backgroundColor = .lightGray
        addSubview(divider )
        divider.anchor(top: likeButton.bottomAnchor, left: leftAnchor, right: rightAnchor, height: 0.5)
        
        addSubview(captionLabel)
        captionLabel.anchor(top: divider.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)
        
        addSubview(postTimeLabel)
        postTimeLabel.anchor(top: captionLabel.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func showUserProfile(){
    }
    
    @objc func didTapComment() {
        guard let viewModel = viewModel else {return}
        delegate?.cell(self, wantsToShowCommentsForPost: viewModel.post)
    }
    @objc func didTapLike() {
    }
    
    //MARK: - Helpers
    
    func configure() {
        guard let viewModel = viewModel else {return}
        captionLabel.text = viewModel.caption
        postImageView.sd_setImage(with: viewModel.imageUrl)
        profileImageView.sd_setImage(with: viewModel.userProfileImageUrl)
        usernameButton.setTitle(viewModel.username, for: .normal)
        
        likeLabel.text = viewModel.likesLabelText
//        likeButton.tintColor = viewModel.likeButtonTintColor
//        likeButton.setImage(viewModel.likeButtonImage, for: .normal)
    }
}

