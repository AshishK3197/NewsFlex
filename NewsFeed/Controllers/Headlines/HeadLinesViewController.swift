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
    
    let apiManager = ApiManager()
    var newsData = [NewsModel]()

    override func viewDidLoad() {
        getNewsData()
        super.viewDidLoad()
    }
    
//articles[0].author

}

extension HeadLinesViewController{
    
    func getNewsData(){
        apiManager.fetchNews { (newsModel, error) in
            if let err = error{
                print("Error fetching NewsData \(err.localizedDescription)")
            }
            if let data = newsModel{
                self.newsData = [data]
                DispatchQueue.main.async {
                    self.headLinesTableView.reloadData()
                }
//                print("hi this is the data \(self.newsData)")
            }
        }
    }
       
}



//MARK: - Table View Methods
extension HeadLinesViewController: UITableViewDataSource ,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(newsData.count)
        return newsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = headLinesTableView.dequeueReusableCell(withIdentifier: "headlinesCell", for: indexPath)
        cell.textLabel?.text = newsData[indexPath.row].articles[0].publishedAt
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("The row selected was \(indexPath.row)")
    }
    
}
