//
//  InfoCollectionViewController.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 04/08/21.
//

import UIKit
import SafariServices
import MessageUI

private let reuseIdentifier = "Cell"

class InfoCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout,  MFMailComposeViewControllerDelegate{
    
    private let spotifyUnwindLink = "https://open.spotify.com/playlist/6FFJblOyRN5zPGfiPp39Zj?si=4p64hmjMS0eRLvZYfYvUmQ&utm_source=copy-link&dl_branch=1"
    private let spotifyStudyLink = "https://open.spotify.com/playlist/47z3uheG8SYnfk1irwNQR0?si=LhbS3di8SY2A4v_21idXKg&utm_source=copy-link&dl_branch=1"
    
    private let privacyURL = "https://app.themitpost.com/policy"
    private let aboutURL = "https://app.themitpost.com/about"
    private let websiteLink = "https://themitpost.com/"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "defaultBG")
        collectionView.backgroundColor = UIColor(named: "defaultBG")
        self.collectionView!.register(InfoCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)


    }
    
    var infoOptions:[String] = ["The Standard","Our Website","Playlists","Developers","Privacy Policy","About Us","Report a Bug","Review on the App Store"]
    var detailedInfoOptions:[String] = ["Our quarterly magazine","Visit us","Songs for every mood","Tech geeks","Privacy is paradise","Who are we?","No code has zero defects","Rate us :)"]
    
    var logoNames:[String] = ["book","globe","music.note","chevron.left.slash.chevron.right","person.3.fill","info.circle","ladybug","applelogo"]

 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    // MARK:- UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! InfoCollectionViewCell
        cell.listNameLabel.text = infoOptions[indexPath.row]
        cell.infoLabel.text = detailedInfoOptions[indexPath.row]
        cell.infoImageView.image = UIImage(systemName: logoNames[indexPath.row])?.withTintColor(.orange, renderingMode: .alwaysOriginal)
        return cell
    }

    // MARK:- UICollectionViewDelegate

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width-20, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.item{
            
        case 0:
            let vc = MagazineViewController(collectionViewLayout: UICollectionViewFlowLayout())
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        
        case 1:
            openWebPage(url: websiteLink)
            
        case 2:
            openPlaylists()
            
        case 4:
            openWebPage(url: privacyURL)
            
        case 5:
            openWebPage(url: aboutURL)
        
        case 6:
            openMail()
            
            
            
        default:
            print("Something")

        
        }
    }
    
//    MARK:-Helper methods and functions
    
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
    
//    MARK:- Bug Reports
    
    fileprivate func openMail(){
        let emailTitle = "Feedback"
        let messageBody = "Feature request or bug report?"
        let toRecipents = ["rohitkuber42@icloud.com"]
        let mc: MFMailComposeViewController = MFMailComposeViewController()
        mc.mailComposeDelegate = self
        mc.setSubject(emailTitle)
        mc.setMessageBody(messageBody, isHTML: false)
        mc.setToRecipients(toRecipents)

        self.present(mc, animated: true, completion: nil)
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
