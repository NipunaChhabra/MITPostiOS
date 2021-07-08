//
//  NoticesTableViewController.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 28/06/21.
//

import UIKit

class NoticesTableViewController: UITableViewController {

//    MARK: -Properties
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    MARK: - Lifecycle functions

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "defaultBG")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.grid.3x3")?.withTintColor(.orange, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(infoPressed))
        setupNavigationBar()
        configureTableView()
       getNotices()
    }
    
    
    
    
    
    
    
    
//    MARK: -Helper functions and API
    @objc func infoPressed(){
        let vc = InfoTableViewController()
        navigationController?.pushViewController(vc, animated: true)
        print("Do something")
    }
    
    fileprivate func setupNavigationBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Notices"
    }
    
    fileprivate func configureTableView(){
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "id")
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
    }
    
    func getNotices(){
        Networking.sharedInstance.getNoticeData(method: HTTPMethods.get.description) { notice in
            print(notice)
        } errorCompletion: { err in
            print("Error in fetching notices" , err)
        }
    }
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let headerLabel = UILabel()
        headerLabel.font = UIFont.boldSystemFont(ofSize: 25)
//        headerLabel.text = "Recent"
        
        switch section {
        case 0:
            headerLabel.text = "Recent"
            
        case 1:
            headerLabel.text = "Older"
        default:
            headerLabel.text = ""
        }
        
        headerView.addSubview(headerLabel)
        _ = headerLabel.anchor(top: headerView.topAnchor, left: headerView.leftAnchor, bottom: nil, right:nil, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, heightConstant: 30)
        
       return headerView
    }
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return .init(100)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "id", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = .clear
        return cell
    }
    
    
  
 

}
