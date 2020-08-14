//
//  AboutHeadlinesViewController.swift
//  NewsFeed
//
//  Created by Ashish Kumar on 14/02/20.
//  Copyright © 2020 Ashish Kumar. All rights reserved.
//

import UIKit

class AboutHeadlinesViewController: UIViewController{
    
    //MARK: - Variable Declaration
    var recievedNewsImage: UIImage?
    
    var recievedNewsItem : Article?
    
    //MARK: - IBOutlets
    @IBOutlet weak var newsImageView: UIImageView!{
        willSet{
            if let imageUrl = URL(string: "\(recievedNewsItem?.urlToImage ?? "No image URL found")"){
                URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                    if let imageData = data{
                        DispatchQueue.main.async {
                            self.newsImageView.image = UIImage(data: imageData)
                        }
                    }
                }.resume()
            }
        }
        didSet{
            newsImageView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var newsTitleLabel: UILabel!{
        didSet{
            newsTitleLabel.text = recievedNewsItem?.title
            newsTitleLabel.alpha = 0.0 // Alpha value is set to 0 so that animation in viewWillAppear() is used to animate transition and text before animation remains totally transparent
        }
    }
    
    @IBOutlet weak var contextTextView: UITextView!{
        didSet{
            contextTextView.text = recievedNewsItem?.content
            contextTextView.alpha = 0.0
            contextTextView.font = UIFont.preferredFont(forTextStyle: .subheadline)
            contextTextView.sizeToFit()
        }
    }
    
    @IBOutlet weak var shareButton: UIButton!{
        didSet{
            shareButton.layer.shadowColor = UIColor.black.cgColor
            shareButton.layer.shadowRadius = 2.0
            shareButton.layer.shadowOpacity = 1.0
            shareButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        }
    }
    @IBOutlet weak var backButton: UIButton!{
        didSet{
            backButton.layer.shadowColor = UIColor.black.cgColor
            backButton.layer.shadowRadius = 2.0
            backButton.layer.shadowOpacity = 1.0
            backButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        }
    }
    @IBOutlet weak var newsAuthorLabel: UILabel!{
        didSet{
            newsAuthorLabel.text = recievedNewsItem?.author
            newsAuthorLabel.alpha = 0.0
        }
    }
   
    @IBOutlet weak var readMoreLinkButton: UIButton!{
        didSet{
            readMoreLinkButton.layer.cornerRadius = 10.0
            readMoreLinkButton.setTitle("Read Full Story", for: .normal)
        }
    }
    
    @IBAction func readMoreLinkButton(_ sender: UIButton) {
        
        let webVC = self.storyboard?.instantiateViewController(withIdentifier: "webview") as? WebViewViewController
        webVC?.modalPresentationStyle = .formSheet
        webVC?.recievedUrl = recievedNewsItem?.url
        self.navigationController?.pushViewController(webVC!, animated: true)
    }
    
    @IBAction func shareButton(_ sender: UIButton) {
        fadeUIElements(with: 0.0)
        
        let delay = DispatchTime.now() + 0.11
        DispatchQueue.main.asyncAfter(deadline: delay) {
            guard let shareURL = self.recievedNewsItem?.url else {return}
                let articleImage = self.captureScreenShot()
                
                
            let activityVC = UIActivityViewController(activityItems: [shareURL, articleImage!], applicationActivities: nil)
            
            activityVC.excludedActivityTypes = [.assignToContact,
                                                .postToTencentWeibo,
                                                .postToVimeo,
                                                .print,
                                                .postToWeibo]
            
            activityVC.completionWithItemsHandler = {(activityType, completed: Bool, _, _) in
                self.fadeUIElements(with: 1.0)
            }
            let popOver = activityVC.popoverPresentationController
            popOver?.sourceView = self.shareButton
            popOver?.sourceRect = self.shareButton.bounds
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    // Helper to toggle UI elements before and after screenshot capture
    func fadeUIElements(with alpha: CGFloat) {
        UIView.animate(withDuration: 0.1) {
            self.backButton.alpha = alpha
            self.shareButton.alpha = alpha
        }
    }
    
    // Helper method to generate article screenshots
    func captureScreenShot() -> UIImage? {
        //Create the UIImage
        let bounds = UIScreen.main.bounds
        UIGraphicsBeginImageContextWithOptions(bounds.size, true, 0.0)
        self.view.drawHierarchy(in: bounds, afterScreenUpdates: false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
        
    }
    
    
    @IBAction func dismissBackButton(_ sender: UIButton) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil;
        navigationController?.setNavigationBarHidden(true, animated: true)
        newsImageView.addGradient([UIColor(white: 0, alpha: 0.6).cgColor, UIColor.clear.cgColor,
         UIColor(white: 0, alpha: 0.6).cgColor],
        locations: [0.0, 0.05, 0.85])
    }
    
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
           newsTitleLabel.center.y += 20
           newsAuthorLabel.center.y += 20
           contextTextView.center.y += 20

           UIView.animate(withDuration: 0.07, delay: 0.0, options: .curveEaseIn, animations: {
               self.newsTitleLabel.alpha = 1.0
               self.newsTitleLabel.center.y -= 20
               self.newsAuthorLabel.alpha = 1.0
               self.newsAuthorLabel.center.y -= 20
           })
           UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {
               self.contextTextView.center.y -= 20
               self.contextTextView.alpha = 1.0
           })
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
}

extension UIImageView {

    func addGradient(_ color: [CGColor], locations: [NSNumber]) {

        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.superview!.frame
        gradient.colors = color
        gradient.locations = locations
        self.layer.addSublayer(gradient)
    }
}
