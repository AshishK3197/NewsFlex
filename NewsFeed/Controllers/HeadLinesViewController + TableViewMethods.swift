//
//  HeadLinesViewController + TableViewMethods.swift
//  NewsFeed
//
//  Created by Ashish Kumar on 26/09/20.
//  Copyright © 2020 Ashish Kumar. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Table View Methods
extension HeadLinesViewController: UITableViewDataSource ,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = headLinesTableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? NewsTableViewCell else {fatalError("Could not create NewsTableViewCell")}
        cell.newsData = newsData[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        headLinesTableView.deselectRow(at: indexPath, animated: true)
        guard let vc = self.storyboard?.instantiateViewController(identifier: "AboutHeadlinesViewController") as? AboutHeadlinesViewController else {return}
        vc.recievedNewsItem = newsData[indexPath.row]
        let navVC = UINavigationController(rootViewController: vc)
        navVC.isNavigationBarHidden = true
        navVC.modalPresentationStyle = UIDevice.current.userInterfaceIdiom == .phone ? .fullScreen : .formSheet
        self.navigationController?.present(navVC, animated: true, completion: nil)
    }
    
}
