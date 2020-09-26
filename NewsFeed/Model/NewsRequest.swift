//
//  NewsRequest.swift
//  NewsFeed
//
//  Created by Ashish Kumar on 24/09/20.
//  Copyright © 2020 Ashish Kumar. All rights reserved.
//

import Foundation

enum NewsRequest{
    case country (country: String)
    case category(category: String)
    case sources(source: String)
    case categorizationData
    
    
    var finalUrl: URL?{
        switch self {
        case .country(let country):
            EndPoints.baseURL?.path = "/v2/top-headlines"
            EndPoints.baseURL?.queryItems = [URLQueryItem(name: "language", value: "en"),
                                             URLQueryItem(name: "country", value: country),
                                             URLQueryItem(name: "apiKey", value: EndPoints.apiKey)]
            guard let finalUrl = EndPoints.baseURL?.url else {return nil}
            return finalUrl
            
        case .category(let category):
            EndPoints.baseURL?.path = "/v2/top-headlines"
            EndPoints.baseURL?.queryItems = [URLQueryItem(name: "country", value: "us"),
                                            URLQueryItem(name: "category", value: category),
                                             URLQueryItem(name: "apiKey", value: EndPoints.apiKey)]
            guard let finalUrl = EndPoints.baseURL?.url else {return nil}
            return finalUrl
            
        case .sources(let source):
            EndPoints.baseURL?.path = "/v2/top-headlines"
            EndPoints.baseURL?.queryItems = [URLQueryItem(name: "sources", value: source),
                                             URLQueryItem(name: "apiKey", value: EndPoints.apiKey)]
            guard let finalUrl = EndPoints.baseURL?.url else {return nil}
            return finalUrl
            
        case .categorizationData:
            EndPoints.baseURL?.path = "/v2/sources"
            EndPoints.baseURL?.queryItems = [
            URLQueryItem(name: "category", value: nil),
            URLQueryItem(name: "language", value: nil),
            URLQueryItem(name: "country", value: nil),
            URLQueryItem(name: "apiKey", value: EndPoints.apiKey)]
            guard let finalUrl = EndPoints.baseURL?.url else {return nil}
            return finalUrl
        }
    }
}
