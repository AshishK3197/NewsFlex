//
//  NewsTableViewCell.swift
//  NewsFeed
//
//  Created by Ashish Kumar on 24/09/20.
//  Copyright © 2020 Ashish Kumar. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var NewsPublishedAtLabel: UILabel!
    @IBOutlet weak var NewsTitleLabel: UILabel!
    @IBOutlet weak var NewsImageView: UIImageView!
    @IBOutlet weak var NewsAuthorLabel: UILabel!
    
    var newsData : Article? {
        didSet{
            cellConfiguration()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear // very important
        layer.masksToBounds = false
        layer.shadowOpacity = 0.69
        layer.shadowRadius = 6
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.black.cgColor
    }
    
   required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        let radius = self.contentView.layer.cornerRadius
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: radius).cgPath
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cellConfiguration(){
        if let title = newsData?.title,let authorName = newsData?.author,let publishedAt = newsData?.publishedAt{
            NewsTitleLabel.text = title
            NewsPublishedAtLabel.text = publishedAt
            NewsAuthorLabel.text = authorName
            
            
            if let imageUrl = URL(string: "\(newsData?.urlToImage ?? "No image URL found")"){
                URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                    if let imageData = data{
                        DispatchQueue.main.async {
                            self.NewsImageView.image = UIImage(data: imageData)
                        }
                    }
                }.resume()
            }
        }else{
            NewsTitleLabel.text = "no title found"
            NewsPublishedAtLabel.text = " no publishedAt found"
            NewsAuthorLabel.text = "no authorName found"
        }
    }
    
}
