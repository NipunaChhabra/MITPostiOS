//
//  InstaFullScreenController.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 20/07/21.
//

import UIKit
import SDWebImage

class InstaFullScreenController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.dataSource = self
        tv.delegate = self
        tv.showsVerticalScrollIndicator = false
        return tv
    }()
    
    var instaPostData : Instagram?{
        didSet{
            self.tableView.reloadData()
        }
    }
    
    var instaHeader: InstaHeader?
    var instaHeaderHeight: CGFloat = 280.0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "defaultBG")
        view.addSubview(tableView)
        tableView.fillSuperview()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 280)
        instaHeader = InstaHeader(frame: frame)
        tableView.addSubview(instaHeader!)
        tableView.contentInset = UIEdgeInsets(top: instaHeaderHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -instaHeaderHeight - 8)
        tableView.tableFooterView = UIView()
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .bottom, animated: true)
        
        if let imageURL = instaPostData?.imageUrl{
                instaHeader?.headerImageView.sd_setImage(with: URL(string: imageURL), completed: nil)
            }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(tableView.contentOffset.y)
        var headerRect = CGRect(x: 0, y: -instaHeaderHeight, width: tableView.bounds.width, height: instaHeaderHeight)
        if tableView.contentOffset.y < -instaHeaderHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y
         }
        var offset = (tableView.contentOffset.y + 120) / 30
        if offset < 0{
            offset = 0
        }
        
//        if offset > 1{
//            offset = 1
//            navigationView.alpha = offset
//            titleLabel.alpha = offset
//        }else{
//            navigationView.alpha = 0
//            titleLabel.alpha = 0
//        }
        instaHeader?.headerImageView.alpha = 1 - offset
//        homeHeader?.gradient.frame = headerRect
        instaHeader?.frame = headerRect
//        homeHeader?.gradient.frame.size.height = headerRect.size.height
        instaHeader?.layoutIfNeeded()
    }
        
    

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
//
//         Configure the cell...

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return .init(100)
    }
    

  


}


class InstaHeader: UIView, UIGestureRecognizerDelegate{
    
    // MARK: - Properties
    
    lazy var headerImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .red
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "placeholder")
        return iv
    }()
    
    
    let gradient: CAGradientLayer = CAGradientLayer()
    let gradientMaskLayer = CAGradientLayer()
    let view = UIView()
    
    override func layoutSubviews() {
        gradientMaskLayer.frame = .init(x: 0, y: 0, width: bounds.width, height: view.bounds.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let titleLabel = UILabel()
        titleLabel.text = "The MIT Post"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel.textColor = .white
        titleLabel.sizeToFit()
        
        let subTitleLabel = UILabel()
        subTitleLabel.text = ""
        subTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        subTitleLabel.textColor = .white
        subTitleLabel.sizeToFit()
        
        addSubview(headerImageView)
        headerImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        
        view.backgroundColor = .clear
        
        gradientMaskLayer.colors = [UIColor.clear.cgColor,UIColor.init(white: 0, alpha: 0.7).cgColor, UIColor.black.cgColor]
        gradientMaskLayer.locations = [0,1]
//        gradientMaskLayer.locations = [0, 1]
        
        view.layer.addSublayer(gradientMaskLayer)
        headerImageView.addSubview(view)
        
        
        headerImageView.addSubview(subTitleLabel)
        subTitleLabel.anchorWithConstants(top: nil, left: headerImageView.leftAnchor, bottom: headerImageView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 16, bottomConstant: 16, rightConstant: 16)
        
        headerImageView.addSubview(titleLabel)
        titleLabel.anchorWithConstants(top: nil, left: headerImageView.leftAnchor, bottom: subTitleLabel.topAnchor, right: nil, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        
        view.anchorWithConstants(top: titleLabel.topAnchor, left: headerImageView.leftAnchor, bottom: headerImageView.bottomAnchor, right: headerImageView.rightAnchor, topConstant: -48, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
        
        
    }
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
