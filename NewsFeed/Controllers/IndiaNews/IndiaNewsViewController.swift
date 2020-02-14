//
//  IndiaNewsViewController.swift
//  NewsFeed
//
//  Created by Ashish Kumar on 14/02/20.
//  Copyright © 2020 Ashish Kumar. All rights reserved.
//

import UIKit

class IndiaNewsViewController: UIViewController {

    @IBOutlet weak var indiaNewsTableView: UITableView!
    
    let itemArray = ["Rahul", "Sahil" , "Sagar"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
extension IndiaNewsViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = indiaNewsTableView.dequeueReusableCell(withIdentifier: "indiaNewsCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("The item selcted was \(itemArray[indexPath.row]) at row \(indexPath.row))")
    }
    
}
