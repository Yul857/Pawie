//
//  FeedController.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/5/21.
//

import UIKit
import Firebase


class FeedController: UICollectionViewController{
    
    private let reuseIdentifier = "feedCell"
    //MARK: - properties
    
    private var posts = [Post]() {
        didSet {collectionView.reloadData()}
    }
    var post: Post?
    
    
    //MARK: - LifyCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        fetchPosts()
        
        //create a new button
        let button = UIButton(type: .custom)
        //set image for button
        button.setImage(UIImage(named: "bell"), for: .normal)
        //add function for button
        button.addTarget(self, action: #selector(notificationButtonPressed), for: .touchUpInside)
        //set frame
        button.frame = CGRect(x: 0, y: 0, width: 53, height: 51)
        
        let barButton = UIBarButtonItem(customView: button)
        //assign button to navigationbar
        self.navigationItem.rightBarButtonItem = barButton
    }
    //MARK: - Actions
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
    
    @objc func handleRefresh() {
        posts.removeAll()
        fetchPosts()
    }
    
    @objc func notificationButtonPressed() {
        let controller = NotificationController()
        navigationController?.pushViewController(controller, animated: false)
    }
    
    //MARK: - API
    func fetchPosts() {
        guard post == nil else {return}
//        PostService.fetchPosts { posts in
//            self.posts = posts
//            self.collectionView.refreshControl?.endRefreshing()
//            self.checkIfUserLikedPosts()
//        }
        
        PostService.fetchFeedPosts { posts in
            self.posts = posts
            self.collectionView.refreshControl?.endRefreshing()
            self.checkIfUserLikedPosts()
        }
    }
    
        func checkIfUserLikedPosts() {
            self.posts.forEach { post in
                PostService.checkIfUserLikedPost(post: post){ didlike in
                    if let index = self.posts.firstIndex(where: {$0.postID == post.postID}){
                        self.posts[index].didLike = didlike
                    }
    
    
                }
            }
        }
    
    //MARK: - Helpers
    
    func configure() {
        collectionView.backgroundColor = .white
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        if post == nil{
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out",
                                                               style: .plain, target: self,
                                                               action: #selector(handleLogOut))
        }
        navigationItem.title = "PAWIE"
        
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView.refreshControl = refresher
    }
}

//MARK: - UICollectionViewDataSource

extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return post == nil ? posts.count : 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
        cell.delegate = self
        if let post = post {
            cell.viewModel = PostViewModel(post: post)
        }else{
            cell.viewModel = PostViewModel(post: posts[indexPath.row])
        }
        return cell
    }
}

//MARK: -  UICollectionViewDelegateLayout

extension FeedController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        var height = width + 8 + 40 + 8
        height += 50
        height += 60
        
        return CGSize(width: width, height: height)
    }
}

extension FeedController: FeedCellDelegate{
    func cell(_ cell: FeedCell, wantsToShowProfileFor uid: String) {
        UserService.fetchUser(withUid: uid) { user in
            let controller = ProfileController(user: user)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func cell(_ cell: FeedCell, wantsToShowCommentsForPost post: Post) {
        let controller = CommentController(post: post)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func cell(_ cell: FeedCell, didLike post: Post) {
        guard let tab = self.tabBarController as? MainTabController else {return}
        guard let user = tab.user else {return}
        
        cell.viewModel?.post.didLike.toggle()
        if post.didLike {
            print("DEBUG: Unlike post here")
            PostService.unlikePost(post: post) { _ in
                cell.likeButton.setImage(#imageLiteral(resourceName: "like_unselected"), for: .normal)
                cell.likeButton.tintColor = .black
                cell.viewModel?.post.likes = post.likes - 1
            }
        }else{
            print("DEBUG: like post here")
            PostService.likePost(post: post) { _ in
                cell.likeButton.setImage(#imageLiteral(resourceName: "like_selected"), for: .normal)
                cell.likeButton.tintColor = .red
                cell.viewModel?.post.likes = post.likes + 1
                
                NotificationService.uploadNotification(toUid: post.ownerUid, fromUser: user, type: .like, post: post)
            }
        }
    }
    
    
}
