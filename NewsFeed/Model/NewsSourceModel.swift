//
//  NewsSourceModel.swift
//  NewsFeed
//
//  Created by Ashish Kumar on 24/09/20.
//  Copyright © 2020 Ashish Kumar. All rights reserved.
//

import Foundation

struct Sources: Decodable {
    public let sources: [NewsSourceModel]
}

struct NewsSourceModel: Decodable {
    public let sid: String
    public let name: String
    public let category: String
    public let description: String
    public let isoLanguageCode: String
    public let country: String
    
    private enum CodingKeys: String, CodingKey {
        case sid = "id"
        case name, category, description, country
        case isoLanguageCode = "language"
    }
}
