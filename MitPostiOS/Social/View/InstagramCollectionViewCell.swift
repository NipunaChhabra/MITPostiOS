//
//  InstagramCollectionViewCell.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 04/07/21.
//

import Foundation
import UIKit
import SDWebImage

class InstagramCell : UICollectionViewCell{
    
    lazy var instaPostImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 10
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .gray
        iv.clipsToBounds = true
        
        return iv
        }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(instaPostImageView)
        instaPostImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        
    }
    
    func fetchImage(imageURL : URL){
        let getDataTask = URLSession.shared.dataTask(with: imageURL) { data, _, error in
            guard let data = data , error == nil else{
                return
            }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.instaPostImageView.image = image
            }
        }
        
        getDataTask.resume()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
