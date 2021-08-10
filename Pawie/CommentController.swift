//
//  CommentController.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/10/21.
//

import UIKit

private let reuseIdentifier = "CommentCell"

class CommentController: UICollectionViewController {
    //MARK: - properties
    private let post: Post
//    private var comments = [Comment]()
//
//    private lazy var commentInputView: CommentInputAccessoryView = {
//        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
//        let cv = CommentInputAccessoryView(frame: frame)
//        cv.delegate = self
//        return cv
//    }()

    
    //MARK: - LifeCycles
    
    init(post: Post){
        self.post = post
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        fetchComments()
    }
    
//    override var inputAccessoryView: UIView? {
//       get {return commentInputView}
//    }
    
    override var canBecomeFirstResponder: Bool{
        return true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    //MARK: - API
    
    func fetchComments() {
//        CommentService.fetchComments(forPost: post.postID) { comments in
//            self.comments = comments
//            self.collectionView.reloadData()
//        }
    }
    //MARK: Helpers
    
    func configureCollectionView() {
        collectionView.backgroundColor = .white
        navigationItem.title = "Comments"
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .interactive
    }
    
    
}
//MARK: - UICollectionViewDataSource
extension CommentController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5     //comments.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CommentCell
//        cell.viewModel = CommentViewModel(comment: comments[indexPath.row])
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension CommentController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let uid = comments[indexPath.row].uid
//        UserService.fetchUser(withUid: uid) { user in
//            let controller = ProfileController(user: user)
//            self.navigationController?.pushViewController(controller, animated: true)
//
//        }
    }
}

//MARK: CollectionViewDelegateFlowLayout
extension CommentController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let viewModel = CommentViewModel(comment: comments[indexPath.row])
//        let height = viewModel.size(forWidth: view.frame.width).height + 32

        return CGSize(width: view.frame.width, height: 80)
    }
}