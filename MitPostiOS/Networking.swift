//
//  Networking.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 28/06/21.
//

import Foundation
import Alamofire


struct NetworkResponse <T: Decodable>: Decodable{
    let success: Bool
    let data: [T]?
}

fileprivate let articlesURL = "https://app.themitpost.com/posts"

struct Networking{
    
    fileprivate let articlesURL = "https://app.themitpost.com/posts"
    
    static let sharedInstance = Networking()
    
    func getArticleData(dataCompletion: @escaping (_ Data: [ArticleModel]) -> (),  errorCompletion: @escaping (_ ErrorMessage: String) -> ()){
        
//        AF.request(articlesURL, method: .get, parameters: nil, encoding: URLEncoding()).response { response in
//            if let data = response{
//                do{
//                    let resultsResponse = try JSONDecoder().decode(ArticleModel.self, from: data)
//                            dataCompletion(resultsResponse)
//                        }
//
//            };catch var error: Error{
//                    print(error)
//                    errorCompletion("Decoding Error in getting Schedule(Networking)")
//                }
//            }
//        }
    }
}
        
    





