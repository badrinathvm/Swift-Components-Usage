//
//  NetworkService.swift
//  SwiftComponents
//
//  Created by Badrinath on 8/26/17.
//  Copyright © 2017 Badrinath. All rights reserved.
//

import Foundation
import Alamofire

class NetworkService {
    
    lazy var configuration: URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session: URLSession = URLSession(configuration: self.configuration)
    
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    
    typealias ImageDataHandler = ((Data) -> Void)
    
    func downloadImage(_ completion: @escaping ImageDataHandler)
    {
        let request = URLRequest(url: self.url)
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
            
            if error == nil {
                if let httpResponse = response as? HTTPURLResponse {
                    switch (httpResponse.statusCode) {
                    case 200:
                        if let data = data {
                            completion(data)
                        }
                    default:
                        print(httpResponse.statusCode)
                    }
                }
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        })
        
        dataTask.resume()
    }
    
    func makeAuthCall(method: HTTPMethod){
        
        let body:Parameters = [
            "client_id": "ZNbFDXmZFggx4aLO7RPObQ",
            "client_secret" : "t6IB1HvSsZ3VfbVWCjETbhsQKtgjkxEuTo0zK5ZogwmAXjeMamtipUTQwDkb38hk",
            "grant_type": "client_credentials",
            "content-type":"application/x-www-form-urlencoded"
        ]
        
        let headers:HTTPHeaders = [
           "content-type":"application/x-www-form-urlencoded"
        ]

        
        Alamofire.request(self.url, method: method, parameters: body, encoding: URLEncoding(), headers: headers).responseJSON { response in
            
              // print(response.result.value!)
            
            //to get status code
            if let status = response.response?.statusCode {
                switch(status){
                case 200:
                    
                    print("Success Status")
                    
                    if let result = response.result.value {
                        let JSON = result as! NSDictionary
                        print(JSON["access_token"]!)
                        
                        let tokenObject = Token(token: JSON["access_token"] as! String)
                        
                    }
                    
                default:
                    print("error with response status: \(status)")
                }
            }
            
        }
    }
    
    
}

extension NetworkService
{
    static func parseJSONFromData(_ jsonData: Data?) -> [String : AnyObject]?
    {
        if let data = jsonData {
            do {
                let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : AnyObject]
                return jsonDictionary
                
            } catch let error as NSError {
                print("error processing json data: \(error.localizedDescription)")
            }
        }
        
        return nil
    }
}





















