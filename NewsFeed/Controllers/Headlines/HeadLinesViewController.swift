//
//  HeadLinesViewController.swift
//  NewsFeed
//
//  Created by Ashish Kumar on 14/02/20.
//  Copyright © 2020 Ashish Kumar. All rights reserved.
//

import UIKit

class HeadLinesViewController: UIViewController {
    
    @IBOutlet weak var headLinesTableView: UITableView!
    
    let itemArray = ["Ashish","Umesh", "Amit"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}

extension HeadLinesViewController: UITableViewDataSource ,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = headLinesTableView.dequeueReusableCell(withIdentifier: "headlinesCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("The row selected was \(indexPath.row) and the item was \(itemArray[indexPath.row])")
    }
    
    
    
    
}
