//
//  AdoptionController.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/19/21.
//

import UIKit

class AdoptionController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    private let reuseIdentifier = "adoptionCell"
    //MARK: - properties
    private let searchController = UISearchController(searchResultsController: nil)
    private var adoptions = [Adoption]() {
        didSet {
            collectionView.reloadData()
        }
    }
    private var inSearchMode: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    private var filteredAdoptions = [Adoption]()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .white
        cv.register(AdoptionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        return cv
    }()
    
    
    
    //MARK: - LifyCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        view.backgroundColor = .white
        fetchAdoptions()
        configureSearchController()
        
        
        //create a new button
        let button = UIButton(type: .custom)
        //set image for button
        button.setImage(UIImage(named: "plus"), for: .normal)
        //add function for button
        button.addTarget(self, action: #selector(notificationButtonPressed), for: .touchUpInside)
        //set frame
        button.frame = CGRect(x: 0, y: 0, width: 53, height: 51)
        
        let barButton = UIBarButtonItem(customView: button)
        //assign button to navigationbar
        self.navigationItem.rightBarButtonItem = barButton
    }
    //MARK: - Actions

    
    @objc func notificationButtonPressed() {
        let nav = AddAdoptionController()
        self.navigationController?.pushViewController(nav, animated: true)
    }
    
    //MARK: - Helpers
    
    func configure() {
        navigationItem.title = "ADOPTION"
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
    
    func fetchAdoptions() {
        AdoptionService.fetchAdoption { adoptions in
            self.adoptions = adoptions
            self.collectionView.reloadData()
        }
    }
}

//MARK: - UICollectionViewDataSource

extension AdoptionController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return inSearchMode ? filteredAdoptions.count : adoptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AdoptionCell
        let adoption = inSearchMode ? filteredAdoptions[indexPath.row] : adoptions[indexPath.row]
        cell.viewModel =  AdoptionViewModel(adoption: adoption)
        return cell
    }
}

//MARK: -  UICollectionViewDelegateLayout

extension AdoptionController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        var height = width + 8 + 40 + 8
        height += 50
        height += 60
        
        return CGSize(width: width, height: height)
    }
}

//MARK: -  UISearchBarDelegate

extension AdoptionController: UISearchBarDelegate {
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

extension AdoptionController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else {return}
        filteredAdoptions = adoptions.filter({$0.area.contains(searchText) || $0.breed.lowercased().contains(searchText) || $0.description.lowercased().contains(searchText) || $0.petName.lowercased().contains(searchText)})
        self.collectionView.reloadData()
    }
}
