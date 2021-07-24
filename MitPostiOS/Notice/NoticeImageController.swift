//
//  NoticeImageController.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 21/07/21.
//

import UIKit
import SDWebImage

class NoticeImageController: UIViewController {
    
    
    var imageLink: String?
    
    lazy var noticeImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.layer.masksToBounds = true
        iv.clipsToBounds = true
        iv.setDimensions(width: view.frame.width, height: (view.frame.width + view.frame.width/6))
        iv.translatesAutoresizingMaskIntoConstraints = false
//        iv.backgroundColor = .gray
        return iv
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "defaultBG")
        
        view.addSubview(noticeImageView)
        noticeImageView.centerY(inView: view)
        
        noticeImageView.sd_setImage(with: URL(string: imageLink!), completed: nil)
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.action, target: self, action: #selector(handleShare))]

    }
    
    @objc fileprivate func handleShare(){
        guard let noticeImage = self.noticeImageView.image else{return}
        let activityController = UIActivityViewController(activityItems: [noticeImage], applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
    }
    


}
