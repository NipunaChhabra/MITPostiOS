//
//  SocialTableViewController.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 28/06/21.
//

import UIKit

class SocialHeaderView : UIView{
    
    lazy var facebookButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "play.rectangle.fill")?.withTintColor(UIColor(named: "defaultBG") ?? .clear, renderingMode: .alwaysOriginal), for: .normal)
        if UIViewController().isSmalliPhone(){
            button.imageEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        }else{
            button.imageEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        }
//        button.backgroundColor = .white
//        button.startAnimatingPressActions()
        button.tag = 0
//        button.addTarget(self, action: #selector(handleSocial(button:)), for: .touchUpInside)
        button.layer.cornerRadius = 12
        return button
    }()
    
    lazy var instaButton : UIButton = {
        let button = UIButton()
//        button.setImage(UIImage(named: "youtube"), for: .normal)
        if UIViewController().isSmalliPhone(){
            button.imageEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        }else{
            button.imageEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        }
        button.backgroundColor = .white
//        button.startAnimatingPressActions()
        button.tag = 2
//        button.addTarget(self, action: #selector(handleSocial(button:)), for: .touchUpInside)
        button.layer.cornerRadius = 12
        return button
    }()
    
    lazy var twitterButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "twitter"), for: .normal)
        if UIViewController().isSmalliPhone(){
            button.imageEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        }else{
            button.imageEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        }
        button.backgroundColor = .white
//        button.startAnimatingPressActions()
        button.tag = 1
//        button.addTarget(self, action: #selector(handleSocial(button:)), for: .touchUpInside)
        button.layer.cornerRadius = 12
        return button
    }()
    
    lazy var linkedInButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bird"), for: .normal)
        if UIViewController().isSmalliPhone(){
            button.imageEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        }else{
            button.imageEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        }
        button.backgroundColor = .white
//        button.startAnimatingPressActions()
        button.tag = 1
//        button.addTarget(self, action: #selector(handleSocial(button:)), for: .touchUpInside)
        button.layer.cornerRadius = 12
        return button
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let stackView = UIStackView(arrangedSubviews: [instaButton,twitterButton,facebookButton,linkedInButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        
        addSubview(stackView)
        _ = stackView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 10, heightConstant: UIViewController().view.frame.width/4)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SocialTableViewController: UITableViewController{
    
    
//    MARK: -Properties
    
    private let twitterCellId = "TwitterCell"
    private let instagramCellId = "InstagramCell"
    
    var instaVC : InstaFullScreenController!
    
    lazy var followInstaButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemOrange, for: .normal)
//        button.backgroundColor = UIColor(red: 151.0/255.0, green: 151.0/255.0, blue: 151.0/255.0, alpha: 0.2)
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.layer.cornerRadius = 13
        button.isUserInteractionEnabled = true
        button.setTitle("FOLLOW", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.addTarget(self, action: #selector(handleInstaFollow), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var followTwitterButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemOrange, for: .normal)
//        button.backgroundColor = UIColor(red: 151.0/255.0, green: 151.0/255.0, blue: 151.0/255.0, alpha: 0.2)
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.layer.cornerRadius = 13
        button.isUserInteractionEnabled = true
        button.setTitle("FOLLOW", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.addTarget(self, action: #selector(handleTwitterFollow), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var instaHeaderView : UIView = {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        headerView.isUserInteractionEnabled = true
        let headerLabel = UILabel()
        headerLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
        headerLabel.text = "Instagram Posts"

        headerView.addSubview(followInstaButton)
       _ = followInstaButton.anchor(top: headerView.topAnchor, left: nil, bottom: nil, right: headerView.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, heightConstant: 28)
        
        
        headerView.addSubview(headerLabel)
        _ = headerLabel.anchor(top: headerView.topAnchor, left: headerView.leftAnchor, bottom: nil, right:nil, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, heightConstant: 30)
        
        
        return headerView
    }()
    
    lazy var twitterHeaderView : UIView = {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        let headerLabel = UILabel()
        headerLabel.font = UIFont.boldSystemFont(ofSize: 24)
        headerLabel.text = "Twitter Timeline"
        headerView.isUserInteractionEnabled = true
        
        headerView.addSubview(followTwitterButton)
       _ = followTwitterButton.anchor(top: headerView.topAnchor, left: nil, bottom: nil, right: headerView.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, heightConstant: 28)
        
        headerView.addSubview(headerLabel)
        _ = headerLabel.anchor(top: headerView.topAnchor, left: headerView.leftAnchor, bottom: nil, right:nil, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, heightConstant: 30)
        return headerView
    }()
    
    
    var startingFrame: CGRect?
    
    
    

    //    MARK: -Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "defaultBG")
        setupNavigationBar()
        setupTableView()
    }
    
    
    //    MARK: - UI Configuration
    
    fileprivate func setupNavigationBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Social Media"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.grid.3x3")?.withTintColor(.orange, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(infoPressed))
    }
    
    
    fileprivate func setupTableView(){
        let frame = CGRect(x: 0, y: 88, width: view.frame.width, height: 180)
        let headerView = SocialHeaderView(frame: frame)
//        headerView.backgroundColor = .white
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "id")
        //Cells
        tableView.register(TwitterTableViewCell.self, forCellReuseIdentifier: twitterCellId)
        tableView.register(InstagramTableViewCell.self, forCellReuseIdentifier: instagramCellId)
        tableView.backgroundColor = UIColor(named: "defaultBG")
        view.backgroundColor = UIColor(named: "defaultBG")
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
    }
    
    // MARK: - Helper/Objective c functions

    @objc func infoPressed(){
        print("Do something")
        let vc = InfoTableViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func handleTwitterFollow(section:Int){
        print("Twitter")
        
    }
    
    @objc func handleInstaFollow(section:Int){
        print("Insta")
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0: //Instagram section
            return 1
        case 1:  //Twitter section
            return 6
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0{
            return 220
        }
        else{
            return UITableView.automaticDimension
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: instagramCellId, for: indexPath) as! InstagramTableViewCell
            cell.instaDelegate = self
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: twitterCellId, for: indexPath) as! TwitterTableViewCell
            cell.backgroundColor = .clear
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView:UIView!
        
        switch section{
        case 0:
            headerView = instaHeaderView

        case 1:
            headerView = twitterHeaderView

        default :
            headerView = UIView()
        }
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .init(45)
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
           return UIView()
       }
    
    

}


extension SocialTableViewController :  InstaViewDelegate {
    
    func makeInstaFS(cell: UICollectionViewCell, indexPath: IndexPath , instaPostData : Instagram) {
        let instaVC = InstaFullScreenController()
        instaVC.hidesBottomBarWhenPushed = true
        instaVC.instaPostData = instaPostData
    
        let instaView = instaVC.view!
        
        
        instaView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(removeInstaVC)))
        
        self.tableView.addSubview(instaView)
        
        addChild(instaVC)
        
        self.instaVC = instaVC
       
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else {return }
        
        self.startingFrame = startingFrame
        instaView.frame = startingFrame
        instaView.layer.cornerRadius = 10
     
     
         UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut) {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            instaView.frame = self.view.frame
            self.tabBarController?.tabBar.frame.origin.y = self.view.frame.height+100
            self.tableView.isScrollEnabled = false

//            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
         } completion: { b in
             //Do nothing
         }
    }
    
    
    @objc func removeInstaVC(gesture : UITapGestureRecognizer){
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut) {
            gesture.view?.frame = self.startingFrame ?? .zero
            self.tabBarController?.tabBar.frame.origin.y -= 100
            self.tableView.isScrollEnabled = true

//            self.tabBarController?.tabBar.frame.origin.y = self.view.frame.size.height - 100
            if let tabBarFrame = self.tabBarController?.tabBar.frame {
//                self.tabBarController?.tabBar.frame..origin.y = self.view.framw.height-80
                
               }
        } completion: { _ in
            gesture.view?.removeFromSuperview()
            self.instaVC.removeFromParent()
        }
        
        
    }
}
