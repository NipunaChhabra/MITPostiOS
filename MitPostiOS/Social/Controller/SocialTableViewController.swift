//
//  SocialTableViewController.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 28/06/21.
//

import UIKit
import SafariServices



struct Tweet{
    let tweet: String?
    let tweetLink:String?
    let createdAt:String?
}

struct entities{
    
}

class SocialHeaderView : UIView{
    
    
    lazy var instaButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "instagram"), for: .normal)
        button.imageView?.image = UIImage(named: "instagram")
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.clipsToBounds = true
        button.tag = 2
//        button.layer.cornerRadius = 12
//        button.addTarget(self, action: #selector(handleSocial(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var twitterButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "twitter"), for: .normal)
//        button.startAnimatingPressActions()
        button.tag = 1
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.clipsToBounds = true
//        button.layer.cornerRadius = 12
//        button.addTarget(self, action: #selector(handleSocial(button:)), for: .touchUpInside)
        return button
    }()
    
    
    lazy var facebookButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "facebook"),for: .normal)
       
//        button.startAnimatingPressActions()
        button.tag = 0
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.clipsToBounds = true
//        button.layer.cornerRadius = 12
//        button.addTarget(self, action: #selector(handleSocial(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var linkedInButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "linkedin"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.clipsToBounds = true
//        button.startAnimatingPressActions()
        button.tag = 1
//        button.layer.cornerRadius = 12
//        button.addTarget(self, action: #selector(handleSocial(button:)), for: .touchUpInside)
        return button
    }()
    
    
    lazy var containerView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "articleCellBG")
        let wid = UIViewController().view.frame.width-20
        let dim = (wid-50)/5-10
        print("Button size:",dim)
//        view.backgroundColor = UIColor.darkGray
        view.layer.cornerRadius = 12
        view.isUserInteractionEnabled = true
    
//        let stackView = UIStackView(arrangedSubviews: [instaButton,twitterButton,facebookButton,linkedInButton])
//        stackView.axis = .horizontal
//        stackView.distribution = .fillEqually
//        stackView.spacing = 14
//
//
//        view.addSubview(stackView)
//        _ = stackView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 16, leftConstant: 20, bottomConstant: 16, rightConstant: 20)
        
        let paddingDiff = (wid-(dim*4)-32)/3
 
        view.addSubview(instaButton)
        instaButton.centerY(inView: view, leftAnchor: view.leftAnchor, paddingLeft: 16)
        instaButton.setDimensions(width: dim, height: dim)

        view.addSubview(twitterButton)
        twitterButton.centerY(inView: view, leftAnchor: instaButton.rightAnchor, paddingLeft: paddingDiff)
        twitterButton.setDimensions(width: dim, height: dim)

        view.addSubview(facebookButton)
        facebookButton.centerY(inView: view, leftAnchor: twitterButton.rightAnchor, paddingLeft: paddingDiff)
        facebookButton.setDimensions(width: dim, height: dim)

        view.addSubview(linkedInButton)
        linkedInButton.centerY(inView: view, leftAnchor: facebookButton.rightAnchor, paddingLeft: paddingDiff)
        linkedInButton.setDimensions(width: dim, height: dim)
        
        return view
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "defaultBG")
       addSubview(containerView)
        
        _ = containerView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 10, rightConstant: 10)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SocialTableViewController: UITableViewController{
    
    
//    MARK: -Properties
    
    private let twitterCellId = "TwitterCell"
    private let instagramCellId = "InstagramCell"
    
    var tweets : [Tweet]?{
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
          
        }
    }
    
    var instaVC : InstaFullScreenController!
    
    lazy var followInstaButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemOrange, for: .normal)
//        button.backgroundColor = UIColor(red: 151.0/255.0, green: 151.0/255.0, blue: 151.0/255.0, alpha: 0.2)
        button.widthAnchor.constraint(equalToConstant: 64).isActive = true
//        button.layer.cornerRadius = 13
        button.isUserInteractionEnabled = true
        button.setTitle("Follow", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.addTarget(self, action: #selector(handleInstaFollow), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var followTwitterButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemOrange, for: .normal)
//        button.backgroundColor = UIColor(red: 151.0/255.0, green: 151.0/255.0, blue: 151.0/255.0, alpha: 0.2)
        button.widthAnchor.constraint(equalToConstant: 64).isActive = true
//        button.layer.cornerRadius = 13
        button.isUserInteractionEnabled = true
        button.setTitle("Follow", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
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
       _ = followInstaButton.anchor(top: headerView.topAnchor, left: nil, bottom: nil, right: headerView.rightAnchor, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 8, heightConstant: 28)
        
        
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
       _ = followTwitterButton.anchor(top: headerView.topAnchor, left: nil, bottom: nil, right: headerView.rightAnchor, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 8, heightConstant: 28)
        
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
        let twitter = STTwitterAPI(oAuthConsumerKey: "1sNKbIJ9Tk4pR4lK5oiyLmTNq", consumerSecret: "gu7pGeoxtvq2gzXcrexfd6iZTJG8R0l2zfngTyZsrJQ4DHi0YM", oauthToken: "1308363567389765633-o0JBg7NFzMFIJB3ZEOulmf3LvJr96K", oauthTokenSecret: "BZAOcysWkPtNLmBrLk03aCufasuZF9YlyRwsj68tILoiT")
        
        twitter?.verifyCredentials(userSuccessBlock: { username, userId in
            
            twitter?.getStatusesUserTimeline(forUserID: "", screenName: "themitpost", sinceID: nil, count: "20", maxID: nil, trimUser: nil, excludeReplies: 0, contributorDetails: 0, includeRetweets: 0, useExtendedTweetMode: 1, successBlock: { statuses in

                self.tweets = [Tweet]()
                    for status in statuses! {
                        var tweetText = ""
                        var tweetId = ""
                        var createdAt = ""

                        if let tweet = (status as AnyObject)["full_text"]! as? String
                        {
                         tweetText = tweet
                        }
                        
                        if let tweetID = (status as AnyObject)["id_str"]! as? String
                        {
                            tweetId = tweetID
                        }
                        
                        
//                        if let entity = (status as AnyObject)["entities"]! as? NSDictionary
//                        {
////                            print(entity["media"])
//
//                            if let mediaContainer = (entity as AnyObject)["media"]! as? NSArray{
//                              let mediaDict = (mediaContainer[0] as? NSDictionary)
//
//                                if let url = mediaDict?["display_url"] as? String{
////                                    print(url)
//                                    tweetURL = url
//                                }
//
//                            }
//                        }
                        
                        if let createdDate = (status as AnyObject)["created_at"]! as? String
                        {
                         createdAt = createdDate
                        }
                        
                       let tweetURL = "https://twitter.com/themitpost/status/" + tweetId
                        self.tweets?.append(Tweet(tweet: tweetText, tweetLink: tweetURL, createdAt: createdAt))
                    }
                
               
            }, errorBlock: { error in
                print("Error in fetching tweets",error)
            })
        }, errorBlock: { error in
            print("Error in fetching tweets",error)
        })
        
        
    }
    
    
    //    MARK: - UI Configuration
    
    fileprivate func setupNavigationBar(){
//        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Social Media"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.grid.3x3")?.withTintColor(.orange, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(infoPressed))
    }
    
    
    fileprivate func setupTableView(){
        let height = (UIViewController().view.frame.width/4+10)
        let frame = CGRect(x: 0, y: 88, width: view.frame.width, height: height)
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
        let vc =  InfoCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func handleTwitterFollow(section:Int){
        if let url = URL(string: Networking.sharedInstance.twitterFollowURL) {
               let config = SFSafariViewController.Configuration()
               config.entersReaderIfAvailable = true

               let vc = SFSafariViewController(url: url, configuration: config)
               present(vc, animated: true)
        }
    }
    
    @objc func handleInstaFollow(section:Int){
    
        if let url = URL(string: Networking.sharedInstance.instaFollowURL) {
               let config = SFSafariViewController.Configuration()
               config.entersReaderIfAvailable = true

               let vc = SFSafariViewController(url: url, configuration: config)
               present(vc, animated: true)
        }
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0: //Instagram section
            return 1
        case 1:  //Twitter section
            return tweets?.count ?? 0
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0{
            return 220
        }
        else if indexPath.section == 1{
            return UITableView.automaticDimension
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
            cell.selectionStyle = .none
            cell.tweetlabel.text = tweets?[indexPath.row].tweet
           // print(tweets?[indexPath.row].tweet)
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
        
        if section == 0{
            return .init(45)
        }else{
            return .init(55)
        }
       
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
           return UIView()
       }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1{
            if tweets?.count == 0{
                return
            }
            guard let tweetURL = tweets?[indexPath.row].tweetLink else {return }
            
            if let url = URL(string: tweetURL) {
                   let config = SFSafariViewController.Configuration()

                   let vc = SFSafariViewController(url: url, configuration: config)
                   present(vc, animated: true)
               }
        }
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
            self.navigationController?.setNavigationBarHidden(false, animated: false)

//            self.tabBarController?.tabBar.frame.origin.y = self.view.frame.size.height - 100
//            if let tabBarFrame = self.tabBarController?.tabBar.frame {
//                self.tabBarController?.tabBar.frame..origin.y = self.view.framw.height-80
        } completion: { _ in
            gesture.view?.removeFromSuperview()
            self.instaVC.removeFromParent()
        }
        
        
    }
}
