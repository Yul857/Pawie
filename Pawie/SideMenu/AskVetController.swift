//
//  AskVetController.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/19/21.
//

import UIKit

class AskVetController: UIViewController{
    //MARK: - properties
    private let tableView = UITableView()
    private let vetPhoto: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "vet-photo")
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - configureUI
    func configureUI() {
        view.backgroundColor = .systemPink
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        tableView.rowHeight = 64
        
        view.addSubview(vetPhoto)
        vetPhoto.fillSuperview()
        
        view.addSubview(tableView)
        tableView.fillSuperview()
        tableView.backgroundColor = UIColor.clear
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none

    }
}

//MARK: - UITableViewDataSource
extension AskVetController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "Consult with DR BU"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

//MARK: - UITableViewDelegate
extension AskVetController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = VetChatViewController()
        vc.title = "Chat"
        navigationController?.pushViewController(vc, animated: true)
    }
}
