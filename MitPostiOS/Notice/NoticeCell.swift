//
//  NoticeCell.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 16/07/21.
//

import Foundation
import UIKit


class NoticeCell : UITableViewCell{
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: reuseIdentifier)
        
        if UIViewController().isSmalliPhone(){
            textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            detailTextLabel?.font = UIFont.systemFont(ofSize: 15)
        }
        textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        detailTextLabel?.font = UIFont.systemFont(ofSize: 17)
        backgroundColor = .clear
        textLabel?.textColor = UIColor(named: "noticeTitleColor")
        textLabel?.numberOfLines = 0
        detailTextLabel?.numberOfLines = 0
        detailTextLabel?.textColor = .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
