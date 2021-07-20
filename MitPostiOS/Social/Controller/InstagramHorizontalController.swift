//
//  InstagramHorizontalController.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 30/06/21.
//

import UIKit

private let instaReuseIdentifier = "InstagramCell"

protocol InstaFullScreenDelegate {
    func makeInstagramFS(cell : UICollectionViewCell, indexPath :IndexPath, instaPostData : Instagram)
}

class InstagramHorizontalController: UICollectionViewController , UICollectionViewDelegateFlowLayout {
    
    
//    MARK:- Properties
    
    var instagramData : [Instagram]?{
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    var instaDelegate: InstaFullScreenDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        getInstaData()
    }
    
    func getInstaData(){
        Networking.sharedInstance.getInstagramData(method: HTTPMethods.get.description) { instaData in
//            print(instaData)
            self.instagramData = instaData
        } errorCompletion: { err in
            print("Error in fetching Instagram Data", err)
        }

    }
    
    
    func configureCollectionView() {
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.backgroundColor = UIColor(named: "defaultBG")
        collectionView.register(InstagramCell.self, forCellWithReuseIdentifier: instaReuseIdentifier)
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout{
            layout.scrollDirection = .horizontal
        }
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return instagramData?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: instaReuseIdentifier, for: indexPath) as! InstagramCell
        cell.layer.cornerRadius = 10
        if let imageURL = instagramData?[indexPath.item].imageUrl{
        cell.instaPostImageView.sd_setImage(with: URL(string: imageURL), completed: nil)
            }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if instagramData?.count == 0{
            return
        }
        guard let instaData = instagramData?[indexPath.item] else {return }
        
        guard let cell = collectionView.cellForItem(at: indexPath)  else {return }
        self.instaDelegate?.makeInstagramFS(cell: cell, indexPath: indexPath, instaPostData: instaData)
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout

   
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 10
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return .init(width: 180, height: 200)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return .init(top: 0, left: 10, bottom: 0, right: 10)
        }
    }


