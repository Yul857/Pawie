//
//  UserCell.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/8/21.
//

import UIKit
//import SDWebImage


class UserCell: UITableViewCell {
    //MARK: Properties
    
    var viewModel: UserCellViewModel? {
        didSet{ configure()}
        }

    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    private let usernamelabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Venom"
        return label
    }()
    
    private let petnamelabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Eddie Brock"
        label.textColor = .lightGray
        return label
    }()
    
    //MARK: LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        addSubview(profileImageView)
        profileImageView.setDimensions(height: 48, width: 48)
        profileImageView.layer.cornerRadius = 48 / 2
        profileImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        
        
        let stackView = UIStackView(arrangedSubviews: [usernamelabel, petnamelabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .leading
        
        addSubview(stackView)
        stackView.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Helpers
    
    func configure() {
        guard let viewModel = viewModel else {return}
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        usernamelabel.text = viewModel.username
        petnamelabel.text = viewModel.petname
    }
}
