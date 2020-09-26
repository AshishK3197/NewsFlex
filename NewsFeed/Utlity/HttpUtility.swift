//
//  HttpUtility.swift
//  MyProject
//
//  Created by CodeCat15 on 24/09/20.
//  Copyright © 2020 CodeCat15. All rights reserved.
//

import Foundation

struct HttpUtility
{
    /// Generic function responsible for creating a dataTask with the help of URL and a completion Handler for getting results asynchronously.
    /// - Parameters:
    ///   - requestUrl: A request URL for feeding in the request for fetching JSOn Data.
    ///   - resultType: Input Parameter for decoding the JSON Data with respect to the specific Model Type.
    ///   - completionHandler: Completion Handler of escaping type with specific result type.
    func getApiData<T:Decodable>(requestUrl: URL,resultType: T.Type, completionHandler:@escaping(_ result: T?)-> Void)
    {
        URLSession.shared.dataTask(with: requestUrl) { (responseData, httpUrlResponse, error) in
            if(error == nil && responseData != nil && responseData?.count != 0)
            {
                //parse the responseData here
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(T.self, from: responseData!)
                    _=completionHandler(result)
                }
                catch let error{
                    debugPrint("error occured while decoding = \(error)")
                }
            }

        }.resume()
    }
}
