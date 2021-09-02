//
//  LostController.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/28/21.
//

import UIKit

class LostController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    private let reuseIdentifier = "lostCell"
    //MARK: - properties
    private let searchController = UISearchController(searchResultsController: nil)
    private var losts = [Lost]() {
        didSet {
            collectionView.reloadData()
        }
    }
    private var inSearchMode: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    private var filteredLosts = [Lost]()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .white
        cv.register(LostCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        return cv
    }()
    
    
    
    //MARK: - LifyCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.collectionView.reloadData()
        fetchLosts()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        view.backgroundColor = .white
        fetchLosts()
        configureSearchController()
        
        
        //create a new button
        let button = UIButton(type: .custom)
        //set image for button
        button.setImage(UIImage(named: "plus"), for: .normal)
        //add function for button
        button.addTarget(self, action: #selector(addLostPressed), for: .touchUpInside)
        //set frame
        button.frame = CGRect(x: 0, y: 0, width: 53, height: 51)
        
        let barButton = UIBarButtonItem(customView: button)
        //assign button to navigationbar
        self.navigationItem.rightBarButtonItem = barButton
    }
    //MARK: - Actions

    
    @objc func addLostPressed() {
        let nav = AddLostController()
        self.navigationController?.pushViewController(nav, animated: true)
    }
    
    //MARK: - Helpers
    
    func configure() {
        view.addSubview(collectionView)
        collectionView.fillSuperview()
        
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search breed, area code..."
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func fetchLosts() {
        LostService.fetchLosts { losts in
            self.losts = losts
            self.collectionView.reloadData()
        }
            
    }
}

//MARK: - UICollectionViewDataSource

extension LostController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return inSearchMode ? filteredLosts.count : losts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! LostCell
        let lost = inSearchMode ? filteredLosts[indexPath.row] : losts[indexPath.row]
        cell.viewModel =  LostViewModel(lost: lost)
        return cell
    }
}

//MARK: -  UICollectionViewDelegateLayout

extension LostController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        var height = width + 8 + 40 + 8
        height += 50
        height += 60
        
        return CGSize(width: width, height: height)
    }
}

//MARK: -  UISearchBarDelegate

extension LostController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        collectionView.isHidden = false

    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.showsCancelButton = false
        searchBar.text = nil

        collectionView.isHidden = false

    }
}

extension LostController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else {return}
        filteredLosts = losts.filter({$0.area.contains(searchText) || $0.breed.lowercased().contains(searchText) || $0.description.lowercased().contains(searchText) || $0.petName.lowercased().contains(searchText) ||
            $0.species.lowercased().contains(searchText)
        })
        self.collectionView.reloadData()
    }
}
