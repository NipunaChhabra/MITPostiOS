//
//  MagazinePDFController.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 13/07/21.
//

import Foundation
import UIKit
import PDFKit

class MagazinePDFController : UIViewController{
    lazy var pdfView: PDFView = {
        let view = PDFView()
        view.autoScales = true
        view.displayMode = .singlePageContinuous
        return view
    }()
    
    var pdfLink: String = ""
    var nameOfFile: String = ""
    var pdfTitle: String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        navigationItem.largeTitleDisplayMode = .never
        DispatchQueue.main.async {
            print(self.pdfLink)
            let fileURL = URL(fileURLWithPath: self.pdfLink)
            self.pdfView.document = PDFDocument(url: fileURL)
        }
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.action, target: self, action: #selector(handleShare))]
    }
    
    
    @objc fileprivate func handleShare(){
        guard let documentData = self.pdfView.document?.dataRepresentation() else { return }
        let activityController = UIActivityViewController(activityItems: [pdfTitle, documentData], applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
    }
    
    
    fileprivate func setupView(){
        view.backgroundColor = .white
        view.addSubview(pdfView)
        pdfView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}
