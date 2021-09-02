//
//  InformationController.swift
//  Pawie
//
//  Created by Yu Ming Lin on 9/1/21.
//

import UIKit

class InformationController: UIViewController {
    //MARK: - properties
    let iconlabel: UILabel = {
        let label = UILabel()
        label.text = "All of the icons are from 'ICONS8'"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let iconUrl: UIButton = {
        let button = UIButton()
        button.setTitle("Tap me to go to 'ICON8' website", for: .normal)
        button.addTarget(self, action: #selector(goToIconWebsite), for: .touchUpInside)
        button.backgroundColor = .systemGray
        return button
    }()
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "The vet image is photo by \n Sam Lion from Pexels"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    let headerUrl: UIButton = {
        let button = UIButton()
        button.setTitle("Tap me to go to 'Pexels' website", for: .normal)
        button.addTarget(self, action: #selector(goToVetWebsite), for: .touchUpInside)
        button.backgroundColor = .systemGray
        return button
    }()
    
    let appIconLabel: UILabel = {
        let label = UILabel()
        label.text = "The app icon and lauchScreen \n is designed using Canva"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    let AppIconUrl: UIButton = {
        let button = UIButton()
        button.setTitle("Tap me to go to 'Canva' website", for: .normal)
        button.addTarget(self, action: #selector(goToCanva), for: .touchUpInside)
        button.backgroundColor = .systemGray
        return button
    }()
    
    
    
    //MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    private func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "information"
        
        view.addSubview(iconlabel)
        iconlabel.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 30)
        
        view.addSubview(iconUrl)
        iconUrl.centerX(inView: view, topAnchor: iconlabel.bottomAnchor, paddingTop: 20)
        
        view.addSubview(headerLabel)
        headerLabel.centerX(inView: view, topAnchor: iconUrl.bottomAnchor, paddingTop: 30)
        
        view.addSubview(headerUrl)
        headerUrl.centerX(inView: view, topAnchor: headerLabel.bottomAnchor, paddingTop: 20)
        
        view.addSubview(appIconLabel)
        appIconLabel.centerX(inView: view, topAnchor: headerUrl.bottomAnchor, paddingTop: 30)
        
        view.addSubview(AppIconUrl)
        AppIconUrl.centerX(inView: view, topAnchor: appIconLabel.bottomAnchor, paddingTop: 20)
    }
    
    //MARK: - helpers
    @objc func goToIconWebsite() {
        if let url = URL(string: "https://icons8.com/license") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc func goToVetWebsite() {
        if let url = URL(string: "https://www.pexels.com/photo/yorkshire-terrier-in-physician-robe-with-stethoscope-on-light-background-5733422/") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc func goToCanva() {
        if let url = URL(string: "https://www.canva.com") {
            UIApplication.shared.open(url)
        }
    }
}
