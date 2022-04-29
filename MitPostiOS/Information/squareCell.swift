//
//  squareCell.swift
//  socialsPage
//
//  Created by Chitrala Dhruv on 03/04/22.
//

import UIKit

class squareCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.contentView.backgroundColor = UIColor(named: "articleCellBG")
        self.addSubview(infoImageView)
        self.addSubview(listNameLabel)
        setUpAutoLayout()
    }
    
    
    lazy var listNameLabel: UILabel = {
        let label = UILabel()
        label.text = "The Standard"
        label.textColor = .black
        label.textAlignment = .left
        if UIViewController().isSmalliPhone(){
            label.font = UIFont.boldSystemFont(ofSize: 13)
        }else{
            label.font = UIFont.boldSystemFont(ofSize: 15)
        }
        label.numberOfLines = 0
        return label
    }()
    
    lazy var infoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.setDimensions(width: 28, height: 28)
        iv.layer.cornerRadius = 36/2
        iv.layer.masksToBounds = true
        iv.image = UIImage(named: "postLogo")
        iv.clipsToBounds = true
//        iv.backgroundColor = .white
//        iv.layer.borderWidth = 0.5
        return iv
    }()
    
    private func setUpAutoLayout() {
        roundCorner()
        infoImageView.translatesAutoresizingMaskIntoConstraints = false
        infoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        infoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        
        listNameLabel.translatesAutoresizingMaskIntoConstraints = false
        listNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        listNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6).isActive = true
        listNameLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func roundCorner() {
        self.contentView.layer.cornerRadius = 12
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.black.cgColor
    }
}
