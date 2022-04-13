//
//  UpcomingEvents.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 14/09/21.
//

import Foundation
import UIKit

class EventCell: UITableViewCell{
    
    
    lazy var infolabel: UILabel = {
        let label = UILabel()
        if UIViewController().isSmalliPhone(){
            label.font = UIFont.boldSystemFont(ofSize: 15)
        }else{
            label.font = UIFont.boldSystemFont(ofSize: 17)
        }
//        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.text = "No event information available"
        label.textAlignment = .left
//        label.textColor = .systemGray6
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(infolabel)
        
        infolabel.center(inView: contentView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
