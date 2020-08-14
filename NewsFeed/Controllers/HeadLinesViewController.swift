//
//  HeadLinesViewController.swift
//  NewsFeed
//
//  Created by Ashish Kumar on 14/02/20.
//  Copyright © 2020 Ashish Kumar. All rights reserved.
//

import UIKit
import Network
import MessageUI

class HeadLinesViewController: UIViewController{
    
    //MARK: - IBOutlets
    @IBOutlet weak var headLinesTableView: UITableView!
    
    //MARK: - Variable Declaration
    let apiManager = ApiManager()
    var newsData = [Article]()
    let monitor = NWPathMonitor(requiredInterfaceType: .wifi)
    let transition = SlideInTransition()
    var topView: UIView?
    
    //MARK: - VC LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil;
        getNewsData()
        registerNib()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Spinner Setup
        if (newsData.count == 0) {
            let spinner = UIActivityIndicatorView(style: .medium)
            spinner.startAnimating()
            headLinesTableView.backgroundView = spinner
            
            headLinesTableView.separatorStyle = .none
            
            DispatchQueue.main.async {
                Thread.sleep(forTimeInterval: 1)
                
                OperationQueue.main.addOperation() {
                    spinner.stopAnimating()
                    self.headLinesTableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func toggleMenu(_ sender: UIBarButtonItem) {
        guard let hamburgerMenuViewController = self.storyboard?.instantiateViewController(identifier: "HamburgerMenuViewController") as? HamburgerMenuViewController else {return}
        hamburgerMenuViewController.didTapMenuType = { menuType in
            self.transitionToNew(menuType)
        }
        hamburgerMenuViewController.modalPresentationStyle = .overCurrentContext
        hamburgerMenuViewController.transitioningDelegate = self
        present(hamburgerMenuViewController, animated: true)
        
    }
    
    func transitionToNew(_ menuType : MenuType){
        
        topView?.removeFromSuperview()
        switch menuType {
        case .about:
            guard let aboutHamburgerMenuVC = self.storyboard?.instantiateViewController(identifier: "AboutHamburgerMenuViewController") else {return}
            self.navigationController?.pushViewController(aboutHamburgerMenuVC, animated: true)
            
        case .contactUs:
            let webVC = self.storyboard?.instantiateViewController(withIdentifier: "webview") as? WebViewViewController
            webVC?.modalPresentationStyle = UIDevice.current.userInterfaceIdiom == .phone ? .fullScreen : .formSheet
            webVC?.recievedUrl = "https://www.linkedin.com/in/ashishk161/"
            self.navigationController?.pushViewController(webVC! , animated: true)
            
        case .feedback:
            let mailComposeViewController = configureMailController()
            if MFMailComposeViewController.canSendMail(){
                self.present(mailComposeViewController, animated: true, completion: nil)
            }else
            {
                showMailError()
            }
        }
        
    }
}

//MARK: - MailComposition Methods
extension HeadLinesViewController : MFMailComposeViewControllerDelegate{
    func configureMailController()-> MFMailComposeViewController{
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["contactashish161@gmail.com"])
        mailComposerVC.setSubject("FeedBack")
        mailComposerVC.setMessageBody("Feedback for improvemnts", isHTML: false)
        return mailComposerVC
    }
    
    func showMailError(){
        let sendMailErrorAlert = UIAlertController(title: "Could not send mail", message: "Your device could not sent mail,Plzz try again!!!", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "OK", style: .default, handler: nil)
        sendMailErrorAlert.addAction(dismiss)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let err = error{
            print(err.localizedDescription)
            controller.dismiss(animated: true, completion: nil)
        }
        
        switch result {
        case .saved:
            print("Saved")
        case .cancelled:
            print("Cancelled")
        case .failed:
            print("Failed")
        case .sent:
            print("Sent")
         default:
            print("Not a matching case")
        }
        controller.dismiss(animated: true, completion: nil)
    }
}


//MARK: - SlideInTransition Animation Methods
extension HeadLinesViewController : UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
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

//MARK: - Table View Methods
extension HeadLinesViewController: UITableViewDataSource ,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = headLinesTableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
        cell.NewsTitleLabel.text = newsData[indexPath.row].title
        cell.NewsPublishedAtLabel.text = newsData[indexPath.row].publishedAt
        cell.NewsAuthorLabel.text = newsData[indexPath.row].author
        
        if let imageUrl = URL(string: "\(newsData[indexPath.row].urlToImage ?? "No image URL found")"){
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
        headLinesTableView.deselectRow(at: indexPath, animated: true)
        let vc = self.storyboard?.instantiateViewController(identifier: "AboutHeadlinesViewController") as? AboutHeadlinesViewController
        vc?.recievedNewsItem = newsData[indexPath.row]
        let navVC = UINavigationController(rootViewController: vc!)
        navVC.isNavigationBarHidden = true
        navVC.modalPresentationStyle = UIDevice.current.userInterfaceIdiom == .phone ? .fullScreen : .formSheet
        self.navigationController?.present(navVC, animated: true, completion: nil)
    }
    
}
