//
//  Networking.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 28/06/21.
//

import Foundation


struct NetworkResponse <T: Decodable>: Decodable{
    let success: Bool
    let data: [T]?
}

enum HTTPMethods: Int,CaseIterable,CustomStringConvertible {
  case get
  case post
  case delete
  case put
    
    var description: String{
        switch self {
        case .get:
            return "GET"
            
        case .post:
            return "POST"
        
        case .delete:
            return "DELETE"
        
        case .put:
            return "PUT"
        }
    }
}




struct Networking{
    
    fileprivate let articlesURL = "https://app.themitpost.com/posts"
    fileprivate let noticesURL = "https://app.themitpost.com/notices"
    fileprivate let instaURL = "https://app.themitpost.com/social/instagram/posts"
    fileprivate let magazineURL = "https://app.themitpost.com/magazines"
    fileprivate let eventsURL = "https://app.themitpost.com/events"
    let twitterFollowURL = "https://twitter.com/themitpost"
    let instaFollowURL = "https://www.instagram.com/themitpost/"
    
    //SLCM
    fileprivate let  attendanceDatabaseReferenceURL =
        "https://app.themitpost.com/slcm/attendance";
    fileprivate let captchaServingURL =
        "https://app.themitpost.com/slcm/captcha";
    
    static let sharedInstance = Networking()
    
    func getArticleData(method : String ,dataCompletion: @escaping (_ Data: [ArticleModel]) -> (),  errorCompletion: @escaping (_ ErrorMessage: Error) -> ()){
        
        
        guard let url = URL(string: articlesURL) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            if let err = error {
                errorCompletion(err)
                print(err.localizedDescription)
                return
            }
            guard response != nil, let data = data else {
                return
            }
            let responseObject = try! JSONDecoder().decode([ArticleModel].self, from: data)

            DispatchQueue.main.async {
                dataCompletion(responseObject)
            }
        }
        dataTask.resume()
    }
    
    func getNoticeData(method : String ,dataCompletion: @escaping (_ Data: [Notice]) -> (),  errorCompletion: @escaping (_ ErrorMessage: Error) -> ()){
        
        guard let url = URL(string: noticesURL) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            if let err = error {
                errorCompletion(err)
                print(err.localizedDescription)
                return
            }
            guard response != nil, let data = data else {
                return
            }
            let responseObject = try! JSONDecoder().decode(NoticeResponse.self, from: data)
            

            DispatchQueue.main.async {
                dataCompletion(responseObject.data)
            }
        }
        dataTask.resume()
    }
    
    func getInstagramData(method : String ,dataCompletion: @escaping (_ Data: [Instagram]) -> (),  errorCompletion: @escaping (_ ErrorMessage: Error) -> ()){
        
        guard let url = URL(string: instaURL) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            if let err = error {
                errorCompletion(err)
                print(err.localizedDescription)
                return
            }
            guard response != nil, let data = data else {
                return
            }
            
            do { let responseObject = try JSONDecoder().decode([Instagram].self, from: data)
                DispatchQueue.main.async {
                    dataCompletion(responseObject)
                }

            } catch {print("Caught error: \(error)")}
            
        }
        dataTask.resume()
    }
    
    func getMagazineData(method : String ,dataCompletion: @escaping (_ Data: Magazines) -> (),  errorCompletion: @escaping (_ ErrorMessage: Error) -> ()){
        
        guard let url = URL(string: magazineURL) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            if let err = error {
                errorCompletion(err)
                print(err.localizedDescription)
                return
            }
            guard response != nil, let data = data else {
                return
            }
            let responseObject = try! JSONDecoder().decode(Magazines.self, from: data)
            

            DispatchQueue.main.async {
                dataCompletion(responseObject)
            }
        }
        dataTask.resume()
    }
    
    func getEventData(method : String ,dataCompletion: @escaping (_ Data: Magazines) -> (),  errorCompletion: @escaping (_ ErrorMessage: Error) -> ()){
        
        guard let url = URL(string: magazineURL) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            if let err = error {
                errorCompletion(err)
                print(err.localizedDescription)
                return
            }
            guard response != nil, let data = data else {
                return
            }
            let responseObject = try! JSONDecoder().decode(Magazines.self, from: data)
            

            DispatchQueue.main.async {
                dataCompletion(responseObject)
            }
        }
        dataTask.resume()
    }
    
    func getCaptchaData(method : String ,dataCompletion: @escaping (_ Data: CaptchaModel) -> (),  errorCompletion: @escaping (_ ErrorMessage: Error) -> ()){
        
        guard let url = URL(string: captchaServingURL) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            if let err = error {
                errorCompletion(err)
                print(err.localizedDescription)
                return
            }
            
            guard response != nil, let data = data else {
                return
            }
            
            do { let responseObject = try JSONDecoder().decode(CaptchaModel.self, from: data)
                DispatchQueue.main.async {
                    dataCompletion(responseObject)
                }

            } catch {print("Caught error: \(error)")}
        }
        dataTask.resume()
    }
    
    func getSLCMData(method : String ,id :String, token: String, registration : String, password:String ,dataCompletion: @escaping (_ Data: SlcmData?) -> (),  errorCompletion: @escaping (_ ErrorMessage: Error) -> ()){
        
        
        let parameters: [String: Any] = [
            "id":id,
            "token":token,
            "registration":registration,
            "password":password
        ]
        
        guard let url = URL(string: attendanceDatabaseReferenceURL) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        
        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            } catch let error {
                print(error.localizedDescription)
            }
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            if let err = error {
                errorCompletion(err)
                print(err.localizedDescription)
                return
            }
            guard response != nil, let data = data else {
                return
            }
            let responseObject = try! JSONDecoder().decode(SlcmResponse.self, from: data)
           // print(responseObject.success)
            //print(responseObject.msg)

            DispatchQueue.main.async {
                dataCompletion(responseObject.data)
            }
        }
        dataTask.resume()
    }
}
        
    





