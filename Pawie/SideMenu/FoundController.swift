//
//  FoundController.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/28/21.
//

import UIKit

class FoundController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    private let reuseIdentifier = "foundCell"
    //MARK: - properties
    private let searchController = UISearchController(searchResultsController: nil)
    private var founds = [Found]() {
        didSet {
            collectionView.reloadData()
        }
    }
    private var inSearchMode: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    private var filteredFounds = [Found]()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .white
        cv.register(FoundCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        return cv
    }()
    
    
    
    //MARK: - LifyCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.collectionView.reloadData()
        fetchFounds()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        view.backgroundColor = .white
        fetchFounds()
        configureSearchController()
        
        
        //create a new button
        let button = UIButton(type: .custom)
        //set image for button
        button.setImage(UIImage(named: "plus"), for: .normal)
        //add function for button
        button.addTarget(self, action: #selector(addFoundPressed), for: .touchUpInside)
        //set frame
        button.frame = CGRect(x: 0, y: 0, width: 53, height: 51)
        
        let barButton = UIBarButtonItem(customView: button)
        //assign button to navigationbar
        self.navigationItem.rightBarButtonItem = barButton
    }
    //MARK: - Actions

    
    @objc func addFoundPressed() {
        let nav = AddFoundController()
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
    
    func fetchFounds() {
        FoundService.fetchFounds { founds in
            self.founds = founds
            self.collectionView.reloadData()
        }
    }
}

//MARK: - UICollectionViewDataSource

extension FoundController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return inSearchMode ? filteredFounds.count : founds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FoundCell
        let found = inSearchMode ? filteredFounds[indexPath.row] : founds[indexPath.row]
        cell.viewModel =  FoundViewModel(found: found)
        return cell
    }
}

//MARK: -  UICollectionViewDelegateLayout

extension FoundController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        var height = width + 8 + 40 + 8
        height += 50
        height += 60
        
        return CGSize(width: width, height: height)
    }
}

//MARK: -  UISearchBarDelegate

extension FoundController: UISearchBarDelegate {
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

extension FoundController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else {return}
        filteredFounds = founds.filter({$0.area.contains(searchText) || $0.breed.lowercased().contains(searchText) || $0.description.lowercased().contains(searchText) || $0.petName.lowercased().contains(searchText) ||
            $0.species.lowercased().contains(searchText)
        })
        self.collectionView.reloadData()
    }
}
