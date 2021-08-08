//
//  ProfileCell.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/7/21.
//

import UIKit

class ProfileCell: UICollectionViewCell{
    //MARK: - Properties
    private let postImageView: UIImageView =  {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "venom-7")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        return iv
    }()
    
    //MARK: - LifrCycle
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        backgroundColor = .lightGray
        
        addSubview(postImageView)
        postImageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        
        
    }
}

