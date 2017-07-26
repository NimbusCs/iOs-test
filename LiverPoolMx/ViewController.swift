//
//  ViewController.swift
//  LiverPoolMx
//
//  Created by Development Operator on 7/26/17.
//  Copyright © 2017 Development Operator. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage
import RealmSwift


class ViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var historybtn: UIBarButtonItem!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func historyBtnAc(_ sender: UIBarButtonItem) {
        
        
    }
    let cellReuseIdentifier = "Cell"
    
    var proTitle = [String]()
    var proPrice = [String]()
    var proLoc   = [String]()
    var proImg   = [String]()
    
    var numRows: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

