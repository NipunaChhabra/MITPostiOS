//
//  TwitterCell.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 30/06/21.
//

import Foundation
import UIKit

class TwitterTableViewCell : SocialCell{
    
    lazy var tweetView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "articleCellBG")
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 0.4
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var twitterProfileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.setDimensions(width: 30, height: 30)
        iv.layer.cornerRadius = 30/2
        iv.layer.masksToBounds = true
        iv.image = UIImage(named: "postLogo")
        iv.clipsToBounds = true
//        iv.backgroundColor = .white
//        iv.layer.borderWidth = 0.5
        return iv
    }()
    
    lazy var twitterUsernameLabel: UILabel = {
        let label = UILabel()
        let postLabel = NSMutableAttributedString(string: "The MIT Post ", attributes: [.font: UIFont.boldSystemFont(ofSize: 17)])
        postLabel.append(NSAttributedString(string: "@themitpost", attributes: [.font: UIFont.systemFont(ofSize: 15), .foregroundColor: UIColor.gray]))
        label.attributedText = postLabel
//        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        label.textAlignment = .left
        
         
        return label
    }()
     
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Fri - Jul 02,2021"
        if UIViewController().isSmalliPhone(){
            label.font = UIFont.systemFont(ofSize: 13)
        }else{
            label.font = UIFont.systemFont(ofSize: 15)
        }
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .gray
        return label
    }()
    
    lazy var tweetlabel: UILabel = {
        let label = UILabel()
        if UIViewController().isSmalliPhone(){
            label.font = UIFont.systemFont(ofSize: 13)
        }else{
            label.font = UIFont.systemFont(ofSize: 15)
        }
        label.numberOfLines = 0
        label.text = ""
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "6:43pm"
        if UIViewController().isSmalliPhone(){
            label.font = UIFont.systemFont(ofSize: 13)
        }else{
            label.font = UIFont.systemFont(ofSize: 15)
        }
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .gray
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(){
        addSubview(tweetView)
        
        addSubview(twitterProfileImageView)
        
        _ = twitterProfileImageView.anchor(top: topAnchor, left: tweetView.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0)
        
        addSubview(twitterUsernameLabel)
        
        _ = twitterUsernameLabel.anchor(top: topAnchor, left: twitterProfileImageView.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 14, leftConstant: 8, bottomConstant: 0, rightConstant: 8)
        
        
        addSubview(tweetlabel)
        _ = tweetlabel.anchor(top: twitterProfileImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 10, leftConstant: 20, bottomConstant: 0, rightConstant: 20)
        
        let stackView = UIStackView(arrangedSubviews: [dateLabel,timeLabel])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        addSubview(stackView)
        _ = stackView.anchor(top: tweetlabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 20, rightConstant: 20, heightConstant: 16)
        
        
        _ = tweetView.anchor(top: twitterProfileImageView.topAnchor, left: leftAnchor, bottom: stackView.bottomAnchor, right: rightAnchor, topConstant: -10, leftConstant: 10, bottomConstant: -10, rightConstant: 10)
    
        
    }

}

