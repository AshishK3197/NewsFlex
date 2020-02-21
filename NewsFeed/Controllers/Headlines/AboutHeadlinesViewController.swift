//
//  AboutHeadlinesViewController.swift
//  NewsFeed
//
//  Created by Ashish Kumar on 14/02/20.
//  Copyright © 2020 Ashish Kumar. All rights reserved.
//

import UIKit

class AboutHeadlinesViewController: UIViewController {
    @IBOutlet weak var passedImage: UIImageView!
    @IBOutlet weak var passedTitle: UILabel!
    @IBOutlet weak var passedAuthor: UILabel!
    @IBOutlet weak var passedPublishedAt: UILabel!
    @IBOutlet weak var passedContent: UILabel!
    
    
    var passedTitleText = String()
    var passedAuthorText = String()
    var passedContentText = String()
    var passedPublishedAtText = String()
    var passedImageView = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passedTitle.text = passedTitleText
//        passedImage.image = passedImageView
        passedAuthor.text = passedAuthorText
        passedPublishedAt.text = passedPublishedAtText
        passedContent.text = passedContentText
    }

    

}
