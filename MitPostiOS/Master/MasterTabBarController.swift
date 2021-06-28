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
        setupTabs()
    }
    
    private func setupTabs(){
        let vc1 = ArticleViewController()
        let articleViewNavController = UINavigationController(rootViewController: vc1)
        articleViewNavController.tabBarItem = UITabBarItem(title: "Articles", image: UIImage(named: "home"), tag: 0)
        
        let vc2 = SocialTableViewController()
        let socialNavController = MasterNavigationBarController(rootViewController: vc2)
        socialNavController.tabBarItem = UITabBarItem(title: "Social", image: UIImage(named: "home"), tag: 1)
        
        let vc3 = SLCMViewController()
        let slcmNavController = MasterNavigationBarController(rootViewController: vc3)
        slcmNavController.tabBarItem = UITabBarItem(title: "SLCM", image: UIImage(named:"home"), tag: 2)
        
        let vc4 = EventsTableViewController()
        let eventsNavController = MasterNavigationBarController(rootViewController: vc4)
        eventsNavController.tabBarItem = UITabBarItem(title: "Events", image: UIImage(named:"home"), tag: 3)
        
        let vc5 = NoticesTableViewController()
        let noticesNavController = MasterNavigationBarController(rootViewController: vc5)
        noticesNavController.tabBarItem = UITabBarItem(title: "Notices", image: UIImage(named:"home"), tag: 4)
        
        
        
        
        
        viewControllers = [articleViewNavController,socialNavController,slcmNavController,eventsNavController,noticesNavController]
    }
    
}
