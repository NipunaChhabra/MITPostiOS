//
//  InstagramTableViewCell.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 30/06/21.
//

import Foundation
import UIKit

class InstagramTableViewCell : UITableViewCell{
    
    
    var horizontalController = InstagramHorizontalController()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(named: "defaultBG")
        contentView.addSubview(horizontalController.view)
        let horizontalView = horizontalController.view!
        _ = horizontalView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor,  topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
       
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
