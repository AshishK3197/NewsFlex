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
        registerNib()
        super.viewDidLoad()
    }

}

extension HeadLinesViewController{
    
    func getNewsData(){
        apiManager.fetchNews { (newsModel, error) in
            if let err = error{
                print("Error fetching NewsData \(err.localizedDescription)")
            }
            if let data = newsModel{
                self.newsData = [data]
                print(self.newsData)
                DispatchQueue.main.async {
                    self.headLinesTableView.reloadData()
                }
            }
        }
    }
    
    func registerNib(){
        let nib = UINib(nibName: "NewsTableViewCell", bundle: nil)
        headLinesTableView.register(nib, forCellReuseIdentifier: "newsCell")
    }
}

//MARK: - Table View Methods
extension HeadLinesViewController: UITableViewDataSource ,UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = headLinesTableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
        cell.NewsLabel.text = newsData[indexPath.row].articles[0].title
        cell.publishedAtLabel.text = newsData[indexPath.row].articles[0].publishedAt
        cell.loadedImage.image = UIImage(named: newsData[indexPath.row].articles[0].urlToImage)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("The row selected was \(indexPath.row)")
        let destinationVC = self.storyboard?.instantiateViewController(identifier: "AboutHeadlinesViewController") as! AboutHeadlinesViewController
        destinationVC.passedTitleText = newsData[indexPath.row].articles[0].title
        if let authorData = newsData[indexPath.row].articles[0].author{
            destinationVC.passedAuthorText = authorData
        }
        destinationVC.passedPublishedAtText = newsData[indexPath.row].articles[0].publishedAt
        destinationVC.passedContentText = newsData[indexPath.row].articles[0].content
//        destinationVC.passedImageView = newsData[indexPath.row].articles[0].urlToImage
        
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
}
