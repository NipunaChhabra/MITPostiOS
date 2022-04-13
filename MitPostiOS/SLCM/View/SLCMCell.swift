//
//  SLCMCell.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 16/09/21.
//

import Foundation
import UIKit


class SLCMCell: UITableViewCell{
    
    var attendance:SlcmAttendanceData?{
        didSet{
            DispatchQueue.main.async {
                self.configureUI()
            }
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
    
    lazy var courseNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        if UIViewController().isSmalliPhone(){
            label.font = UIFont.boldSystemFont(ofSize: 15)
        }else{
            label.font = UIFont.boldSystemFont(ofSize: 17)
        }
        label.text = "Subject Name"
        label.textAlignment = .center
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    
    lazy var separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray2
        return view
    }()
    
    lazy var subjectCodeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        if UIViewController().isSmalliPhone(){
            label.font = UIFont.boldSystemFont(ofSize: 13)
        }else{
            label.font = UIFont.boldSystemFont(ofSize: 15)
        }
        label.text = "Subject Code"
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    lazy var totalClassesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        if UIViewController().isSmalliPhone(){
            label.font = UIFont.systemFont(ofSize: 13)
        }else{
            label.font = UIFont.systemFont(ofSize: 15)
        }
        label.text = "Total Classes :"
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    lazy var totalValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        if UIViewController().isSmalliPhone(){
            label.font = UIFont.systemFont(ofSize: 13)
        }else{
            label.font = UIFont.systemFont(ofSize: 15)
        }
        label.text = "0"
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    lazy var classesAbsentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        if UIViewController().isSmalliPhone(){
            label.font = UIFont.systemFont(ofSize: 13)
        }else{
            label.font = UIFont.systemFont(ofSize: 15)
        }
        label.text = "Absent Classes :"
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    lazy var absentValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        if UIViewController().isSmalliPhone(){
            label.font = UIFont.systemFont(ofSize: 13)
        }else{
            label.font = UIFont.systemFont(ofSize: 15)
        }
        label.text = "0"
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    
    
    lazy var classesPresentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        if UIViewController().isSmalliPhone(){
            label.font = UIFont.systemFont(ofSize: 13)
        }else{
            label.font = UIFont.systemFont(ofSize: 15)
        }
        label.text = "Present Classes :"
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    lazy var presentValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        if UIViewController().isSmalliPhone(){
            label.font = UIFont.systemFont(ofSize: 13)
        }else{
            label.font = UIFont.systemFont(ofSize: 15)
        }
        label.text = "0"
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    lazy var attendancePercentageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        if UIViewController().isSmalliPhone(){
            label.font = UIFont.boldSystemFont(ofSize: 14)
        }else{
            label.font = UIFont.boldSystemFont(ofSize: 16)
        }
        label.text = "Attendance Percentage : "
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    fileprivate func setupLayout(){
        backgroundColor = .clear
        addSubview(backgroundCard)
        
        addSubview(courseNameLabel)
        addSubview(separatorLine)
        addSubview(subjectCodeLabel)

        
        courseNameLabel.anchorWithConstants(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 28, leftConstant: 20, bottomConstant: 0, rightConstant: 20)
        
        _ = separatorLine.anchor(top: courseNameLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 4, leftConstant: 20, bottomConstant: 0, rightConstant: 20, heightConstant: 1)
        
        _ = subjectCodeLabel.anchor(top: separatorLine.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 4, leftConstant: 20, bottomConstant: 0, rightConstant: 20)
        
        let stackView1 = UIStackView(arrangedSubviews: [totalClassesLabel,totalValueLabel])
        stackView1.axis = .horizontal
        stackView1.distribution = .fill
        
        let stackView2 = UIStackView(arrangedSubviews: [classesAbsentLabel,absentValueLabel])
        stackView2.axis = .horizontal
        stackView2.distribution = .fill
        
        let stackView3 = UIStackView(arrangedSubviews: [classesPresentLabel,presentValueLabel])
        stackView3.axis = .horizontal
        stackView3.distribution = .fill
    
        
//
//        let rightStackView = UIStackView(arrangedSubviews: [classesValueLabel,absentValueLabel,presentValueLabel])
//        rightStackView.axis = .vertical
//        rightStackView.distribution = .fillEqually
//        rightStackView.spacing = 8
//        rightStackView.alignment = .leading
//
//        addSubview(rightStackView)
//
//        _ = rightStackView.anchor(top: subjectCodeLabel.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 30)
      
        
        let vStackView = UIStackView(arrangedSubviews: [stackView1,stackView2,stackView3])
        vStackView.axis = .vertical
        vStackView.distribution = .fill
        vStackView.spacing = 8
//        vStackView.alignment = .leading
        
        addSubview(vStackView)
        _ = vStackView.anchor(top: subjectCodeLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 10, leftConstant: 20, bottomConstant: 0, rightConstant: 20)
        
        addSubview(attendancePercentageLabel)
        
        _ = attendancePercentageLabel.anchor(top: vStackView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 10, leftConstant: 20, bottomConstant: 0, rightConstant: 20)
        
        _ = backgroundCard.anchor(top: courseNameLabel.topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: -10, leftConstant: 10, bottomConstant: -10, rightConstant: 10)
        
    }
    
    private func configureUI(){
       
        guard  let subjectName = attendance?.subject else {return }
        guard let subjectCode = attendance?.subjectCode else{return}
       // print(subjectName)
        courseNameLabel.text = subjectName
        subjectCodeLabel.text = subjectCode
        if  let data = attendance {
//        totalClassesLabel.text   =  "Total Classes   : \(data.totalClass ?? " ")"
//        classesAbsentLabel.text  =  "Absent Classes  : \(data.daysAbsent ?? " ")"
//        classesPresentLabel.text =  "Present Classes : \(data.daysPresent ?? " ")"
            if(data.attendancePercentage == "0.00"){
                attendancePercentageLabel.text = "Attendance not uploaded yet"
                attendancePercentageLabel.textColor = .systemRed
            }else{
                attendancePercentageLabel.text = "Attendance Percentage : \(data.attendancePercentage ?? "Not Available")"
            }
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
