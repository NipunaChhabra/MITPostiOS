//
//  NoticesTableViewController.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 28/06/21.
//

import UIKit
import SafariServices
import Disk

class NoticesTableViewController: UITableViewController {

//    MARK: -Properties
    
    private let noticeCellID = "NoticeCell"
    
    private var selectedIndexpath: IndexPath?
    
    
    var notices : [Notice]?{
        didSet{
            DispatchQueue.main.async {
                UIView.transition(with: self.tableView,
                duration: 0.3,
                options: .transitionCrossDissolve,
                animations: { self.tableView.reloadData() })
            }
        }
    }
    
    
    

    
//    MARK: - Lifecycle functions

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "defaultBG")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.grid.3x3")?.withTintColor(.orange, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(infoPressed))
        setupNavigationBar()
        configureTableView()
        getCachedNotices()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(selectedIndexpath != nil){
            tableView.deselectRow(at: selectedIndexpath!, animated: true)
    }
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
        tableView.register(NoticeCell.self, forCellReuseIdentifier: noticeCellID)
        tableView.tableFooterView = UIView()
        
    }
    
    func getCachedNotices(){
        do{
            let retrievedNotices = try Disk.retrieve(noticesCache, from: .caches, as: [Notice].self)
            self.notices = retrievedNotices
        }
        catch let error{
            print("Notice cache error in NoticeTableViewController: ", error)
            getNotices()
        }
    }
    
    func getNotices(){
        Networking.sharedInstance.getNoticeData(method: HTTPMethods.get.description) { noticeData in
            self.notices = noticeData.reversed()
        } errorCompletion: { err in
            print("Error in fetching notices" , err)
        }
    }
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return (notices?.count ?? 0)
        }
       
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        var textLabel = "N/A"
        var subtitleLabel = "N/A"
        
        guard  let notice = notices?[indexPath.row] else {
            return UITableViewCell()
        }
        textLabel = notice.title ?? " "
        subtitleLabel = notice.content ?? " "
        
        let cell = tableView.dequeueReusableCell(withIdentifier: noticeCellID, for: indexPath) as! NoticeCell
        
        if(notice.pdfLink != "" || notice.imageLink != ""){
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .gray
        }else{
            cell.accessoryType = .none
            cell.selectionStyle = .none
            
        }
        
        cell.textLabel?.text = textLabel
        cell.detailTextLabel?.text = subtitleLabel
        
        cell.backgroundColor = UIColor(named: "articleCellBG")
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let noticeData = notices?[indexPath.row] else {return }
        
        if let pdflink = noticeData.pdfLink{
            if(pdflink != "" && (pdflink.contains("pdf"))){
                let pdfURL = URL(string: pdflink)
                self.selectedIndexpath = indexPath
                self.tableView.isUserInteractionEnabled = false
                openPdf(pdfURL: pdfURL! , pdfTitle: noticeData.title ?? "")
            }else if(pdflink != ""){
                if let url = URL(string: pdflink) {
                       let config = SFSafariViewController.Configuration()
                       config.entersReaderIfAvailable = true

                       let vc = SFSafariViewController(url: url, configuration: config)
                       present(vc, animated: true)
                   }
            }
        }
        
        if let imagelink = noticeData.imageLink{
            if(imagelink != ""){
                let vc = NoticeImageController()
                vc.hidesBottomBarWhenPushed = true
                vc.imageLink = imagelink
                self.selectedIndexpath = indexPath
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
        }
    }
    
    func openPdf(pdfURL: URL, pdfTitle : String){
        let vc = MagazinePDFController()
        vc.pdfTitle = pdfTitle
        vc.hidesBottomBarWhenPushed = true
        FileDownloader.loadFileAsync(url: pdfURL) { pdfLocation, error in
            vc.pdfLink = pdfLocation ?? ""
            DispatchQueue.main.async {
                self.tableView.isUserInteractionEnabled = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
  
 

}
