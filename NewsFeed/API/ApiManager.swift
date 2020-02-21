//
//  ApiManager.swift
//  NewsFeed
//
//  Created by Ashish Kumar on 14/02/20.
//  Copyright © 2020 Ashish Kumar. All rights reserved.
//

import Foundation

class ApiManager{
    
    let headlinesNewsUrl = "https://newsapi.org/v2/top-headlines?sources=google-news&apiKey=6a82e1fdb4014b6f8ae30519be253030"
    let indiaNewsUrl = ""
    
    func getJSONFromUrl(urlString: String , completion: @escaping (Data? , Error?)-> Void){
        if let url = URL(string: urlString){
            let urlRequest = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: urlRequest) {(data ,response, error)  in
                if let err = error{
                    print(err.localizedDescription)
                    completion(nil,err)
                }
                if let responseData = data{
                    print("Data recieved : \(responseData)")
                    completion(responseData, nil)
                }
                
            }
            task.resume()
        }
    }
    
    func parseJSON(json: Data , completion: @escaping (NewsModel? , Error?)-> Void){
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(NewsModel.self, from: json)
//            print(decodedData.articles[0].title)
            completion(decodedData, nil)
        } catch let err{
            print("Error creating NewsModel object from json responseData \(err)")
            completion(nil,err)
        }
    }
    

    func fetchNews(completion: @escaping (NewsModel? , Error?)->Void){
        getJSONFromUrl(urlString: headlinesNewsUrl) { (data, error) in
            if let err = error{
                print(err.localizedDescription)
                completion(nil, err)
            }
            if let data = data{
                self.parseJSON(json: data) { (newsData, error) in
                    if let err = error{
                        print("Failed to get Data")
                        completion(nil , err)
                    }else{
                        completion(newsData,nil)
                    }
                }
            }
        }
    }
    
//    func fetchNews()->NewsModel{
//        getJSONFromUrl(urlString: newsUrl) { (data, error) in
//            if let err = error{
//                print(err.localizedDescription)
//            }
//            if let data = data{
//               let weather = self.parseJSON(json: data) { (newsData, error) in
//                    if let err = error{
//                        print(err.localizedDescription)
//                    }
//                }
//            }
//        }
//    }
    
    
    
}
