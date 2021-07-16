//
//  EventsTableViewController.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 28/06/21.
//

import UIKit

class EventsTableViewController: UITableViewController {
    
//    MARK:- Properties
    private let articleCellID = "ArticleCell"
    
    var articles : [ArticleModel]?{
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
 
    
//    MARK:- Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "defaultBG")
        setupNavigationBar()
        configureTableView()
        getArticles()
    }
    
    
    
    
    
    
    
    
//    MARK:- Helper functions and API
       
    fileprivate func setupNavigationBar(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.grid.3x3")?.withTintColor(.orange, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(infoPressed))
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Events"
    }
    
    fileprivate func configureTableView(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "id")
        tableView.register(ArticleCell.self, forCellReuseIdentifier: articleCellID)
        tableView.backgroundColor = UIColor(named: "defaultBG")
        view.backgroundColor = UIColor(named: "defaultBG")
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
    }
    
    
    @objc func infoPressed(){
        print("Do something")
        let vc = InfoTableViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func getArticles(){
        var filteredArticles = [ArticleModel]()
        Networking.sharedInstance.getArticleData(method: HTTPMethods.get.description, dataCompletion: { articleData in
            for i in articleData{
                if( i.category == "Event Reports"){
                    filteredArticles.append(i)
                }
            }
            self.articles = filteredArticles
        }, errorCompletion: { err in
            print("Error in fetching article/post data", err)
        })
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
        
        
        switch section {
        case 0:
            headerLabel.text = "Upcoming Events"
            
        case 1:
            headerLabel.text = "Event Reports"
        default:
            headerLabel.text = ""
        }
        
        headerView.addSubview(headerLabel)
        _ = headerLabel.anchor(top: headerView.topAnchor, left: headerView.leftAnchor, bottom: nil, right:nil, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, heightConstant: 30)
        
       return headerView
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
            
        case 1:
            return articles?.count ?? 0
            
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0){
            return 280
        }else{
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "id", for: indexPath)
            cell.selectionStyle = .none
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: articleCellID, for: indexPath) as! ArticleCell
            cell.selectionStyle = .none
            cell.articleData = articles?[indexPath.row]
            return cell
         
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if articles?.count == 0{
            return
        }
        guard let url = articles![indexPath.item].link else {return }
        openWebView(urlString: url)
    }
    
    private func openWebView(urlString : String){
        let vc = ArticleWebViewController()
        vc.webURL = urlString
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
           return UIView()
       }
    
}
