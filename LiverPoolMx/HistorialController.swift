//
//  HistorialController.swift
//  LiverPoolMx
//
//  Created by Tomas E. Nu#ez on 7/26/17.
//  Copyright © 2017 Development Operator. All rights reserved.
//

import UIKit
import RealmSwift

class HistorialController: UITableViewController {

    let cellReuseIdentifier = "cellH"
    
    let history = try! Realm().objects(History.self)
    
    
    @IBAction func doneBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.history.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        let obj = history[indexPath.row]
        cell.textLabel?.text = obj.key
        
        return cell
    }
    
    
    
}
