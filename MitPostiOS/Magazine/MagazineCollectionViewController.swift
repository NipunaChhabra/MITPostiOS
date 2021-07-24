//
//  MagazineCollectionViewController.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 13/07/21.
//

import UIKit
import WebKit
import PDFKit
import Disk




class MagazineViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
//    MARK:-Properties
    private let magazineCellID = "MagazineCell"
    
    var magazines: [MagazineData]?{
        didSet{
            UIView.transition(with: collectionView,
            duration: 0.3,
            options: .transitionCrossDissolve,
            animations: { self.collectionView.reloadData() })
        }
    }
    
    
// MARK:- Lifecycle functions
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        configureCollectionView()
        getCachedMagazines()
    }
    
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
//MARK:- UI Setup
    
  fileprivate func configureCollectionView(){
    collectionView.contentInset = .init(top: 10, left: 0, bottom: 0, right: 0)
    self.collectionView!.register(MagazineCell.self, forCellWithReuseIdentifier: magazineCellID)
    collectionView.backgroundColor = UIColor(named: "defaultBG")
    view.backgroundColor = UIColor(named: "defaultBG")
    
    }
    
    fileprivate func setupNavigationBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.title = "Magazines"
        
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle.fill")?.withTintColor(.orange, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(infoPressed))
        }
    
    
    
    
//    MARK:- Helper functions and API calls
    @objc func infoPressed(){
        
       let alertController = UIAlertController(title: "The Standard is our quarterly published magazine",message: "Click on any one of these to read", preferredStyle: UIAlertController.Style.alert)
       
       let okayAction = UIAlertAction(title: "Dismiss", style: .destructive, handler: { (_) in
       })
       alertController.addAction(okayAction)
       self.present(alertController, animated: true, completion: nil)
    }
    
    func getCachedMagazines(){
        do{
            let retrievedMagazines = try Disk.retrieve(magazineCache, from: .caches, as: [MagazineData].self)
            self.magazines = retrievedMagazines
          
        }
        catch let error{
            print("Magazine cache error in MagazineController: ", error)
            fetchMagazines()
        }
    }
    
    
    func fetchMagazines(){
        Networking.sharedInstance.getMagazineData(method: HTTPMethods.get.description) { magazineData in
            self.magazines = magazineData.data.reversed()
        } errorCompletion: { error in
         print("Error in fetching magazines" , error)
        }
        
    }
    
    // MARK:- UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return magazines?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: magazineCellID, for: indexPath) as! MagazineCell
        cell.magazineData = magazines?[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.collectionView.isUserInteractionEnabled = false
        if let pdfLink = magazines?[indexPath.item].pdfLink{
            let url: URL! = URL(string: pdfLink)
            if let title = magazines?[indexPath.item].title{
            openPDF(pdfURL: url, pdfTitle: title)
            }
        }
    }
    
    
    private func openPDF(pdfURL: URL, pdfTitle :String){
        let vc = MagazinePDFController()
        vc.pdfTitle = pdfTitle
        vc.hidesBottomBarWhenPushed = true
        FileDownloader.loadFileAsync(url: pdfURL) { pdfLocation, error in
            self.collectionView.isUserInteractionEnabled = true
            vc.pdfLink = pdfLocation ?? ""
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    
   

    // MARK:- UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
        
}
