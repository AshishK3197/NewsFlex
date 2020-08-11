//
//  SearchNewsViewController.swift
//  NewsFeed
//
//  Created by Ashish Kumar on 05/07/20.
//  Copyright © 2020 Ashish Kumar. All rights reserved.
//

import UIKit

class SearchNewsViewController: UIViewController {
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var searchNewsTableView: UITableView!
    let apiManager = ApiManager()
    var newsData = [Article]()
    var filteredNewsData = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
        registerNib()
        getNewsData()
        // Do any additional setup after loading the view.
    }
    
}

extension SearchNewsViewController{
    
    func getNewsData(){
        
        apiManager.getJSONDataFromUrl(request: NewsRequest.sources(source: "google-news")) { (newsModel, error) in
            if let err = error{
                print("Error fetching Data NewsData \(err.localizedDescription)")
            }
            
            if let data = newsModel{
                DispatchQueue.main.async {
                    self.newsData = data.articles
                    self.searchNewsTableView.reloadData()
                }
            }
        }
    }
    
    func registerNib(){
        let nib = UINib(nibName: "NewsTableViewCell", bundle: nil)
        searchNewsTableView.register(nib, forCellReuseIdentifier: "newsCell")
    }
}

extension SearchNewsViewController :UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating{

    private func configureSearchBar(){
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search your news here..."
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.searchBarStyle = .prominent
        searchController.obscuresBackgroundDuringPresentation = false;
        navigationItem.searchController = searchController
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchNews = searchController.searchBar.text else {
            return
        }
        self.filteredNewsData = searchNews.count == 0 ? newsData : newsData.filter{
            ($0.title?.localizedCaseInsensitiveContains(searchNews))!
        }
                self.searchNewsTableView.reloadData()
        }
}


extension SearchNewsViewController: UITableViewDataSource , UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 400
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredNewsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchNewsTableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
        cell.NewsTitleLabel.text = filteredNewsData[indexPath.row].title
        cell.NewsPublishedAtLabel.text = filteredNewsData[indexPath.row].publishedAt
        cell.NewsImageView.image = UIImage(named: filteredNewsData[indexPath.row].urlToImage!)
        cell.NewsAuthorLabel.text = filteredNewsData[indexPath.row].author
        
        if let imageUrl = URL(string: "\(filteredNewsData[indexPath.row].urlToImage ?? "No image URL found")"){
            URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                if let imageData = data{
                    DispatchQueue.main.async {
                        cell.NewsImageView.image = UIImage(data: imageData)
                    }
                }
            }.resume()
        }
        
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                searchNewsTableView.deselectRow(at: indexPath, animated: true)
                let vc = self.storyboard?.instantiateViewController(identifier: "AboutHeadlinesViewController") as? AboutHeadlinesViewController
                vc?.recievedNewsItem = filteredNewsData[indexPath.row]
                vc?.modalPresentationStyle = UIDevice.current.userInterfaceIdiom == .phone ? .fullScreen : .formSheet
                let navVC = UINavigationController(rootViewController: vc!)
                navVC.isNavigationBarHidden = true
                self.navigationController?.present(navVC, animated: true, completion: nil)
            }
    
    
    
}
