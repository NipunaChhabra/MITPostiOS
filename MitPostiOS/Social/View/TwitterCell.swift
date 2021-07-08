//
//  TwitterCell.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 30/06/21.
//

import Foundation
import UIKit

class TwitterTableViewCell : UITableViewCell{
    
    lazy var tweetView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "articleCellBG")
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 0.4
        view.layer.cornerRadius = 10
        return view
    }()
     
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Wed - May 26,2021"
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .gray
        return label
    }()
    
    lazy var tweetlabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.text = "Checkingg wowornwjrenwnr/nskdfnsdfnksfn\n sdnfksdfnskdfndskf \n jadshfkjadfsdfnklsd"
        label.textAlignment = .left
//        label.adjustsFontSizeToFitWidth = true
//        label.minimumScaleFactor = 0.2
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "11:41pm"
        label.font = UIFont.systemFont(ofSize: 15)
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
        
        
        addSubview(tweetlabel)
        _ = tweetlabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 16, leftConstant: 20, bottomConstant: 0, rightConstant: 20)
        
        let stackView = UIStackView(arrangedSubviews: [dateLabel,timeLabel])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        addSubview(stackView)
        _ = stackView.anchor(top: tweetlabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 20, rightConstant: 20, heightConstant: 16)
        
        
        _ = tweetView.anchor(top: tweetlabel.topAnchor, left: leftAnchor, bottom: stackView.bottomAnchor, right: rightAnchor, topConstant: -10, leftConstant: 10, bottomConstant: -16, rightConstant: 10)
    
        
    }

}

