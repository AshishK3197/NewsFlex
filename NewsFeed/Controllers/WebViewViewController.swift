//
//  WebViewViewController.swift
//  NewsFeed
//
//  Created by Ashish Kumar on 24/09/20.
//  Copyright © 2020 Ashish Kumar. All rights reserved.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController, WKNavigationDelegate{

     //MARK: - Variable Declaration
  fileprivate  var webView: WKWebView!
    var recievedUrl : String?
    
  //MARK: - VC LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let safeUrl = recievedUrl{
           loadWebView(safeUrl)
        }
    }
    
    override func loadView() {
        webView = WKWebView(frame: .zero)
        webView.navigationDelegate = self
        view = webView
    }
    
    //MARK: - WebView Functions
    
    /// Function responsible for loading the WebView after it gets the url of the Webpage to be displayed.
    /// - Parameter url: Url as an input parameter for loading the correct webpage from the url String.
    private func loadWebView(_ url : String){
        
        if let urlToWebPage = URL(string: url){
            let request = URLRequest(url: urlToWebPage)
            webView.load(request)
        }
        configureWebView()
    }
    
    /// Function responsible for configuration of the WebView.
    private func configureWebView(){
        navigationItem.rightBarButtonItems =
            [UIBarButtonItem(title: ">", style: .plain, target: self, action: #selector(goForward)),
        UIBarButtonItem(title: "<", style: .plain, target: self, action: #selector(goBackward))]
        
        if webView.isLoading{
            let loader = UIActivityIndicatorView(style: .medium)
            loader.startAnimating()
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: loader)
        }else{
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
        }
    }
    
    /// Go Backward Functionality
    @objc func goBackward(){
        if webView.canGoBack{
            webView.goBack()
        }
    }
    
    /// Go Forward Functionality
    @objc func goForward(){
        if webView.canGoForward{
            webView.goForward()
        }
    }
    
    /// Refresh Functionality
    @objc func refresh(){
        webView.reload()
    }
    
    /// Function responsible for finishing customization of the webview.
    /// - Parameters:
    ///   - webView: input parameter as an instance of webview created.
    ///   - navigation: input parameter for object containing information for tracking the loading progress of a webpage.
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))

    }
  

}
