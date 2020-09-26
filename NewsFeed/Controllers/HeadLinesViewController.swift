//
//  HeadLinesViewController.swift
//  NewsFeed
//
//  Created by Ashish Kumar on 24/09/20.
//  Copyright © 2020 Ashish Kumar. All rights reserved.
//

import UIKit
import Network
import MessageUI

class HeadLinesViewController: UIViewController{
    
    //MARK: - Variable Declaration
    let apiManager = ApiManager()
    var newsData = [Article]()
    private var categories: [String] = []
    
    private var languages: [String] = []
    
    private var countries: [String] = []

    
    //MARK: - VC LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getNewsData()
        registerNib()
        
    }
    
    func createSpinnerView() {
        let child = SpinnerViewController()
        
        // add the spinner view controller
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
        
        // wait two seconds to simulate some work happening
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            // then remove the spinner view controller
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (newsData.count == 0) {
            createSpinnerView()
        }
    }
    
    //MARK: - IBOutlets
    @IBOutlet weak var headLinesTableView: UITableView!
    
    @IBAction func countryBarButton(_ sender: UIBarButtonItem) {
        
        self.apiManager.getCategorisationData(request: NewsRequest.categorizationData) { (sources, error) in
            if let error = error{
                debugPrint("Error fetching data \(error.localizedDescription)")
            }
            
            if let safeData = sources{
                self.countries = Array(Set(safeData.sources.map{$0.country}))
                
            }
        }
        
        let categoryActivityVC = UIAlertController(title: "Select a Country",
                                                   message: nil,
                                                   preferredStyle: .actionSheet)
        
        let cancelButton = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: nil)
        
        categoryActivityVC.addAction(cancelButton)
        
        for country in countries{
            
            let countryButton = UIAlertAction(title: country.formattedCountryDescription, style: .default) { action in
                self.apiManager.getJSONDataFromUrl(request: NewsRequest.country(country: country)) { (newsModel, error) in
                    if let err = error{
                        print("Error fetching Data NewsData \(err.localizedDescription)")
                    }

                    if let data = newsModel{
                            self.newsData.removeAll()
                            self.newsData = data.articles
                        DispatchQueue.main.async {
                            self.createSpinnerView()
                            self.headLinesTableView.reloadData()
                        }
                    }
                }
            }
            categoryActivityVC.addAction(countryButton)
        }
        
        self.present(categoryActivityVC, animated: true, completion: nil)
        
    }
    
    @IBAction func categoryBarButton(_ sender: UIBarButtonItem) {
        
        let categoryActivityVC = UIAlertController(title: "Select a Category",
                                                   message: nil,
                                                   preferredStyle: .actionSheet)
        
        let cancelButton = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: nil)
        
        categoryActivityVC.addAction(cancelButton)
        
        self.apiManager.getCategorisationData (request: NewsRequest.categorizationData) { (sources, error) in
            if let error = error{
                debugPrint("Error fetching data \(error.localizedDescription)")
            }
            
            if let safeData = sources{
                self.categories = Array(Set(safeData.sources.map{$0.category}))
                
            }
        }
        
        for category in categories{
            
            let categoryButton = UIAlertAction(title: category.uppercased(), style: .default) { action in
                self.apiManager.getJSONDataFromUrl(request: NewsRequest.category(category: category)) { (newsModel, error) in
                    if let err = error{
                        print("Error fetching Data NewsData \(err.localizedDescription)")
                    }
                    
                    if let data = newsModel{
                            self.newsData.removeAll()
                            self.newsData = data.articles
//                            SpinnerViewController.shared.createSpinnerView()
                        DispatchQueue.main.async {
                            self.createSpinnerView()
                            self.headLinesTableView.reloadData()
                        }
                    }
                }
            }
            categoryActivityVC.addAction(categoryButton)
        }
        self.present(categoryActivityVC, animated: true, completion: nil)
    }
}

//MARK: - Network Calls
extension HeadLinesViewController{
    
    func getNewsData(){
        
        apiManager.getJSONDataFromUrl(request: NewsRequest.sources(source: "google-news")) { (newsModel, error) in
            if let err = error{
                print("Error fetching Data NewsData \(err.localizedDescription)")
            }
            
            if let data = newsModel{
                DispatchQueue.main.async {
                    self.newsData = data.articles
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


