//
//  informationVC.swift
//  socialsPage
//
//  Created by Chitrala Dhruv on 29/04/22.
//

import UIKit
import SafariServices
import MessageUI

class informationVC: UIViewController, MFMailComposeViewControllerDelegate {
    
    private let spotifyUnwindLink = "https://open.spotify.com/playlist/6FFJblOyRN5zPGfiPp39Zj?si=4p64hmjMS0eRLvZYfYvUmQ&utm_source=copy-link&dl_branch=1"
    private let spotifyStudyLink = "https://open.spotify.com/playlist/47z3uheG8SYnfk1irwNQR0?si=LhbS3di8SY2A4v_21idXKg&utm_source=copy-link&dl_branch=1"
    
    private let privacyURL = "https://app.themitpost.com/policy"
    private let aboutURL = "https://app.themitpost.com/about"
    private let websiteLink = "https://themitpost.com/"
    
    
    var infoOptions:[String] = ["DARK MODE","ACADEMIC CALENDER","OUR WEBSITE","PRIVACY POLICY","ABOUT US","REPORT A BUG"]
    
    var logoNames:[String] = ["lightbulb","calendar","link","person.3.fill","heart.fill","ladybug"]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(scrollView)
        view.backgroundColor = UIColor(named: "articleCellBG")
        
        squareCollectionView.delegate = self
        squareCollectionView.dataSource = self
        
        rectCollectionView.delegate = self
        rectCollectionView.dataSource = self
        
        singleCollectionView.delegate = self
        singleCollectionView.dataSource = self
        
        setUpAutoLayout()
    }
    
    lazy var scrollView: UIScrollView =  {

       let scrollView = UIScrollView(frame: view.bounds)
      
       scrollView.backgroundColor = .clear
       scrollView.contentSize = CGSize(width: view.frame.size.width, height: view.frame.size.height*1.2)
       scrollView.showsHorizontalScrollIndicator = false
       
       scrollView.addSubview(singleCollectionView)
        scrollView.addSubview(rectCollectionView)
        scrollView.addSubview(squareCollectionView)
       
       return scrollView
       
   }()
    
    private let singleCollectionView: UICollectionView =  {

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(singleCell.self, forCellWithReuseIdentifier: "singleCell")
        collectionView.backgroundColor = .clear

        return collectionView
        
    }()
    
    private let rectCollectionView: UICollectionView =  {

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(rectCell.self, forCellWithReuseIdentifier: "rectCell")
        collectionView.backgroundColor = .clear
        

        return collectionView
        
    }()
    
    private let squareCollectionView: UICollectionView =  {

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(squareCell.self, forCellWithReuseIdentifier: "squareCell")
        collectionView.backgroundColor = .clear

        return collectionView
        
    }()
    
    private func setUpAutoLayout() {
        
        singleCollectionView.translatesAutoresizingMaskIntoConstraints = false

        singleCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        singleCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        singleCollectionView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        singleCollectionView.heightAnchor.constraint(equalToConstant: (view.frame.width*3/4)).isActive = true
        
        rectCollectionView.translatesAutoresizingMaskIntoConstraints = false

        rectCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        rectCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        rectCollectionView.topAnchor.constraint(equalTo: singleCollectionView.bottomAnchor, constant: 20).isActive = true
        rectCollectionView.heightAnchor.constraint(equalToConstant: view.frame.width/4).isActive = true
        
        
        squareCollectionView.translatesAutoresizingMaskIntoConstraints = false

        squareCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        squareCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        squareCollectionView.topAnchor.constraint(equalTo: rectCollectionView.bottomAnchor, constant: 20).isActive = true
        squareCollectionView.heightAnchor.constraint(equalToConstant: view.frame.width/1.7).isActive = true
    }
    

}

extension informationVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == singleCollectionView {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.width/4)
        }
        else if collectionView == squareCollectionView {
            return CGSize(width: collectionView.frame.width/3.4, height: collectionView.frame.width/3.4)
        }
        else if collectionView == rectCollectionView {
            return CGSize(width: (collectionView.frame.width/2)-10, height: collectionView.frame.width/4)
        }
        else {
            return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/4)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == singleCollectionView {
            return 3
        }
        else if collectionView == squareCollectionView {
            return 6
        }
        else if collectionView == rectCollectionView {
            return 2
        }
        else {
            return 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == singleCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "singleCell", for: indexPath) as! singleCell
            
            return cell
        }
        else if collectionView == squareCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "squareCell", for: indexPath) as! squareCell
            cell.listNameLabel.text = infoOptions[indexPath.row]
            cell.infoImageView.image = UIImage(systemName: logoNames[indexPath.row])?.withTintColor(.black, renderingMode: .alwaysOriginal)
            
            return cell
        }
        else if collectionView == rectCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "rectCell", for: indexPath) as! rectCell
            
            return cell
        }
        else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == singleCollectionView {
            switch indexPath.item{
                
            case 0:
                openWebPage(url: websiteLink)
            
            case 1:
                //socials view
                print("Successfull")
                
            case 2:
//                let vc = MagazineViewController(collectionViewLayout: UICollectionViewFlowLayout())
//                vc.hidesBottomBarWhenPushed = true
//                self.navigationController?.pushViewController(vc, animated: true)
                print("Magazine")
                
            default:
                print("Something")

            }
            
        }
        else if collectionView == squareCollectionView {
            switch indexPath.item{
                
            case 0:
                //dark mode switch
                print("Dark mode")
            
            case 1:
                openWebPage(url: websiteLink)
                //update calender link
                
            case 2:
                openWebPage(url: websiteLink)
                
            case 3:
                openWebPage(url: privacyURL)
                
            case 4:
                openWebPage(url: aboutURL)
            
            case 5:
                openMail()
                
            default:
                print("Something")
            }
            
        }
        else if collectionView == rectCollectionView {
            switch indexPath.item{
                
            case 0:
                openPlaylists()
            
            case 1:
                //developers VC
                print("DevelopersVC")
                
            default:
                print("Something")

            }
        }
        
        else {
            print("Something")
        }
    }

    
    
    //    MARK: - Helper methods and functions
        
        fileprivate func openPlaylists(){
            let alertController = UIAlertController(title: "Choose a playlist",message: "", preferredStyle: UIAlertController.Style.alert)
            
            let unwindAction = UIAlertAction(title: "Unwind", style: .default, handler: { (_) in
                let redirectLink = self.spotifyUnwindLink
                let webURL = NSURL(string: redirectLink)!
                let application = UIApplication.shared
                application.open(webURL as URL)
            })
            
            let studyAction = UIAlertAction(title: "Study", style: .default, handler: { (_) in
                let redirectLink = self.spotifyStudyLink
                let webURL = NSURL(string: redirectLink)!
                let application = UIApplication.shared
                application.open(webURL as URL)
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            })
            
            alertController.addAction(unwindAction)
            alertController.addAction(studyAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
        fileprivate func openWebPage(url:String){
            
            if let url = URL(string: url) {
                   let config = SFSafariViewController.Configuration()
                   config.entersReaderIfAvailable = true

                   let vc = SFSafariViewController(url: url, configuration: config)
                   present(vc, animated: true)
               }
            
            
        }
        
    //    MARK: - Bug Reports
        
        fileprivate func openMail(){
            let emailTitle = "Feedback"
            let messageBody = "Feature request or bug report"
            let toRecipents = "rohitkuber42@icloud.com"
            
    //        if MFMailComposeViewController.canSendMail() {
    //            let mc: MFMailComposeViewController = MFMailComposeViewController()
    //            mc.mailComposeDelegate = self
    //            mc.setSubject(emailTitle)
    //            mc.setMessageBody(messageBody, isHTML: false)
    //            mc.setToRecipients(toRecipents)
    //
    //            present(UINavigationController(rootViewController: mc), animated: true, completion: nil)
    //        }
            
            if let url = URL(string: "mailto:\(toRecipents)?subject=\(emailTitle)&body=\(messageBody)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) {
               UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            
        }
        
        //Will implement later
        private func createEmailUrl(to: String, subject: String, body: String) -> URL? {
            let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            
            let gmailUrl = URL(string: "googlegmail://co?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
            let outlookUrl = URL(string: "ms-outlook://compose?to=\(to)&subject=\(subjectEncoded)")
            let yahooMail = URL(string: "ymail://mail/compose?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
            let sparkUrl = URL(string: "readdle-spark://compose?recipient=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
            let defaultUrl = URL(string: "mailto:\(to)?subject=\(subjectEncoded)&body=\(bodyEncoded)")
            
            if let gmailUrl = gmailUrl, UIApplication.shared.canOpenURL(gmailUrl) {
                return gmailUrl
            } else if let outlookUrl = outlookUrl, UIApplication.shared.canOpenURL(outlookUrl) {
                return outlookUrl
            } else if let yahooMail = yahooMail, UIApplication.shared.canOpenURL(yahooMail) {
                return yahooMail
            } else if let sparkUrl = sparkUrl, UIApplication.shared.canOpenURL(sparkUrl) {
                return sparkUrl
            }
            
            return defaultUrl
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
          controller.dismiss(animated: true)
        }
        
}


