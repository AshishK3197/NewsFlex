//
//  ApiManager.swift
//  NewsFeed
//
//  Created by Ashish Kumar on 24/09/20.
//  Copyright © 2020 Ashish Kumar. All rights reserved.
//

import Foundation

struct ApiManager {
    
    private let httpUtility = HttpUtility()
    
    /// Function responsible for getting JSON Data.
    /// - Parameters:
    ///   - request: Input Parameter for Request Type.
    ///   - completionHandler: Completion Handler of escaping type with specific result of NewsModel and Error type.
    func getJSONDataFromUrl(request: NewsRequest , completionHandler: @escaping (_ result: NewsModel?, _ Error: Error?)-> Void){
        
        let url : URL = request.finalUrl!
        
        httpUtility.getApiData(requestUrl: url, resultType: NewsModel.self) { (response) in
            _ = completionHandler(response,nil)
        }
   
    }
    
    /// Function responsible for getting JSON Data for categorising News Articles.
    /// - Parameters:
    ///   - request: Input Parameter for Request Type.
    ///   - completionHandler: Completion Handler of escaping type with specific result of Source Model and Error type.
    func getCategorisationData(request: NewsRequest,completionHandler: @escaping (_ result: Sources?, _ error : Error?)-> Void){

        let url : URL = request.finalUrl!

        httpUtility.getApiData(requestUrl: url, resultType: Sources.self) { (response) in
            _ = completionHandler(response,nil)
        }

    }
}








