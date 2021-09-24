//
//  InstagramTableViewCell.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 30/06/21.
//

import Foundation
import UIKit
import SafariServices

protocol InstaViewDelegate: AnyObject{
    func makeInstaFS(cell : UICollectionViewCell, indexPath: IndexPath, instaPostData : Instagram)
}


class SocialCell: UITableViewCell{
    
   
}

class InstagramTableViewCell :UITableViewCell{
    
    var instaDelegate: InstaViewDelegate?
    var horizontalController = InstagramHorizontalController()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(named: "defaultBG")
        contentView.addSubview(horizontalController.view)
        horizontalController.instaDelegate = self
        let horizontalView = horizontalController.view!
        _ = horizontalView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor,  topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
       
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InstagramTableViewCell: InstaFullScreenDelegate{
    func makeInstagramFS(cell: UICollectionViewCell, indexPath: IndexPath, instaPostData: Instagram) {
        self.instaDelegate?.makeInstaFS(cell: cell, indexPath: indexPath, instaPostData: instaPostData)
    }
    
    
}

class InstaCaptionCell : UITableViewCell{
    
    var instaPostData : Instagram?{
        didSet{
            configureUI()
        }
    }
    
    lazy var backgroundCard : UIView = {
        let bg = UIView()
        bg.backgroundColor = .clear // UIColor(named: "articleCellBG")
//        bg.layer.cornerRadius = 10
//        bg.layer.borderWidth = 0.4
//        bg.layer.borderColor = UIColor.gray.cgColor
//        bg.backgroundColor = UIColor(white: 1, alpha: 1)
//        bg.layer.cornerRadius = 40
        return bg
    }()
    
    lazy var instaCaptionLabel : UILabel = {
        let label = UILabel()
        label.text = "Post Data not loading"
//        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var postedOnLabel : UILabel = {
        let label = UILabel()
        label.text = "Posted on:"
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var followButton: LoadingButton = {
        let button = LoadingButton(type: .system)
        button.backgroundColor = UIColor.systemOrange
        button.setTitle("View on Instagram", for: UIControl.State())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: UIControl.State())
        if UIViewController().isSmalliPhone(){
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        }else{
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        }
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(followClicked), for: .touchUpInside)
        return button
    }()
    
    @objc func followClicked(){
        guard let instaURL = instaPostData?.link else {return}
        let webURL = NSURL(string: instaURL)!
        let application = UIApplication.shared
        application.open(webURL as URL)
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(backgroundCard)
        
        addSubview(instaCaptionLabel)
        _ = instaCaptionLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 0, rightConstant: 20)
        
        addSubview(postedOnLabel)
        _ = postedOnLabel.anchor(top:instaCaptionLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 0, rightConstant: 20)
        
        addSubview(followButton)
        _ = followButton.anchor(top: postedOnLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 20, rightConstant: 20, heightConstant: 40)
//
        
        _ = backgroundCard.anchor(top: instaCaptionLabel.topAnchor, left: leftAnchor, bottom: followButton.bottomAnchor, right: rightAnchor, topConstant: -10, leftConstant: 10, bottomConstant: -8, rightConstant: 10)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureUI(){
        guard let label = instaPostData?.caption else {return }
        self.instaCaptionLabel.text = label
        guard  let dateLabel = instaPostData?.date else {
            return
        }
        self.postedOnLabel.text = "Posted on : " + dateLabel
    }
}
