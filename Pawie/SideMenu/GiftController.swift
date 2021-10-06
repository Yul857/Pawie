//
//  GiftController.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/19/21.
//

import UIKit
import Firebase

class GiftController: UIViewController{
    //MARK: - properties
    private let defaults = UserDefaults.standard
    private var points = [Point]()
    private let giftButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "giftbox"), for: .normal)
        button.addTarget(self, action: #selector(giftTapped), for: .touchUpInside)
        return button
    }()
    
    private let pointOneLabel: UILabel = {
        let label = UILabel()
        label.text = "You have"
        label.font = UIFont.boldSystemFont(ofSize: 32)
        return label
    }()
    
    private let pointLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 32)
        return label
    }()
    
    private let pointTwoLabel: UILabel = {
        let label = UILabel()
        label.text = "Pawie Points"
        label.font = UIFont.boldSystemFont(ofSize: 32)
        return label
    }()
    
    
    //MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchPoints()
        let savedDate =  defaults.value(forKey: "LastRun")  as? Date ?? Date()
        if savedDate.timeIntervalSinceNow < -86400 {
            defaults.set(false, forKey: "points")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let buttonTapped = defaults.bool(forKey: "points")
        if buttonTapped {
            giftButton.isEnabled = false
        }else{
            giftButton.isEnabled = true
        }
        configureUI()
        fetchPoints()
    }
    
    //MARK: - Helpers
    
    private func fetchPoints() {
        PointService.fetchPoints { points in
            self.points = points
            self.pointLabel.text = String(points.count)
        }
    }
    private func configureUI() {
        
        let pointStack = UIStackView(arrangedSubviews: [pointOneLabel, pointLabel, pointTwoLabel])
        pointStack.axis = .horizontal
        pointStack.spacing = 6
        view.addSubview(pointStack)
        pointStack.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 80)
        
        view.addSubview(giftButton)
        giftButton.centerX(inView: view, topAnchor: pointStack.bottomAnchor, paddingTop: 150)
    }
    
    @objc func giftTapped() {
        defaults.set(true, forKey: "points")
        giftButton.isEnabled = false
        defaults.setValue(Date(), forKey: "LastRun")
        let alert = UIAlertController(title: "Congratulations", message: "You just win 1 Pawie Point", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Great", style: .default, handler: nil))
        self.present(alert, animated: true)
        let credentials = PointCredentials(points: 1, time: Timestamp())
        PointService.addPoints(with: credentials) { error in
            if let error = error {
                print("DEBUG: there is a problem uploading points \(error.localizedDescription)")
            }
        }
    }
}


