//
//  ArticleViewController.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 27/06/21.
//

import UIKit
import Alamofire

class ArticleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SearchTagsControllerDelegate {
    
    
//    MARK:-  Properties
    
    var filteredArticles: [ArticleModel]?{
        didSet{
            guard filteredArticles != nil else { return }
//            self.eventsTableView.reloadData(with: .automatic)
            UIView.transition(with: articleTableView,
            duration: 0.3,
            options: .transitionCrossDissolve,
            animations: { self.articleTableView.reloadData() })
        }
    }
    
    var tags: [String] = ["All","Arts &amp; Culture","Campus","Fests","Sitting Down With","National &amp; World","Science and Technology","FAQ","General"]
    
    fileprivate let tagsController = SearchTagsController(collectionViewLayout: UICollectionViewFlowLayout())
    
    private let articleCellID = "ArticleCell"
    
    var articles : [ArticleModel]?{
        didSet{
            DispatchQueue.main.async {
                self.articleTableView.reloadData()
            }
        }
    }
    
    lazy var articleTableView : UITableView = {
       let tableView = UITableView()
        tableView.register(ArticleCell.self, forCellReuseIdentifier: articleCellID)
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInset = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)
        tableView.isUserInteractionEnabled = true
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
       return tableView
    }()
    
    
    
//    MARK: - Helper functions

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "defaultBG")
        articleTableView.backgroundColor = UIColor(named: "defaultBG")
        setupNavigationBar()
        navigationItem.largeTitleDisplayMode = .never
        setupUI()
        getArticles()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)

//        self.articleTableView.deselectRow(at: , animated: true)
    }
    
    func getArticles(){
        
        Networking.sharedInstance.getArticleData(method: HTTPMethods.get.description, dataCompletion: { articleData in
            self.tagsController.view.isHidden = false
            self.filteredArticles = articleData
            self.articles = articleData
        }, errorCompletion: { err in
            print("Error in fetching article/post data", err)
        })
    }
    
    @objc func infoPressed(){
        let vc =  MagazineViewController(collectionViewLayout: UICollectionViewFlowLayout())
        //InfoTableViewController()
//        let nav = UINavigationController(rootViewController: vc)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func didTapTag(indexPath: IndexPath) {
        let tag = tags[indexPath.item]
        if tag == "All"{
            self.filteredArticles = self.articles
            return
        }
        
        
        self.filteredArticles = self.articles?.filter({ article in
            article.category.contains(tag)
        })
    }
    
    
//    MARK:- UI setup
    
    fileprivate func setupNavigationBar(){
//        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Articles"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.grid.3x3")?.withTintColor(.orange, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(infoPressed))
    }
    
    private func setupUI(){
        tagsController.delegate = self
        tagsController.indexValue = 0
        let tagsView = tagsController.view!
//        view.backgroundColor = .clear
//
        view.addSubview(tagsView)
        _ = tagsView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, heightConstant: 50)
        tagsView.isHidden = true

        tagsController.collectionView.selectItem(at: [0, 0], animated: true, scrollPosition: .centeredHorizontally)
        
        view.addSubview(articleTableView)
        _ = articleTableView.anchor(top:tagsView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
        
    }
    
    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArticles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: articleCellID, for: indexPath) as! ArticleCell
        cell.selectionStyle = .none
        cell.articleData = filteredArticles?[indexPath.row] ?? nil
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if filteredArticles?.count == 0{
            return
        }
        guard let url = filteredArticles![indexPath.item].link else {return }
        
        openWebView(urlString: url)
    }
    
    private func openWebView(urlString : String){
        let vc = ArticleWebViewController()
        vc.webURL = urlString
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
     func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
     func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
           return UIView()
       }

}

