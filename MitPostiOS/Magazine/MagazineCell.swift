//
//  MagazineCell.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 13/07/21.
//

import Foundation
import UIKit
import SDWebImage

class MagazineCell : UICollectionViewCell{
    
    var magazineData : MagazineData?{
        didSet{
            configureUI()
        }
    }
    
    
    private let magazineImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.setDimensions(width: 100, height: 100)
        iv.layer.cornerRadius = 13
        iv.backgroundColor = .systemFill
        return iv
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 21)
//        let tap = UITapGestureRecognizer(target: self, action: #selector(handleShowProfile))
//        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        label.clipsToBounds = true
        label.numberOfLines = 1
//        label.backgroundColor = .systemFill
        label.layer.cornerRadius = 5
        label.text = "                         "
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
//        label.textColor = UIColor(named: "statsColor")
        label.clipsToBounds = true
//        label.backgroundColor = .systemFill
        label.layer.cornerRadius = 5
        label.text = "Published on:"
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
//        label.textColor = UIColor(named: "statsColor")
        label.clipsToBounds = true
//        label.backgroundColor = .systemFill
        label.layer.cornerRadius = 5
        label.text = ""
        return label
    }()
    
    
    lazy var separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray2//UIColor(red: 236.0/255.0, green: 236.0/255.0, blue: 236.0/255.0, alpha: 0.8)
        return view
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    fileprivate func setupLayout(){
        addSubview(magazineImageView)
       _ = magazineImageView.anchor(top: topAnchor, left: leftAnchor, topConstant: 10, leftConstant: 10)
        
        addSubview(titleLabel)
        _ = titleLabel.anchor(top: topAnchor, left: magazineImageView.rightAnchor, topConstant: 10, leftConstant: 10)
        
       let stackView = UIStackView(arrangedSubviews: [dateLabel,contentLabel])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        
        addSubview(stackView)
        addSubview(stackView)
        _ = stackView.anchor(top:titleLabel.bottomAnchor, left: magazineImageView.rightAnchor, right: rightAnchor,topConstant: 8, leftConstant: 10,rightConstant: 10)
        
       addSubview(separatorLine)
        _ = separatorLine.anchor(top: nil, left: leftAnchor , bottom: bottomAnchor, right: rightAnchor, topConstant: 0,leftConstant: 10, bottomConstant: 0, rightConstant: 10, heightConstant: 1)
        
        
    }
    
    func configureUI(){
        guard let data = magazineData else {
            return
        }
        
        magazineImageView.sd_setImage(with: URL(string:(data.imageLink) ?? ""), completed: nil)
        titleLabel.text = data.title
        if let date = data.date{
            dateLabel.text = "Published on: " + date
        }
        
        contentLabel.text = data.content
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
