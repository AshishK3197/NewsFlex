//
//  NewsRequest.swift
//  NewsFeed
//
//  Created by Ashish Kumar on 31/05/20.
//  Copyright © 2020 Ashish Kumar. All rights reserved.
//

import Foundation

enum NewsRequest{
    case headLines
    case country (country: String)
    case category(category: String)
    case sources(source: String)
    
    
    var finalUrl: URL?{
        switch self {
        case .headLines:
            EndPoints.baseURL?.path = "/v2/top-headlines"
            EndPoints.baseURL?.queryItems = [URLQueryItem(name: "country", value: "in"),
                                             URLQueryItem(name: "apiKey", value: EndPoints.apiKey)]
            guard let finalUrl = EndPoints.baseURL?.url else {return nil}
            print(finalUrl)
            return finalUrl
            
        case .country(let country):
            EndPoints.baseURL?.path = "/v2/top-headlines"
            EndPoints.baseURL?.queryItems = [URLQueryItem(name: "country", value: country),
                                             URLQueryItem(name: "apiKey", value: EndPoints.apiKey)]
            guard let finalUrl = EndPoints.baseURL?.url else {return nil}
            print(finalUrl)
            return finalUrl
            
        case .category(let category):
            EndPoints.baseURL?.queryItems = [URLQueryItem(name: "category", value: category),
                                             URLQueryItem(name: "apiKey", value: EndPoints.apiKey)]
            guard let finalUrl = EndPoints.baseURL?.url else {return nil}
            print(finalUrl)
            return finalUrl
            
        case .sources(let source):
            EndPoints.baseURL?.path = "/v2/top-headlines"
            EndPoints.baseURL?.queryItems = [URLQueryItem(name: "sources", value: source),
                                             URLQueryItem(name: "apiKey", value: EndPoints.apiKey)]
            guard let finalUrl = EndPoints.baseURL?.url else {return nil}
            print(finalUrl)
            return finalUrl
        }
    }
}
