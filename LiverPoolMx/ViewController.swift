//
//  ViewController.swift
//  LiverPoolMx
//
//  Created by Tomas E. Nu#ez on 7/26/17.
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
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.search(param: searchBar.text!)
        self.saveHistory(key: searchBar.text!)
        
        self.cleanAll()
    }
    
    func saveHistory(key: String){
        let history = History()
        history.key = key
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(history)
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.numRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ProductCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! ProductCell
        
        cell.nameP.text  = self.proTitle[indexPath.row]
        cell.priceP.text = self.proPrice[indexPath.row]
        cell.locP.text   = self.proLoc[indexPath.row]
        
        Alamofire.request(self.proImg[indexPath.row]).responseImage { response in debugPrint(response)
            //print(response.request)
            
            let image = response.result.value
            
            cell.imgP.image = image
            
        }
        
        
        return cell
    }
    
    func cleanAll(){
        self.proTitle.removeAll()
        self.proPrice.removeAll()
        self.proLoc.removeAll()
        self.proImg.removeAll()
        self.numRows = 0
        
    }
    func search(param: String){
        
        let url = "https://www.liverpool.com.mx/tienda?s="
        let key = "&d3106047a194921c01969dfdec083925=json"
        
        Alamofire.request(url + param + key).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let json = JSON(responseData.result.value!)
                //print(json)
                
                let arrayP = json["contents"][0]["mainContent"][3]["contents"][0]["records"].array
                if arrayP == nil {
                    self.cleanAll()
                    self.tableView.reloadData()
                } else {
                    
                    let numP   = arrayP?.count
                    self.numRows = numP!
                    
                    for index in 0...numP!-1 {
                        
                        let title: String? = arrayP?[index]["attributes"]["product.displayName"][0].stringValue
                        let price: String? = arrayP?[index]["attributes"]["sku.sale_Price"][0].stringValue
                        let loc:   String? = arrayP?[index]["attributes"]["ancestorCategories.displayName"][0].stringValue
                        let image: String? = arrayP?[index]["attributes"]["sku.smallImage"][0].stringValue
                        
                        self.proTitle.append(title!)
                        self.proPrice.append(price!)
                        self.proLoc.append(loc!)
                        self.proImg.append(image!)
                        
                    }
                    
                    print(self.proTitle)
                    self.tableView.reloadData()
                    
                    
                }
                
            }
        }
    }

}

