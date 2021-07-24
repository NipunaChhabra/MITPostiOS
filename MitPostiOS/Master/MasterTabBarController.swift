//
//  MasterTabBarController.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 28/06/21.
//

import Foundation
import UIKit

class MasterTabBarController : UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isTranslucent = false
//        tabBar.barTintColor = UIColor.CustomColors.Black.background
        tabBar.tintColor = .orange
        setupTabs()
        fetchMagazines()
        getArticles()
        getNotices()
        getInstagramData()
        
    }
    
    private func setupTabs(){
        let vc1 = ArticleViewController()
        let articleViewNavController = MasterNavigationBarController(rootViewController: vc1)
        articleViewNavController.tabBarItem = UITabBarItem(title: "Articles", image: UIImage(systemName: "newspaper"), tag: 0)
        
        let vc2 = SocialTableViewController(style: .grouped)
        let socialNavController = MasterNavigationBarController(rootViewController: vc2)
        socialNavController.tabBarItem = UITabBarItem(title: "Social", image: UIImage(systemName: "heart"), tag: 1)
        
        let vc3 = SLCMViewController()
        let slcmNavController = MasterNavigationBarController(rootViewController: vc3)
        slcmNavController.tabBarItem = UITabBarItem(title: "SLCM", image: UIImage(systemName:"person"), tag: 2)
        
        let vc4 = EventsTableViewController(style: .grouped)
        let eventsNavController = MasterNavigationBarController(rootViewController: vc4)
        eventsNavController.tabBarItem = UITabBarItem(title: "Events", image: UIImage(systemName:"calendar"), tag: 3)
        
        let vc5 = NoticesTableViewController(style: .grouped)
        let noticesNavController = MasterNavigationBarController(rootViewController: vc5)
        noticesNavController.tabBarItem = UITabBarItem(title: "Notices", image: UIImage(systemName:"bell"), tag: 4)
        
        
        
        
        
        viewControllers = [articleViewNavController,socialNavController,slcmNavController,eventsNavController,noticesNavController]
    }
    
//    MARK:- API Calls
    func fetchMagazines(){
        var magazines = [MagazineData]()
        Networking.sharedInstance.getMagazineData(method: HTTPMethods.get.description) { magazineData in
            magazines = magazineData.data.reversed()
            Caching.sharedInstance.saveMagazinesToCache(magazines: magazines)
        } errorCompletion: { error in
         print("Error in fetching magazines" , error)
        }
    }
    
    func getArticles(){
        var articles = [ArticleModel]()
        Networking.sharedInstance.getArticleData(method: HTTPMethods.get.description, dataCompletion: { articleData in
            articles = articleData
            Caching.sharedInstance.saveArticlesToCache(article: articles)
        }, errorCompletion: { err in
            print("Error in fetching article/post data", err)
        })
    }
    
    func getNotices(){
        var notices = [Notice]()
        Networking.sharedInstance.getNoticeData(method: HTTPMethods.get.description) { noticeData in
            notices = noticeData.reversed()
            Caching.sharedInstance.saveNoticesToCache(notices: notices)
        } errorCompletion: { err in
            print("Error in fetching notices" , err)
        }
    }
    
    func getInstagramData(){
        var instagramData = [Instagram]()
        Networking.sharedInstance.getInstagramData(method: HTTPMethods.get.description) { instaData in
            instagramData = instaData
            Caching.sharedInstance.saveInstagramDataToCache(instagramData: instagramData)
        } errorCompletion: { err in
            print("Error in fetching Instagram Data", err)
        }
    }
    
    
}
