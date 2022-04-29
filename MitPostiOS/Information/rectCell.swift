//
//  rectCell.swift
//  socialsPage
//
//  Created by Chitrala Dhruv on 03/04/22.
//

import UIKit

class rectCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.contentView.backgroundColor = UIColor(named: "articleCellBG")
        self.addSubview(infoImageView)
        setUpAutoLayout()
        
        
    }
    
    lazy var listNameLabel: UILabel = {
        let label = UILabel()
        label.text = "The Standard"
        if UIViewController().isSmalliPhone(){
            label.font = UIFont.boldSystemFont(ofSize: 15)
        }else{
            label.font = UIFont.boldSystemFont(ofSize: 17)
        }
        label.textAlignment = .center
        return label
    }()
    
    lazy var infoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.setDimensions(width: 36, height: 36)
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
