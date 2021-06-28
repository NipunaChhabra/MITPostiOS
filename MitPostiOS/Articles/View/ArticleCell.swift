//
//  ArticleCell.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 29/06/21.
//

import Foundation
import UIKit


class ArticleCell : UITableViewCell{
    
    lazy var backgroundCard : UIView = {
        let bg = UIView()
        bg.backgroundColor = UIColor(named: "articleCellBG")
        bg.layer.cornerRadius = 10
        bg.layer.borderWidth = 0.4
        bg.layer.borderColor = UIColor.gray.cgColor
//        bg.backgroundColor = UIColor(white: 1, alpha: 1)
//        bg.layer.cornerRadius = 40
        return bg
    }()
    
    
    lazy var postImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = false
        iv.layer.cornerRadius = 10
//        iv.
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .gray
        iv.clipsToBounds = true
        
        return iv
        }()
    
    lazy var postTitleLabel : UILabel = {
        let label = UILabel()
        label.text = "Checking post Title wsdfsdfsdfsdfsjfbsjfhfbdjhbfhjdsbfhjdsbfjdbfd\n sdfsdfsdfsfsdfbbsdfs"
//        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 21)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var authorNameLabel: UILabel = {
        let label  = UILabel()
//        if UIViewController().isSmalliPhone(){
//            label.font = UIFont.systemFont(ofSize: 16)
//        }else{
//            label.font = UIFont.systemFont(ofSize: 20)
        
        label.font = UIFont.italicSystemFont(ofSize: 15)
        label.textColor = .gray
        label.numberOfLines = 1
        label.text = "Rohit Kuber"
        
        label.textAlignment = .left
        return label
    }()
    
    
    lazy var dateLabel: UILabel = {
        let label  = UILabel()
//        if UIViewController().isSmalliPhone(){
//            label.font = UIFont.systemFont(ofSize: 16)
//        }else{
//            label.font = UIFont.systemFont(ofSize: 20)
        
        label.font = UIFont.italicSystemFont(ofSize: 15)
        label.textColor = .gray
        label.numberOfLines = 1
        label.text = "29 June 2021"
        label.textAlignment = .left
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label  = UILabel()
//        if UIViewController().isSmalliPhone(){
//            label.font = UIFont.systemFont(ofSize: 16)
//        }else{
//            label.font = UIFont.systemFont(ofSize: 20)
        
        label.font = UIFont.systemFont(ofSize: 17)
        
        label.numberOfLines = 0
        label.text = "w;kwkerwewer  dfjsdnflsfmlksmfklsmflksmflsmdflsmflksmfklsmf\n adfsdf sdfsdf"
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    fileprivate func setupViews(){
        
        addSubview(backgroundCard)
        
        addSubview(postImageView)
        _ = postImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 10, heightConstant: 200)
        
        addSubview(postTitleLabel)
        _ = postTitleLabel.anchor(top: postImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 10, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        
        let stackView = UIStackView(arrangedSubviews: [authorNameLabel,dateLabel])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        addSubview(stackView)
        _ = stackView.anchor(top: postTitleLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 10, leftConstant: 16, bottomConstant: 0, rightConstant: 16, heightConstant: 16)
        
        addSubview(descriptionLabel)
        _ = descriptionLabel.anchor(top: stackView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 10, leftConstant: 16, bottomConstant: 10, rightConstant: 16)
        
        _ = backgroundCard.anchor(top: postImageView.topAnchor, left: leftAnchor, bottom: descriptionLabel.bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: -8, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
