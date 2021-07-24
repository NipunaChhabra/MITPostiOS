//
//  SlcmInternalController.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 24/07/21.
//

import UIKit

class SlcmInternalController: UITableViewController {
    
//    MARK:-Properties
    
    
    var slcmController : SLCMViewController?
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//MARK:- Lifecycle functions

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "defaultBG")
        setupNavigationBar()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "id")
        tableView.tableFooterView = UIView()
    }
    
    

    
    
//    MARK: -Setting up UI
    
    fileprivate func setupNavigationBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Rohit Kuber"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "lock.open")?.withTintColor(.orange, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(logoutPressed))

    }
    
    
    
    
    
    
//    MARK:-Helper functions and API
    
    
    @objc func logoutPressed(){
        slcmController?.handleLogout()
    }
    
    func setupViewForLoggedOutUser(){
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "id", for: indexPath)

        // Configure the cell...

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
