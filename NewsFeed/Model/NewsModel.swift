//
//  NewsModel.swift
//  NewsFeed
//
//  Created by Ashish Kumar on 24/09/20.
//  Copyright © 2020 Ashish Kumar. All rights reserved.
//

import Foundation


//This is similar to NewsResponse what we get back from the server.
struct NewsModel:Decodable {
    let articles : [Article]
}

struct Article:Decodable {
    let author: String?
    let title: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}
