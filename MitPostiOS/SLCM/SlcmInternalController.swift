//
//  SlcmInternalController.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 24/07/21.
//

import UIKit
import Disk

class SlcmInternalController: UITableViewController {
    
//    MARK:-Properties
    private let slcmCellID = "SLCMCell"
    private let slcmHeaderCell = "SLCMHeader"
    
    var slcmController : SLCMViewController?
    
    var slcmData:SlcmData?{
        didSet{
            guard let dAttendance = self.slcmData?.attendance else{return }
           
            self.slcmData?.attendance = self.unique(source: dAttendance)
            self.slcmData?.attendance?.removeFirst()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //Function to remove the duplicate values
    func unique<S : Sequence, T : Hashable>(source: S) -> [T] where S.Iterator.Element == T {
        var buffer = [T]()
        var added = Set<T>()
        for elem in source {
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
        }
        return buffer
    }

    
    
    
    
    
    
    
    
    
    
    
//MARK:- Lifecycle functions

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.setNavigationBarHidden(false, animated: false)
        do{
            let retrievedData = try Disk.retrieve(slcmCache, from: .caches, as: SlcmData.self)
            self.slcmData = retrievedData
        }
        catch let error{
            print("Slcm cache error in SlcmInternalController: ", error)
//            getArticles()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "defaultBG")
        setupNavigationBar()
        setupTableView()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    

    
    
//    MARK: -Setting up UI
    
    fileprivate func setupNavigationBar(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "lock.open")?.withTintColor(.orange, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(logoutPressed))

    }
    
    fileprivate func setupTableView(){
//        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 120)
//        let headerView = SLCMHeaderView(frame: frame)
//        headerView.namelabel.text = slcmData?.name
//        headerView.registrationNumberLabel.text = slcmData?.registration
//        headerView.academicYearLabel.text = slcmData?.attendance?[1].year
        tableView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        tableView.register(SLCMCell.self, forCellReuseIdentifier: slcmCellID)
        tableView.register(SLCMHeaderCell.self, forCellReuseIdentifier: slcmHeaderCell)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
    }
    
    
    
    
//    MARK:-Helper functions and API
    
    
    @objc func logoutPressed(){
        slcmController?.handleLogout()
    }
    
    func setupViewForLoggedOutUser(){
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
        return slcmData?.attendance?.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.section == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: slcmHeaderCell, for: indexPath) as! SLCMHeaderCell
            if let data = slcmData{
                cell.namelabel.text = data.name
                cell.registrationNumberLabel.text = data.registration
                cell.yearLabel.text = slcmData?.attendance?[1].year
                cell.semesterNumLabel.text = slcmData?.attendance?[1].semester
            }
            return cell
        }else{
        let cell = tableView.dequeueReusableCell(withIdentifier: slcmCellID, for: indexPath) as! SLCMCell
        cell.selectionStyle = .none
        if let atData = slcmData?.attendance{
            cell.attendance = atData[indexPath.row]
        }
            return cell
    }
}

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
           return UIView()
       }
    

}
