//
//  InfoCollectionViewCell.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 04/08/21.
//

import Foundation
import UIKit

class InfoCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: UI
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Folder")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
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
    
    lazy var editButton: UIButton = {
        let button = UIButton(type: .custom) as UIButton
        button.setImage(UIImage(named: "Edit"), for: UIControl.State.normal)
        return button
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
    
    lazy var dislosureIndicatorImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.setDimensions(width: 16, height: 16)
        iv.layer.masksToBounds = true
        iv.image = UIImage(systemName: "chevron.forward")?.withTintColor(.orange, renderingMode: .alwaysOriginal)
        iv.clipsToBounds = true
        return iv
    }()
    
    lazy var infoLabel: UILabel = {
        let label  = UILabel()
        if UIViewController().isSmalliPhone(){
            label.font = UIFont.systemFont(ofSize: 13)
        }else{
            label.font = UIFont.systemFont(ofSize: 15)
        }
        
        label.textColor = .gray
        label.numberOfLines = 1
        label.text = "Our very own magazine"
        label.textAlignment = .left
        return label
    }()
    
    // MARK: Setup Cell
    fileprivate func setupCell() {
        roundCorner()
//        gradientBackgroundColor()
//        setCellShadow()
        self.addSubview(infoImageView)
        infoImageView.centerY(inView: contentView, leftAnchor: contentView.leftAnchor, paddingLeft: 10)
//        _ = infoImageView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: nil, topConstant: 1, leftConstant: 10, bottomConstant:0, rightConstant: 0)
        
        self.addSubview(listNameLabel)
        _ = listNameLabel.anchor(top: contentView.topAnchor, left: infoImageView.rightAnchor, bottom:nil, right: nil, topConstant: 20, leftConstant: 10, bottomConstant: 0, rightConstant: 0)
        
        self.addSubview(infoLabel)
        _ = infoLabel.anchor(top: listNameLabel.bottomAnchor, left: infoImageView.rightAnchor, bottom: nil, right: nil, topConstant: 6, leftConstant: 10, bottomConstant: 0, rightConstant: 0)
        
        self.addSubview(dislosureIndicatorImageView)
        dislosureIndicatorImageView.centerY(inView: contentView, rightAnchor: contentView.rightAnchor, paddingRight: 20)
        
        
    }
    
    // MARK: Methods
    func setCellShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 1.0
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 3
        self.clipsToBounds = false
    }
    func cellRandomBackgroundColors() -> [UIColor] {
        //Colors
        let red = [#colorLiteral(red: 0.9654200673, green: 0.1590853035, blue: 0.2688751221, alpha: 1),#colorLiteral(red: 0.7559037805, green: 0.1139892414, blue: 0.1577021778, alpha: 1)]
        let orangeRed = [#colorLiteral(red: 0.9338900447, green: 0.4315618277, blue: 0.2564975619, alpha: 1),#colorLiteral(red: 0.8518816233, green: 0.1738803983, blue: 0.01849062555, alpha: 1)]
        let orange = [#colorLiteral(red: 0.9953531623, green: 0.54947716, blue: 0.1281470656, alpha: 1),#colorLiteral(red: 0.9409626126, green: 0.7209432721, blue: 0.1315650344, alpha: 1)]
        let yellow = [#colorLiteral(red: 0.9409626126, green: 0.7209432721, blue: 0.1315650344, alpha: 1),#colorLiteral(red: 0.8931249976, green: 0.5340107679, blue: 0.08877573162, alpha: 1)]
        let green = [#colorLiteral(red: 0.3796315193, green: 0.7958304286, blue: 0.2592983842, alpha: 1),#colorLiteral(red: 0.2060100436, green: 0.6006633639, blue: 0.09944178909, alpha: 1)]
        let greenBlue = [#colorLiteral(red: 0.2761503458, green: 0.824685812, blue: 0.7065336704, alpha: 1),#colorLiteral(red: 0, green: 0.6422213912, blue: 0.568986237, alpha: 1)]
        let kindaBlue = [#colorLiteral(red: 0.2494148612, green: 0.8105323911, blue: 0.8425348401, alpha: 1),#colorLiteral(red: 0, green: 0.6073564887, blue: 0.7661359906, alpha: 1)]
        let skyBlue = [#colorLiteral(red: 0.3045541644, green: 0.6749247313, blue: 0.9517192245, alpha: 1),#colorLiteral(red: 0.008423916064, green: 0.4699558616, blue: 0.882807076, alpha: 1)]
        let blue = [#colorLiteral(red: 0.1774400771, green: 0.466574192, blue: 0.8732826114, alpha: 1),#colorLiteral(red: 0.00491155684, green: 0.287129879, blue: 0.7411141396, alpha: 1)]
        let bluePurple = [#colorLiteral(red: 0.4613699913, green: 0.3118675947, blue: 0.8906354308, alpha: 1),#colorLiteral(red: 0.3018293083, green: 0.1458326578, blue: 0.7334778905, alpha: 1)]
        let purple = [#colorLiteral(red: 0.7080290914, green: 0.3073516488, blue: 0.8653779626, alpha: 1),#colorLiteral(red: 0.5031493902, green: 0.1100070402, blue: 0.6790940762, alpha: 1)]
        let pink = [#colorLiteral(red: 0.9495453238, green: 0.4185881019, blue: 0.6859942079, alpha: 1),#colorLiteral(red: 0.8123683333, green: 0.1657164991, blue: 0.5003474355, alpha: 1)]
        
        let colorsTable: [Int: [UIColor]] = [0: red, 1: orangeRed, 2: orange, 3: yellow, 4: green, 5: greenBlue, 6: kindaBlue, 7: skyBlue, 8: blue, 9: bluePurple, 10: bluePurple, 11: purple, 12: pink]
        
        let randomColors = colorsTable.values.randomElement()
        return randomColors!
    }
    func gradientBackgroundColor() {
        let colors = cellRandomBackgroundColors()
        self.contentView.setGradientBackgroundColor(colorOne: colors[0], colorTwo: colors[1])
    }
    func roundCorner() {
        self.contentView.layer.cornerRadius = 12.0
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.backgroundColor = UIColor(named: "articleCellBG")
    }
    
}
