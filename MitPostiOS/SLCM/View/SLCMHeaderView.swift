//
//  SLCMHeaderView.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 16/09/21.
//

import UIKit

class SLCMHeaderView: UIView {
    
    lazy var namelabel: UILabel = {
        let label = UILabel()
        if UIViewController().isSmalliPhone(){
            label.font = UIFont.boldSystemFont(ofSize: 17)
        }else{
            label.font = UIFont.boldSystemFont(ofSize: 19)
        }
        label.numberOfLines = 0
        label.text = "Rohit Kuber"
        label.textAlignment = .center
        return label
    }()
    
    lazy var separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray2
        return view
    }()
    
    lazy var registrationNumberLabel: UILabel = {
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
    
    lazy var semesterLabel: UILabel = {
        let label = UILabel()
        if UIViewController().isSmalliPhone(){
            label.font = UIFont.boldSystemFont(ofSize: 13)
        }else{
            label.font = UIFont.boldSystemFont(ofSize: 15)
        }
        label.numberOfLines = 1
        label.text = "Semester : VII"
        label.textAlignment = .left
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
        label.text = "Academic Year : 2021-2022"
        label.textAlignment = .left
        return label
    }()
    
    
    
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    
    fileprivate func setupView(){
        
        addSubview(namelabel)
        _ = namelabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 10, rightConstant: 10)
        
        addSubview(separatorLine)
        
        _ = separatorLine.anchor(top: namelabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 4, leftConstant: 10, bottomConstant: 0, rightConstant:10, heightConstant: 1)
        
        
        let vStackView = UIStackView(arrangedSubviews: [registrationNumberLabel,semesterLabel,academicYearLabel])
        vStackView.axis = .vertical
        vStackView.distribution = .fillEqually
        vStackView.spacing = 8
        vStackView.alignment = .leading
        
        addSubview(vStackView)
        _ = vStackView.anchor(top: separatorLine.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 10)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
