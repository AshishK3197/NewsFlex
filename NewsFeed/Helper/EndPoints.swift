//
//  EndPoints.swift
//  NewsFeed
//
//  Created by Ashish Kumar on 24/09/20.
//  Copyright © 2020 Ashish Kumar. All rights reserved.
//

import Foundation

struct EndPoints {
    
//    let headlinesNewsUrl = "https://newsapi.org/v2/top-headlines?sources=google-news&apiKey=6a82e1fdb4014b6f8ae30519be253030"
//    let indiaNewsUrl = "https://newsapi.org/v2/top-headlines?country=in&apiKey=6a82e1fdb4014b6f8ae30519be253030"
    static let apiKey = "6a82e1fdb4014b6f8ae30519be253030"
    static var baseURL = URLComponents(string: "https://newsapi.org")
    static let categorizationURL = "https://newsapi.org/v2/sources?category&language&country&apiKey=8e58842e74f2453bb5e6e3845b386a81"
}
