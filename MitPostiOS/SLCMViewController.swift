//
//  SLCMViewController.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 28/06/21.
//

import UIKit

class SLCMViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "defaultBG")
        setupNavigationBar()
        // Do any additional setup after loading the view.
    }
    
    @objc func infoPressed(){
        let vc = InfoTableViewController()
        navigationController?.pushViewController(vc, animated: true)
        print("Do something")
    }
    
    fileprivate func setupNavigationBar(){
//        navigationController.pre
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "SLCM"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle")?.withTintColor(.orange, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(infoPressed))

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
