//
//  GithubViewController.swift
//  NewsFeed
//
//  Created by Ashish Kumar on 12/07/20.
//  Copyright © 2020 Ashish Kumar. All rights reserved.
//

import UIKit

class GithubViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadGithubView()
        // Do any additional setup after loading the view.
    }
    
    func loadGithubView(){
        let webVC = self.storyboard?.instantiateViewController(withIdentifier: "webview") as? WebViewViewController
        webVC?.modalPresentationStyle = UIDevice.current.userInterfaceIdiom == .phone ? .fullScreen : .formSheet
        webVC?.recievedUrl = "https://github.com/AshishK3197"
        self.navigationController?.pushViewController(webVC! , animated: true)
    }
    
}
