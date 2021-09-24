//
//  EventsTableViewController.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 28/06/21.
//

import UIKit
import SafariServices
import Disk

class EventsTableViewController: UITableViewController, SFSafariViewControllerDelegate {
    
//    MARK:- Properties
    private let eventReportCellID = "EventReportCell"
    private let eventCellID = "EventCell"
    
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
        tableView.backgroundColor = UIColor(named: "defaultBG")
        setupNavigationBar()
        configureTableView()
        getCachedArticles()
    }
    
    
    
    
    
    
    
    
//    MARK:- Helper functions and API
       
    fileprivate func setupNavigationBar(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.grid.3x3")?.withTintColor(.orange, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(infoPressed))
//        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Events"
    }
    
    fileprivate func configureTableView(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "id")
        tableView.register(ArticleCell.self, forCellReuseIdentifier: eventReportCellID)
        tableView.register(EventCell.self, forCellReuseIdentifier: eventCellID)
        tableView.backgroundColor = UIColor(named: "defaultBG")
        view.backgroundColor = UIColor(named: "defaultBG")
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
    }
    
    
    @objc func infoPressed(){
        let vc =  InfoCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func getCachedArticles(){
        do{
            let retrievedArticles = try Disk.retrieve(articlesCache, from: .caches, as: [ArticleModel].self)
            var filteredArticles = [ArticleModel]()
                for i in retrievedArticles{
                    if( i.category == "Event Reports"){
                        filteredArticles.append(i)
                    }
                }
                self.articles = filteredArticles
        }
        catch let error{
            print("Articles cache error in EventController: ", error)
            getArticles()
        }
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
        if UIViewController().isSmalliPhone(){
            headerLabel.font = UIFont.boldSystemFont(ofSize: 20)
        }else{
            headerLabel.font = UIFont.boldSystemFont(ofSize: 24)
        }
        
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
            let cell = tableView.dequeueReusableCell(withIdentifier: eventCellID, for: indexPath) as! EventCell
            cell.selectionStyle = .none
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: eventReportCellID, for: indexPath) as! ArticleCell
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
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
        if indexPath.section == 1{
        openWebView(urlString: url)
        }
    }
    
    private func openWebView(urlString : String){
        
        if let url = URL(string: urlString) {
               let config = SFSafariViewController.Configuration()
               config.entersReaderIfAvailable = true
                
               let vc = SFSafariViewController(url: url, configuration: config)
               vc.delegate = self
               present(vc, animated: true)
        }
//        let vc = ArticleWebViewController()
//        vc.webURL = urlString
//        vc.fromEventReports = true
//        vc.hidesBottomBarWhenPushed = true
//        let nav = MasterNavigationBarController(rootViewController: vc)
//        self.present(nav, animated: true, completion: nil)
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
           return UIView()
       }
    
}
