//
//  SearchNewsViewController.swift
//  NewsFeed
//
//  Created by Ashish Kumar on 24/09/20.
//  Copyright © 2020 Ashish Kumar. All rights reserved.
//

import UIKit

class SearchNewsViewController: UIViewController {
    
    
    //MARK: - IBOutlets/IBActions
    @IBOutlet weak var searchNewsTableView: UITableView!
    
    //MARK: - Variable Declaration
    fileprivate  let searchController = UISearchController(searchResultsController: nil)
    fileprivate  let apiManager = ApiManager()
    fileprivate  var newsData = [Article]()
    fileprivate  var filteredNewsData = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
        registerNib()
        getNewsData()
        // Do any additional setup after loading the view.
    }
    
}

//MARK: - Network Calls
extension SearchNewsViewController{
    
    /// Function Responsible for getting News Articles from API on App Launch
    private func getNewsData(){
        
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
    
    /// Function responsible for registering Custom Cell XIB in the TableView.
    private func registerNib(){
        let nib = UINib(nibName: "NewsTableViewCell", bundle: nil)
        searchNewsTableView.register(nib, forCellReuseIdentifier: "newsCell")
    }
}

//MARK: - Seach Control Delegate Methods
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

//MARK: - Table View Methods
extension SearchNewsViewController: UITableViewDataSource , UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredNewsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = searchNewsTableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? NewsTableViewCell else {fatalError("Could not create NewsTableViewCell ")}
        cell.filteredNewsData = filteredNewsData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchNewsTableView.deselectRow(at: indexPath, animated: true)
        let vc = self.storyboard?.instantiateViewController(identifier: "AboutHeadlinesViewController") as? AboutHeadlinesViewController
        vc?.recievedNewsItem = filteredNewsData[indexPath.row]
        let navVC = UINavigationController(rootViewController: vc!)
        navVC.isNavigationBarHidden = true
        navVC.modalPresentationStyle = UIDevice.current.userInterfaceIdiom == .phone ? .fullScreen : .formSheet
        self.navigationController?.present(navVC, animated: true, completion: nil)
    }
    
    
    
}
