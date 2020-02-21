//
//  NewsTableViewCell.swift
//  NewsFeed
//
//  Created by Ashish Kumar on 21/02/20.
//  Copyright © 2020 Ashish Kumar. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var publishedAtLabel: UILabel!
    @IBOutlet weak var NewsLabel: UILabel!
    @IBOutlet weak var loadedImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
