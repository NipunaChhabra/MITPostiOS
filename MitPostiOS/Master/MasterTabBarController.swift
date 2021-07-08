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
        
    }
    
    private func setupTabs(){
        let vc1 = ArticleViewController()
        let articleViewNavController = UINavigationController(rootViewController: vc1)
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
    
}
