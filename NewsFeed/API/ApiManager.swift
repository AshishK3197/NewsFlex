//
//  ApiManager.swift
//  NewsFeed
//
//  Created by Ashish Kumar on 14/02/20.
//  Copyright © 2020 Ashish Kumar. All rights reserved.
//

import Foundation

struct ApiManager {
    
    private let httpUtility = HttpUtility()
    
    func getJSONDataFromUrl(request: NewsRequest , completionHandler: @escaping (_ result: NewsModel?, _ Error: Error?)-> Void){
        
        let url : URL = request.finalUrl!
        
        httpUtility.getApiData(requestUrl: url, resultType: NewsModel.self) { (response) in
            _ = completionHandler(response,nil)
        }
        
        
        
       
    }
}








