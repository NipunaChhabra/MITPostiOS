//
//  SearchTagsController.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 03/07/21.
//

import UIKit

private let reuseIdentifier = "Cell"

protocol SearchTagsControllerDelegate {
    func didTapTag(indexPath: IndexPath)
}

class SearchTagsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var indexValue:Int?
        
        fileprivate let cellId = "cellId"
        
        var tags: [String] = ["All","Arts & Culture","Campus","Fests","Interviews","National & Global","Science & Technology","FAQ","Miscellaneous"]{
            didSet{
//                collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)
            }
        }
        var specialColor: UIColor?
        
        var delegate: SearchTagsControllerDelegate?
        
        let menuBar: UIView = {
            let v = UIView()
            v.backgroundColor = .white
            return v
        }()
        
        lazy var markerBar: UIView = {
            let v = UIView()
            v.backgroundColor = .black
            v.translatesAutoresizingMaskIntoConstraints = false
            return v
        }()
        
        let shadowBar: UIView = {
            let v = UIView()
            v.backgroundColor = .lightGray
            return v
        }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor =  UIColor(named: "articleCellBG")
            collectionView.backgroundColor = UIColor(named: "articleCellBG")
            collectionView.register(TagCell.self, forCellWithReuseIdentifier: cellId)
            if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal
                layout.minimumLineSpacing = -8
                layout.minimumInteritemSpacing = -8
                
            }
            collectionView.showsHorizontalScrollIndicator = false
         
            
        }
        
        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return  tags.count
        }
    
        override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            collectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
            collectionView.deselectAllItems(animated: false)
            collectionView.reloadData()
            let defaults = UserDefaults.standard
            self.indexValue = defaults.object(forKey: "indexValue") as? Int ?? 0
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TagCell
            if self.indexValue == indexPath.item{
            cell.isSelected = true
            }
//
            defaults.set(indexPath.item, forKey: "indexValue")
            defaults.synchronize()
            delegate?.didTapTag(indexPath: indexPath)
           
        }
        
        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TagCell
            cell.label.text = tags[indexPath.item]
            
            let defaults = UserDefaults.standard
            self.indexValue = defaults.object(forKey: "indexValue") as? Int ?? 0

            if self.indexValue == indexPath.item{
            cell.isSelected = true
            }
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            _ = UIFont.systemFont(ofSize: 16)
            let tag = self.tags[indexPath.item]
            let width: CGFloat!
            width = tag.width(withConstrainedHeight: 35, font: UIFont.systemFont(ofSize: 16, weight: .regular)) + 48
            return .init(width: width, height: 40)
        }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return .init(top: 5, left: 10, bottom: 5, right: 10)
//    }
    
    
    
    }





class TagCell: UICollectionViewCell {
    
    var color: UIColor?{
        didSet {
            if isSelected{
                label.textColor = color
                backgroundCardView.layer.borderColor = color?.cgColor
            }
        }
    }
    let backgroundCardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 151.0/255.0, green: 151.0/255.0, blue: 151.0/255.0, alpha: 0.12)// UIColor(red: 118.0/255.0, green: 118.0/255.0, blue: 128.0/255.0, alpha: 0.12)
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 0.15
        return view
    }()
    
    let label: UILabel = {
        let l = UILabel()
        l.text = "Tag"
        l.textAlignment = .center
        l.textColor = .lightGray
        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return l
    }()
    
    override var isSelected: Bool {
        didSet {
            label.textColor = isSelected ? .white : .lightGray
            if UIViewController().isSmalliPhone(){
                label.font = isSelected ? UIFont.systemFont(ofSize: 12, weight: .medium) : UIFont.systemFont(ofSize: 12, weight: .regular)
            }else{
                label.font = isSelected ? UIFont.systemFont(ofSize: 14, weight: .medium) : UIFont.systemFont(ofSize: 14, weight: .regular)
            }
            backgroundCardView.backgroundColor = isSelected ? UIColor.systemOrange: UIColor(red: 151.0/255.0, green: 151.0/255.0, blue: 151.0/255.0, alpha: 0.12)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backgroundCardView)
       _ = backgroundCardView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0,leftConstant: 8, bottomConstant:0, rightConstant: 8)
        
        backgroundCardView.addSubview(label)
        label.anchorWithConstants(top: backgroundCardView.topAnchor, left: backgroundCardView.leftAnchor, bottom: backgroundCardView.bottomAnchor, right: backgroundCardView.rightAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 8)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

extension String {
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.width)
    }
}


extension UICollectionView {

    func deselectAllItems(animated: Bool) {
        guard let selectedItems = indexPathsForSelectedItems else { return }
        for indexPath in selectedItems { deselectItem(at: indexPath, animated: animated) }
    }
}

