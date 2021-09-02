//
//  ShopController.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/5/21.
//

import UIKit

private let cellIdentifier = "ShoppingCell"
private let headerIdentifier = "shoppingHeader"


class ShopController: UICollectionViewController{
    //MARK: - properties
    
    private let searchController = UISearchController(searchResultsController: nil)

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Shop for your pets"
        configureCollectionView()
        configureSearchController()
        collectionView.backgroundColor = .white
        
        //create a new button
        let button = UIButton(type: .custom)
        //set image for button
        button.setImage(UIImage(named: "shopping-cart"), for: .normal)
        //add function for button
        button.addTarget(self, action: #selector(checkoutTapped), for: .touchUpInside)
        //set frame
        button.frame = CGRect(x: 0, y: 0, width: 53, height: 51)
        
        let barButton = UIBarButtonItem(customView: button)
        //assign button to navigationbar
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    //MARK: - Actions
    
    @objc func checkoutTapped() {
        print("DEBUG: Lets go check out")
    }

    //MARK: - Helpers

    func configureCollectionView() {
        let alert = UIAlertController(title: "Sorry", message: "All of the items sold out", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        self.present(alert, animated: true)
        collectionView.register(ShoppingCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.register(ShoppingHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: headerIdentifier)
    }

    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }



    //MARK: - collectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ShoppingCell
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! ShoppingHeader

        return header
    }
}

//MARK: - UICollectionViewDelegate
extension ShopController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ShopController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 1) / 2
        return CGSize(width: width, height: width + 50)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 280)
    }
}

//MARK: -  UISearchBarDelegate

extension ShopController: UISearchBarDelegate {
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

extension ShopController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
    }
}
