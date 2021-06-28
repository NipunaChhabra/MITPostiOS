//
//  ArticleViewController.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 27/06/21.
//

import UIKit

class ArticleViewController: UITableViewController {
    
    private let articleCellID = "ArticleCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor(named: "defaultBG")
        setupNavigationBar()
        setupTableView()
       
        // Do any additional setup after loading the view.
    }
    
    @objc func infoPressed(){
        let vc = InfoTableViewController()
        navigationController?.pushViewController(vc, animated: true)
        print(123)
    }
    
    
    
    fileprivate func setupNavigationBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Articles"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle")?.withTintColor(.orange, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(infoPressed))
    }
    
    private func setupTableView(){
        tableView.register(ArticleCell.self, forCellReuseIdentifier: articleCellID)
        tableView.tableFooterView = UIView()
//        tableView.contentInset = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)
        tableView.isUserInteractionEnabled = true
        tableView.separatorStyle = .none
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: articleCellID, for: indexPath) as! ArticleCell
        cell.backgroundColor = .clear
//        cell.layer.cornerRadius = 2
//        cell.layer.borderWidth = 1
//        cell.layer.borderColor = UIColor.black.cgColor
        return cell
    }
    
    
    

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



}

