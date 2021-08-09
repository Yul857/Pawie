//
//  MainTabController.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/5/21.
//

import UIKit
import Firebase


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
        UserService.fetchUser { user in
            self.user = user
        }
    }
    
    
    //MARK: - Helpers
    func configureViewControllers(withUser user: User) {
        view.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        let feed = templateNavigationViewController(unseletedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: FeedController(collectionViewLayout: layout))
                                                    
        let search = templateNavigationViewController(unseletedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"), rootViewController: SearchTappedController())
        
        let image = templateNavigationViewController(unseletedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"), rootViewController: ImageController())
        
        let shop = templateNavigationViewController(unseletedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"), rootViewController: ShopController())
        
        let profileController = ProfileController(user: user)
        let profile = templateNavigationViewController(unseletedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected"), rootViewController: profileController)
                                                    
        
        viewControllers = [feed, search, image, shop, profile]
        
        tabBar.tintColor = .black
        
        
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
