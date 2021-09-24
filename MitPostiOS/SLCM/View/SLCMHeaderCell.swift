//
//  SLCMHeaderCell.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 22/09/21.
//

import Foundation
import UIKit



class SLCMHeaderCell : UITableViewCell{
    
    
    var slcmData:SlcmData?{
        didSet{
            configureUI()
        }
    }
    
    
    
    lazy var backgroundCard: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "articleCellBG")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.alpha = 0.5
        return view
    }()
    
    lazy var namelabel: UILabel = {
        let label = UILabel()
        if UIViewController().isSmalliPhone(){
            label.font = UIFont.boldSystemFont(ofSize: 15)
        }else{
            label.font = UIFont.boldSystemFont(ofSize: 17)
        }
        label.numberOfLines = 0
        label.text = "Name"
        label.textAlignment = .center
//        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray2
        return view
    }()
    
    lazy var registrationLabel: UILabel = {
        let label = UILabel()
        if UIViewController().isSmalliPhone(){
            label.font = UIFont.boldSystemFont(ofSize: 13)
        }else{
            label.font = UIFont.boldSystemFont(ofSize: 15)
        }
        label.numberOfLines = 0
        label.text = "Registration number : "
        label.textAlignment = .left
        return label
    }()
    
    lazy var registrationNumberLabel: UILabel = {
        let label = UILabel()
        if UIViewController().isSmalliPhone(){
            label.font = UIFont.boldSystemFont(ofSize: 13)
        }else{
            label.font = UIFont.boldSystemFont(ofSize: 15)
        }
        label.numberOfLines = 0
        label.text = "0"
        label.textAlignment = .right
        return label
    }()
    
    lazy var semesterLabel: UILabel = {
        let label = UILabel()
        if UIViewController().isSmalliPhone(){
            label.font = UIFont.boldSystemFont(ofSize: 13)
        }else{
            label.font = UIFont.boldSystemFont(ofSize: 15)
        }
        label.numberOfLines = 1
        label.text = "Semester :"
        label.textAlignment = .left
        return label
    }()
    
    lazy var semesterNumLabel: UILabel = {
        let label = UILabel()
        if UIViewController().isSmalliPhone(){
            label.font = UIFont.boldSystemFont(ofSize: 13)
        }else{
            label.font = UIFont.boldSystemFont(ofSize: 15)
        }
        label.numberOfLines = 1
        label.text = ""
        label.textAlignment = .right
        return label
    }()
    
    lazy var academicYearLabel: UILabel = {
        let label = UILabel()
        if UIViewController().isSmalliPhone(){
            label.font = UIFont.boldSystemFont(ofSize: 13)
        }else{
            label.font = UIFont.boldSystemFont(ofSize: 15)
        }
        label.numberOfLines = 1
        label.text = "Academic Year :"
        label.textAlignment = .left
        return label
    }()
    
    lazy var yearLabel: UILabel = {
        let label = UILabel()
        if UIViewController().isSmalliPhone(){
            label.font = UIFont.boldSystemFont(ofSize: 13)
        }else{
            label.font = UIFont.boldSystemFont(ofSize: 15)
        }
        label.numberOfLines = 1
        label.text = "2021-2022"
        label.textAlignment = .right
        return label
    }()
    
    lazy var refreshLabel: UILabel = {
        let label  = UILabel()
      if UIViewController().isSmalliPhone(){
        label.font = UIFont.italicSystemFont(ofSize: 13)
    }else{
        label.font = UIFont.italicSystemFont(ofSize: 15)
    }
        label.textColor = .gray
        label.numberOfLines = 1
        label.text = "To refresh attendance, logout and log back in"
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    
    fileprivate func setupView(){
        backgroundColor = .clear
        addSubview(backgroundCard)
        
        addSubview(namelabel)
        _ = namelabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 10, leftConstant: 20, bottomConstant: 10, rightConstant: 20)
        
        addSubview(separatorLine)
        
        _ = separatorLine.anchor(top: namelabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 4, leftConstant: 20, bottomConstant: 0, rightConstant:20, heightConstant: 1)
        
        
        let stackView1 = UIStackView(arrangedSubviews: [registrationLabel,registrationNumberLabel])
        stackView1.axis = .horizontal
        stackView1.distribution = .fill
        
        
        let stackView2 = UIStackView(arrangedSubviews: [semesterLabel,semesterNumLabel])
        stackView2.axis = .horizontal
        stackView2.distribution = .fill
        
        let stackView3 = UIStackView(arrangedSubviews: [academicYearLabel,yearLabel])
        stackView3.axis = .horizontal
        stackView3.distribution = .fill
        
        
        let vStackView = UIStackView(arrangedSubviews: [stackView1,stackView2,stackView3])
        vStackView.axis = .vertical
        vStackView.distribution = .fill
        vStackView.spacing = 8
//        vStackView.alignment = .leading
        
        addSubview(vStackView)
        _ = vStackView.anchor(top: separatorLine.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 10, leftConstant: 20, bottomConstant: 0, rightConstant: 20)
        
        addSubview(refreshLabel)
        _ = refreshLabel.anchor(top: vStackView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 10, leftConstant: 20, bottomConstant: 0, rightConstant: 20)
        
        
        _ = backgroundCard.anchor(top: namelabel.topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: -10, leftConstant: 10, bottomConstant: -10, rightConstant: 10)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configureUI(){
        guard let data = slcmData else { return }
        namelabel.text = data.name
        registrationNumberLabel.text = data.registration
    }
    
    
    
    
  
}
