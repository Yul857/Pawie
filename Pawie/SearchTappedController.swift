//
//  SearchTappedController.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/8/21.
//

import UIKit

private let reuseIdentifier = "UserCell"

class SearchTappedController: UITableViewController {
    
    //MARK: - Properties
    
    private var users = [User]()
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredUsers = [User]()
    
    private var inSearchMode: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorColor = .clear
        configureSearchController()
        configureTableView()
        fetchUsers()
    }
    
    //MARK: - API
    
    func fetchUsers() {
        UserService.fetchUsers { users in
            self.users = users
            self.tableView.reloadData()
        }
    }
    
    //MARK: - Helpers
    
    func configureTableView() {
        view.backgroundColor = .white
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        tableView.rowHeight = 64
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = false
    }
}
 //MARK: - UITableViewDataSource
extension SearchTappedController {
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inSearchMode ? filteredUsers.count : users.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        let user = inSearchMode ? filteredUsers[indexPath.row] : users[indexPath.row]
        cell.viewModel = UserCellViewModel(user: user)
        return cell
    }
}

extension SearchTappedController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let user = inSearchMode ? filteredUsers[indexPath.row] : users[indexPath.row]
        let controller = ProfileController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
}


extension SearchTappedController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else {return}
        filteredUsers = users.filter({$0.userName.contains(searchText) || $0.petname.lowercased().contains(searchText)})

        self.tableView.reloadData()
    }
}
