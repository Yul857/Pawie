//
//  ProfileController.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/5/21.
//

import UIKit
import Firebase

class ProfileController: UICollectionViewController {
    
    private let cellidentifier = "ProfileCell"
    private let headerIdentifirer = "ProfileHeader"
    
    //MARK: - properties
    
    private var user: User
    private var posts = [Post]()
    
    init(user: User){
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        checkIfUserIsFollowed()
        fetchUserStats()
        fetchPosts()
        
        let logOutButton = UIBarButtonItem(image: UIImage(named: "logout"),
                                                           style: .plain, target: self, action: #selector(handleLogOut))
        
        self.navigationItem.rightBarButtonItem = logOutButton
        
        let informationButton = UIBarButtonItem(image: UIImage(named: "information"),
                                                style: .plain, target: self, action: #selector(showInformation))
        
        self.navigationItem.leftBarButtonItem = informationButton
        
        
    }
    
    //MARK: - API
    
    func checkIfUserIsFollowed() {
        UserService.checkIfUserIsFollowed(uid: user.uid) { isFollowed in
            self.user.isFollowed  = isFollowed
            self.collectionView.reloadData()
        }
    }
    
    func fetchUserStats() {
        UserService.fetchUserStats(uid: user.uid) { stats in
            self.user.stats = stats
            self.collectionView.reloadData()
        }
    }
    
    func fetchPosts(){
        PostService.fetchPosts(forUser: user.uid) { posts in
            self.posts = posts
            print("DEBUG: Posts are \(posts)")
            self.collectionView.reloadData()
        }
    }
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
    
    @objc func showInformation() {
        let nav = InformationController()
        navigationController?.pushViewController(nav, animated: true)
    }

    
    //MARK: - Helpers
    
    func configureCollectionView() {
        navigationItem.title = user.userName
        collectionView.backgroundColor = .white
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: cellidentifier)
        collectionView.register(ProfileHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: headerIdentifirer)
    }

    
}

//MARK: - UICollectionViewDataSource
extension ProfileController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellidentifier, for: indexPath) as! ProfileCell
        cell.viewModel = PostViewModel(post: posts[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifirer, for: indexPath) as! ProfileHeader
        header.delegate =  self

        header.viewModel = ProfileHeaderViewModel(user: user)
        return header
    }
    
}


//MARK: - UICollectionViewDelegate
extension ProfileController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = FeedController(collectionViewLayout:  UICollectionViewFlowLayout())
        controller.post = posts[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ProfileController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 240)
    }
}

extension ProfileController: ProfileHeaderDelegate{
    func header(_ profileHeader: ProfileHeader, didTapActionButtonFor user: User) {
        guard let tab = self.tabBarController as? MainTabController else {return}
        guard let currentUser = tab.user else {return}

        if user.isCurrentUser {
            print("DEBUG: SHOW EDIT PROFILE HERE")
        }else if user.isFollowed {
            UserService.unfollow(uid: user.uid) { error in
                self.user.isFollowed = false
                self.collectionView.reloadData()
                PostService.updateUserFeedAfterFollowing(user: user, didFollow: false)
            }
        }else{
            UserService.follow(uid: user.uid) { error in
                self.user.isFollowed = true
                self.collectionView.reloadData()
                NotificationService.uploadNotification(toUid: user.uid, fromUser: currentUser, type: .follow)
                
                PostService.updateUserFeedAfterFollowing(user: user, didFollow: true)
            }
        }
    }
}

