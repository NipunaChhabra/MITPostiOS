//
//  ArticleWebView.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 16/07/21.
//

import Foundation
import UIKit
import WebKit

class ArticleWebViewController : UIViewController{
    
    
   var webURL: String?
    
    lazy var webView : WKWebView = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        let wv = WKWebView(frame: frame)
        return wv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView)
        webView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        if let urlString = webURL{
            let url = URL(string: urlString)
            webView.load(URLRequest(url: url!))
        }
        
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.action, target: self, action: #selector(handleShare))]
    }
    
    @objc fileprivate func handleShare(){
        
        let activityController = UIActivityViewController(activityItems: [webURL as Any], applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
    }
}
