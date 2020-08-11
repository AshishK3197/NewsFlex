//
//  WebViewViewController.swift
//  NewsFeed
//
//  Created by Ashish Kumar on 05/07/20.
//  Copyright © 2020 Ashish Kumar. All rights reserved.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController, WKNavigationDelegate{

    var webView: WKWebView!
    var recievedUrl : String?
    
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
    
    private func loadWebView(_ url : String){
        
        if let urlToWebPage = URL(string: url){
            let request = URLRequest(url: urlToWebPage)
            webView.load(request)
        }
        configureWebView()
    }
    
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
    
    @objc func goBackward(){
        if webView.canGoBack{
            webView.goBack()
        }
    }
    
    @objc func goForward(){
        if webView.canGoForward{
            webView.goForward()
        }
    }
    
    @objc func refresh(){
        webView.reload()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))

    }
  

}
