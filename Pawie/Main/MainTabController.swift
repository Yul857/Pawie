//
//  MainTabController.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/5/21.
//

import UIKit
import Firebase
import YPImagePicker


class MainTabController: UITabBarController {
    
    var user: User? {
        didSet{
            guard let user = user else {return}
            configureViewControllers(withUser: user)}
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkedIfUserIsLoggedIn()
        fetchUser()
    }
    
    //MARK: - API
    func checkedIfUserIsLoggedIn() {
        //Check if the user is logged in or not. If the user is logged in, then stay in mainTabController
        if Auth.auth().currentUser == nil{
            DispatchQueue.main.async {
                let controller = LoginController()
                controller.delegate = self
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        }
        
    }
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        UserService.fetchUser(withUid: uid) { user in
            self.user = user
        }
    }
    
    
    //MARK: - Helpers
    func configureViewControllers(withUser user: User) {
        view.backgroundColor = .white
        self.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        let feed = templateNavigationViewController(unseletedImage: #imageLiteral(resourceName: "home-icon"), selectedImage: #imageLiteral(resourceName: "home-icon-tapped"), rootViewController: FeedController(collectionViewLayout: layout))
                                                    
        let search = templateNavigationViewController(unseletedImage: #imageLiteral(resourceName: "search-icon"), selectedImage: #imageLiteral(resourceName: "search-icon-Tapped"), rootViewController: SearchTappedController())
        
        let image = templateNavigationViewController(unseletedImage: #imageLiteral(resourceName: "add-post"), selectedImage: #imageLiteral(resourceName: "add-post"), rootViewController: ImageController())
        
        let shop = templateNavigationViewController(unseletedImage: #imageLiteral(resourceName: "shop-icon"), selectedImage: #imageLiteral(resourceName: "shop-icon-tapped"), rootViewController: ShopController(collectionViewLayout: layout))
        
        let profileController = ProfileController(user: user)
        let profile = templateNavigationViewController(unseletedImage: #imageLiteral(resourceName: "dog-paw"), selectedImage: #imageLiteral(resourceName: "dog-paw-pressed"), rootViewController: profileController)
                                                    
        
        viewControllers = [feed, search, image, shop, profile]
        
        tabBar.tintColor = .black
    }
    
    func didFinishPickingMedia(_ picker: YPImagePicker) {
        picker.didFinishPicking { items, _ in
            picker.dismiss(animated: true){
                guard let selectedImage = items.singlePhoto?.image else { return }
                let controller = UploadPostController()
                controller.selectedImage = selectedImage
                controller.delegate = self
                controller.currentuser = self.user
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: false, completion: nil)
            }
        }
        
        
    }
    
    
    
    func templateNavigationViewController(unseletedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController{
        
        let nav = UINavigationController(rootViewController: rootViewController)
        
        nav.tabBarItem.image = unseletedImage
        
        nav.tabBarItem.selectedImage = selectedImage
        
        nav.navigationBar.tintColor = .black
        
        return nav
    }
}

//MARK: - AuthenticationDelegate

extension MainTabController: AuthenticationDelegate{
    func authenticationDidComplete() {
        fetchUser()
        self.dismiss(animated: false, completion: nil)
    }
}

extension MainTabController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.firstIndex(of: viewController)
        if index == 2{
            var config = YPImagePickerConfiguration()
            config.library.mediaType = .photo
            config.shouldSaveNewPicturesToAlbum = false
            config.startOnScreen = .library
            config.screens = [.library, .photo]
            config.hidesStatusBar = false
            config.library.maxNumberOfItems = 1
            config.showsCrop = .rectangle(ratio: 1)
            
            let picker = YPImagePicker(configuration: config)
            picker.modalPresentationStyle = .fullScreen
            present(picker, animated: true, completion: nil)
            
            didFinishPickingMedia(picker)
        }
        return true
    }
}

//MARK: - UploadPostControllerDelegate
extension MainTabController: UploadPostControllerDelegate{
    func controllerDidFinishUploadingPost(_ controller: UploadPostController) {
        selectedIndex = 0
        controller.dismiss(animated: true, completion: nil)
        
        guard let feedNav = viewControllers?.first as? UINavigationController else {return}
        guard let feed = feedNav.viewControllers.first as? FeedController else {return}
        feed.handleRefresh()
    }
    
    
}

