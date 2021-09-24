//
//  ArticleCell.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 29/06/21.
//

import Foundation
import UIKit
import SDWebImage


class ArticleCell : UITableViewCell{
    
    var articleData: ArticleModel?{
        didSet{
            configureUI()
        }
    }
    
    lazy var backgroundCard : UIView = {
        let bg = UIView()
        bg.backgroundColor = UIColor(named: "articleCellBG")
        bg.layer.cornerRadius = 10
        bg.layer.borderWidth = 0.4
        bg.layer.borderColor = UIColor.systemGray2.cgColor
//        bg.backgroundColor = UIColor(white: 1, alpha: 1)
//        bg.layer.cornerRadius = 40
        return bg
    }()  
    
    
    lazy var postImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 10
//        iv.
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .gray
        
        
        return iv
        }()
    
    lazy var postTitleLabel : UILabel = {
        let label = UILabel()
        label.text = "Post Title"
//        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 21)
        
        if UIViewController().isSmalliPhone(){
            label.font = UIFont.boldSystemFont(ofSize: 18)
        }else{
            label.font = UIFont.boldSystemFont(ofSize: 21)
        }
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var authorNameLabel: UILabel = {
        let label  = UILabel()
      if UIViewController().isSmalliPhone(){
        label.font = UIFont.italicSystemFont(ofSize: 13)
    }else{
        label.font = UIFont.italicSystemFont(ofSize: 15)
    }
        label.textColor = .gray
        label.numberOfLines = 1
        label.text = "Rohit Kuber"
        
        label.textAlignment = .left
        return label
    }()
    
    
    lazy var dateLabel: UILabel = {
        let label  = UILabel()
        if UIViewController().isSmalliPhone(){
            label.font = UIFont.italicSystemFont(ofSize: 13)
        }else{
            label.font = UIFont.italicSystemFont(ofSize: 15)
        }
        
        label.textColor = .gray
        label.numberOfLines = 1
        label.text = ""
        label.textAlignment = .left
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label  = UILabel()
        if UIViewController().isSmalliPhone(){
            label.font = UIFont.systemFont(ofSize: 15)
        }else{
            label.font = UIFont.systemFont(ofSize: 17)
        }
        label.numberOfLines = 0
        label.text = ""
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
        _ = postTitleLabel.anchor(top: postImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 10, leftConstant: 20, bottomConstant: 0, rightConstant: 20)
        
        let stackView = UIStackView(arrangedSubviews: [authorNameLabel,dateLabel])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        addSubview(stackView)
        _ = stackView.anchor(top: postTitleLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 10, leftConstant: 20, bottomConstant: 0, rightConstant: 20, heightConstant: 16)
        
        addSubview(descriptionLabel)
        _ = descriptionLabel.anchor(top: stackView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 10, leftConstant: 20, bottomConstant: 10, rightConstant: 20)
        
        _ = backgroundCard.anchor(top: postImageView.topAnchor, left: leftAnchor, bottom: descriptionLabel.bottomAnchor, right: rightAnchor, topConstant: -0, leftConstant: 10, bottomConstant: -8, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
    }
    
    func configureUI(){
        guard let article = articleData else {
            return
        }
        
        postImageView.sd_setImage(with: URL(string: article.featured_media!), completed: nil)
        
        postTitleLabel.text = article.title
        authorNameLabel.text = article.author?.name
        descriptionLabel.text = article.message
        let dateData = article.date
        let day =  (dateData?.day) ?? ""
        let month = (dateData?.month) ?? ""
        let year =  (dateData?.year) ?? ""
        
        let date = day + " " + month + " " + year
        
        dateLabel.text = date
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
