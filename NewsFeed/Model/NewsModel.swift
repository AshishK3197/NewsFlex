//
//  NewsModel.swift
//  NewsFeed
//
//  Created by Ashish Kumar on 14/02/20.
//  Copyright © 2020 Ashish Kumar. All rights reserved.
//

import Foundation

struct NewsModel:Codable {
    let newsArticles : [Article]
}

struct Article:Codable {
    let author: String
    let title: String
    let urlToImage: String
    let publishedAt: Date
    let content: String
}
